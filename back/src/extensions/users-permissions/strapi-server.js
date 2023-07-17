const { sanitize } = require('@strapi/utils');
let bcrypt = require("bcryptjs");
let geolib = require("geolib");
const { Client } = require('@googlemaps/google-maps-services-js');
const { STRIPE_PUBLIC_KEY, STRIPE_SECRET_KEY, STRIPE_URL, STRIPE_ID_CLIENT, STRIPE_WEBHOOK_SECRET, REMOTE_URL } = process.env;
const stripe = require('stripe')(STRIPE_SECRET_KEY);
const unparsed = require("koa-body/unparsed.js");
module.exports = (plugin) => {

	plugin.controllers.user.getOTP = async (ctx) => {

		//obtengo el email del body 

		const { email } = ctx.request.body;

		// busco el usuario por email y verifico que exista


		const entity = await strapi.db.query('plugin::users-permissions.user').findOne({
			where: { email: email },
			// populo todos los	campos de la tabla
			populate: true
		})

		console.log(entity)

		// si no hay usuario retorno un error 404 

		if (!entity) {
			return ctx.notFound('No se encontró el usuario');
		}


		// si el usuario no esta activo retorno un error 403


		if (entity.blocked) {

			return ctx.forbidden('El usuario está bloqueado');

		}


		// genero un codigo de 6 digitos

		const digits = '0123456789';
		let OTP = '';
		for (let i = 0; i < 6; i++) {
			OTP += digits[Math.floor(Math.random() * 10)];
		}

		// creo una marca de tiempo para que sea la exporacion del codigo de la forma 01/01/2021 00:00:00 , tomando en cuenta la zona horaria del servidor la hora actual mas 20 minutos


		const date = new Date();

		date.setMinutes(date.getMinutes() + 10);

		const expiration = date;

		// actualizo el usuario con la marca de tiempo de expiracion del codigo

		await strapi.entityService.update("plugin::users-permissions.user", entity.id, {
			data: {
				otp: {
					number: OTP,
					expiration: expiration,

				}
			},

		})


		// envio el codigo por email

		const emailData = {

			to: entity.email,

			//salto el from escribo los textos en ingles

			from: '',

			subject: 'Verification	code',

			text: `Your verification code is ${OTP} and will expire at ${expiration}`,

			html: `Your verification code is ${OTP} and will expire at ${expiration}`

		};

		await strapi.plugins['email'].services.email.send(emailData);






		return ctx.send({ message: 'Email sent' });
	}


	plugin.controllers.user.verifyOTP = async (ctx) => {

		//obtengo el email del body

		const { email, otp } = ctx.request.body;

		// busco el usuario por email y verifico que exista

		const entity = await strapi.db.query('plugin::users-permissions.user').findOne({
			where: { email: email },
			populate: { otp: true }
		})

		// si no hay usuario retorno un error 404

		if (!entity) {

			return ctx.notFound('No se encontró el usuario');

		}


		// si el usuario no esta activo retorno un error 403

		if (entity.blocked) {

			console.log('El usuario está bloqueado')

			return ctx.forbidden('El usuario está bloqueado');

		}



		// verifico el que el otp de la base de datos sea igual al que se envio en el body Y que la fecha de expiracion sea mayor a la fecha actual

		let expiracion = new Date(entity.otp.expiration)

		let now = new Date()

		console.log('expiracion', expiracion)

		console.log('now', now)

		// comparo las fechas






		if (entity.otp.number == otp && expiracion > new Date()) {

			// si es correcto lo quito de la base de datos

			await strapi.entityService.update("plugin::users-permissions.user", entity.id, {

				data: {

					otp: {
						number: entity.otp.number,
						expiration: expiracion,
						status: true
					}

				},

			})

			// retorno un mensaje de exito 200


			return ctx.send({ message: 'Success' });





		}


		// si no es correcto retorno un error 403
		console.log('Invalid otp', entity.otp.number)
		console.log('Invalid code', otp)
		return ctx.forbidden('Invalid code', { message: 'Invalid code or expiratio ' });

	}

	plugin.controllers.user.otpChangePassword = async (ctx) => {

		//obtengo el email del body

		let { email, otp, password } = ctx.request.body;

		// busco el usuario por email y verifico que exista

		const entity = await strapi.db.query('plugin::users-permissions.user').findOne({

			where: { email: email },

			populate: { otp: true }

		})


		// si no hay usuario retorno un error 404

		if (!entity) {

			return ctx.notFound('No se encontró el usuario', { message: 'No se encontró el usuario' });

		}


		// si el usuario no esta activo retorno un error 403

		if (entity.blocked) {

			return ctx.forbidden('El usuario está bloqueado', { message: 'El usuario está bloqueado' });

		}


		// verifico el que el otp de la base de datos sea igual al que se envio en el body que su status sea true Y que la fecha de expiracion sea de las ultims 24 horas


		let expiracion = new Date(entity.otp.expiration)

		let now = new Date()

		console.log('expiracion', expiracion)

		console.log('now', now)

		// comparo las fechas

		if (entity.otp.number == otp && entity.otp.status == true && expiracion > new Date()) {

			// si es correcto lo quito de la base de datos

			// encrypto la contraseña


			password = bcrypt.hashSync(password, 10);

			console.log('hash', password)



			await strapi.entityService.update("plugin::users-permissions.user", entity.id, {

				data: {

					password: password,

					otp: null

				},

			})

			// retorno un mensaje de exito 200


			return ctx.send({ message: 'Success' });

		} else {

			// si no es correcto retorno un error 403 // traduce al ingles: No se pudo validar su solicitud, intente nuevamente


			console.log('Invalid otp', entity.otp)
			return ctx.forbidden('Error validation', { message: 'Your request could not be validated, please try again.' });


		}
		// retorno un mensaje de exito 200






	}
	async function calcularDistancia(latitudOrigen, longitudOrigen, latitudDestino, longitudDestino) {
		try {
			//la traigo de	un archivo .env
			const apiKey = process.env.API_KEY_GOOGLE_MAPS;
			const client = new Client({});

			const response = await client.distancematrix({
				params: {
					origins: [{ lat: latitudOrigen, lng: longitudOrigen }],
					destinations: [{ lat: latitudDestino, lng: longitudDestino }],
					key: apiKey,
				},
			});


			const distanciaEnMetros = response.data.rows[0].elements[0].distance.value;
			const distanciaEnKilometros = distanciaEnMetros / 1000;

			return distanciaEnKilometros;
		} catch (error) {
			console.error('Error al calcular la distancia:', error);
			throw error;
		}
	}

	plugin.controllers.user.buscarProveedores = async (ctx) => {

		try {


			let { lat, lng, distance, start, limit, price, date, time, provider_type, sortBy, hour,day } = ctx.query;

			if (!lat || !lng || !distance) {

				return ctx.badRequest('Missing parameters');

			}

			start = start ? start : 0;

			limit = limit ? limit : 10;

			sortBy = sortBy ? sortBy.toLowerCase() : 'distance';


			// reviso los filtros que me llegan por query 


			let open_disponibility = "00:00:00";
			let close_disponibility = "23:59:59";

			if (time) {
				// Colocar rangos de tiempo según el valor de time que puede ser "morning", "afternoon", "evening"
				if (time == "morning") {
					open_disponibility = "08:00:00";
					close_disponibility = "12:00:00";
				} else if (time == "afternoon") {
					open_disponibility = "12:00:00";
					close_disponibility = "17:00:00";
				} else if (time == "evening") {
					open_disponibility = "17:00:00";
					close_disponibility = "23:00:00";
				} else {
					open_disponibility = "00:00:00";
					close_disponibility = "23:59:59";
				}
			}

			// Convertir las cadenas de texto en objetos de tiempo
			let openTime = new Date(`1970-01-01T${open_disponibility}Z`);
			let closeTime = new Date(`1970-01-01T${close_disponibility}Z`);

			// Obtener la hora, minutos y segundos de los objetos de tiempo
			let openHours = openTime.getHours();
			let openMinutes = openTime.getMinutes();
			let openSeconds = openTime.getSeconds();
			let closeHours = closeTime.getHours();
			let closeMinutes = closeTime.getMinutes();
			let closeSeconds = closeTime.getSeconds();

			// Crear nuevos objetos de tiempo utilizando las horas, minutos y segundos obtenidos
			openTime = new Date(1970, 0, 1, openHours, openMinutes, openSeconds);
			closeTime = new Date(1970, 0, 1, closeHours, closeMinutes, closeSeconds);




console.log('hour',hour);
let proID = [];
if (hour != "I'm Flexible" && hour != "" && hour != undefined && hour != null ) {

let hourParts = hour.split(':');
let hours = parseInt(hourParts[0]);
let minutes = parseInt(hourParts[1].substr(0, 2));
let isPM = hourParts[1].substr(2) === 'pm';
	
	if (isPM && hours !== 12) {
			hours += 12;
	} else if (!isPM && hours === 12) {
			hours = 0;
	}


	let datex = new Date();
	datex.setHours(hours);
	datex.setMinutes(minutes);


	
const searchTime = datex.getHours() + ':' + ('0' + datex.getMinutes()).slice(-2);

// transformo day de 13-05-2023 a 2023-05-13

const dayParts = day.split('-');

day = dayParts[2] + '-' + dayParts[1] + '-' + dayParts[0];



//uno day y searchTime day tuene forma de 2021-08-12 y searchTime tiene forma de 12:00

let datetime = day + ' ' + searchTime + ':00';

console.log('datetime', datetime);



// uno searchTime con date 







proID = await strapi.db.connection.raw(`
SELECT up_users.id
FROM up_users
LEFT JOIN task_assigneds_provider_links ON up_users.id = task_assigneds_provider_links.user_id
LEFT JOIN task_assigneds ON task_assigneds_provider_links.task_assigned_id = task_assigneds.id
WHERE up_users.is_provider = true
AND ST_Distance_Sphere(POINT(up_users.lng, up_users.lat), POINT(?, ?)) < ?
AND TIME_FORMAT(up_users.open_disponibility, '%H:%i:%s') >= ?
AND TIME_FORMAT(up_users.close_disponibility, '%H:%i:%s') <= ?
AND up_users.id NOT IN (
	SELECT task_assigneds_provider_links.user_id
	FROM task_assigneds_provider_links
	 JOIN task_assigneds ON task_assigneds_provider_links.task_assigned_id = task_assigneds.id
	WHERE task_assigneds_provider_links.user_id = up_users.id
	AND DATE_FORMAT(task_assigneds.datetime, '%Y-%m-%d %H:%i:%s') = ?)

GROUP BY up_users.id
ORDER BY ST_Distance_Sphere(POINT(up_users.lng, up_users.lat), POINT(?, ?))
LIMIT ?
`, [lng, lat, 6000,  open_disponibility , close_disponibility ,datetime , lng, lat,10]);

} else {
	console.log(open_disponibility	, close_disponibility);
	proID = await strapi.db.connection.raw(`
	SELECT id
	FROM up_users
	WHERE is_provider = true
		AND ST_Distance_Sphere(POINT(lng, lat), POINT(?, ?)) < ?
		AND (TIME_FORMAT(up_users.open_disponibility, '%H:%i:%s') >= ? OR up_users.open_disponibility IS NULL)
		AND (TIME_FORMAT(up_users.close_disponibility, '%H:%i:%s') <= ? OR up_users.close_disponibility IS NULL)
	ORDER BY ST_Distance_Sphere(POINT(lng, lat), POINT(?, ?))
	LIMIT ?
`, [lng, lat, 6000, open_disponibility, close_disponibility, lng, lat, 10]);


}

console.log('proID', proID);


proID = proID[0].map(pro => pro.id);

			// busco a todos los usuarios que correspondan a los ids que me devolvio la consulta anterior usando super.Find para tener paginacion y ordenamiento

			const proveedores = await strapi.entityService.findMany('plugin::users-permissions.user', {
				filters: {
					$and:[{
						id: {
							$in:proID,
						},
					},
					{
						
						isProvider:{
							$eq:true
						},
					},
					{
						...(provider_type && { type_provider: provider_type }),
					},
					{
						
						...(price && { type_price: price }),
					}





					

					]


				},
				// no incluyo al que hace la busqueda



				start: start,
				limit: limit,
				populate: { location: true, avatar_image: true }
			});



			// segundo filtrado para saber si tienen disponibilidad 





			for (const proveedor of proveedores) {
				try {
			
					let distance = await geolib.getDistance(
						{ latitude: lat, longitude: lng },
						{ latitude: proveedor.lat, longitude: proveedor.lng }
					);

					// Convertir distancia a kilómetros
					distance = distance / 1000;

					// Redondear distancia a 2 decimales
					distance = Math.round(distance * 100) / 100;

					// Agregar distancia al objeto proveedor
					proveedor.distanceLineal = distance;

					// Calcular distancia usando Google Maps
					const distanceGoogle = await calcularDistancia(lat, lng, proveedor.lat, proveedor.lng);

					// Agregar distancia Google Maps al objeto proveedor
					proveedor.distanceGoogle = distanceGoogle;

					//elimino datos no necesarios como lo son createdAt ,	updateAt , provider ,password ,"resetPasswordToken ,confirmationToken , 

					delete proveedor.createdAt;
					delete proveedor.updatedAt;
					delete proveedor.provider;
					delete proveedor.password;
					delete proveedor.resetPasswordToken;
					delete proveedor.confirmationToken;
					delete proveedor.location.id;

					proveedor.avatar_image = proveedor.avatar_image ? proveedor.avatar_image.url : null;


				} catch (error) {
					console.error('Error al calcular la distancia:', error);
				}
			}



			// ordeno los proveedores segun el parametro sortBy que me llega por query

			if (sortBy == 'distance') {

				proveedores.sort((a, b) => a.distanceLineal - b.distanceLineal);

			} else if (sortBy == 'rating') {

				proveedores.sort((a, b) => b.scoreAverage - a.scoreAverage);

			} else if (sortBy == 'price') {


				proveedores.sort((a, b) => a.cost_per_houers - b.cost_per_houers);

			}




			//creo meta	para la paginacion




			const meta = {
				start: start,
				limit: limit,

				total: proveedores.length

			};


			return ctx.send({ data: proveedores, meta: meta });



		} catch (error) {
			console.error('Error al buscar proveedores:', error);

			return ctx.badRequest('Error al buscar proveedores');

		}



	}

	plugin.controllers.user.perfilProveedor = async (ctx) => {

		try {


			const { id } = ctx.params;

			// verifico si viene lat y lng en el query , si no vienen los seteo en null


			let { lat, lng } = ctx.query;

		// imprimo el tipo de dato de lat y lng para ver si son string o number



			if ((!lat || !lng) || (lat == 'false' || lng == 'false')) {

				lat = null;
				lng = null;

			}

			// saco el id del usuario logueado

			if (!id) return ctx.badRequest('No se envio el id del proveedor');

			const user = ctx.state.user;


			const proveedor = await strapi.entityService.findOne('plugin::users-permissions.user', id, {
				populate: { location: true, avatar_image: true }
			});


			const skills = await strapi.entityService.findMany('api::skill.skill', {

				filters: {

					user: id,

				},

				fields: ['name']


			});

			proveedor.skills = skills.map(skill => skill.name);


			//elimino datos no necesarios como lo son createdAt ,	updateAt , provider ,password ,"resetPasswordToken ,confirmationToken ,




			/*const calificaciones = await strapi.entityService.findMany('calificacion', {
				filters: {
					provider: id,
				},
				populate: { user: true }
			});*/


			//busco todas las tareas que tenga el proveedor y no estén terminadas 


			const tareas = await strapi.entityService.findMany('api::task-assigned.task-assigned', {

				filters: {

					provider: id,
					status: 'pending'
				},
				// ordeno por el campo datetime

				sort: 'datetime:asc',

				//populate: { user: true }

			});

			// elimino createdAt y updatedAt de las tareas

			tareas.forEach(tarea => {

				delete tarea.createdAt;
				delete tarea.updatedAt;

			});


			if (lat && lng) {
				console.log("entro a la condicion");
				let distance = await geolib.getDistance(
					{ latitude: lat, longitude: lng },
					{ latitude: proveedor.location.latitud, longitude: proveedor.location.longitud }
				);

				// Convertir distancia a kilómetros
				distance = distance / 1000;

				// Redondear distancia a 2 decimales
				distance = Math.round(distance * 100) / 100;

				// Agregar distancia al objeto proveedor
				proveedor.distanceLineal = distance;

				// Calcular distancia usando Google Maps
				const distanceGoogle = await calcularDistancia(lat, lng, proveedor.location.latitud, proveedor.location.longitud);

				// Agregar distancia Google Maps al objeto proveedor
				proveedor.distanceGoogle = distanceGoogle;

				//elimino datos no necesarios como lo son createdAt ,	updateAt , provider ,password ,"resetPasswordToken ,confirmationToken , 



			}
			proveedor.avatar_image = proveedor.avatar_image ? proveedor.avatar_image.url : null;



			delete proveedor.createdAt;
			delete proveedor.updatedAt;
			delete proveedor.provider;
			delete proveedor.password;
			delete proveedor.resetPasswordToken;
			delete proveedor.confirmationToken;
			delete proveedor.location;
			delete proveedor.lat;
			delete proveedor.lng;
			delete proveedor.stripe_connect_id;
			delete proveedor.stripe_customer_id;



			const horasDisponibles = getTimes(proveedor.open_disponibility, proveedor.close_disponibility);


			proveedor.car = proveedor.car ? true : false;

			proveedor.truck = proveedor.truck ? true : false;

			proveedor.motorcycle = proveedor.motorcycle ? true : false;

			proveedor.horasDisponibles = horasDisponibles;




			return ctx.send({ "proveedor": proveedor, "tareas": tareas });



		} catch (error) {
			console.error('Error al buscar proveedores:', error);

			return ctx.badRequest('Error al buscar proveedores');

		}



	}

	plugin.controllers.user.buscarProveedoresBorF = async (ctx) => {

		try {


			// saco el usuario del token

			const user = ctx.state.user;

			//verifico exista 

			if (!user) return ctx.badRequest('No se envio el usuario');


			// reviso el filtro que se mandó buscnado el diltro status


			const { status } = ctx.query;

			let proveedoresUnicos = [];

			if (status == "booked") {

				// saco los proveedores de las tareas asignadas 


				const proveedores = await strapi.entityService.findMany('api::task-assigned.task-assigned', {

					filters: {

						client: {
							id: {
								$eq: user.id
							}
						}

					},

					populate: { provider: true }

				});


				// saco los ids de los proveedores y los guardo en un array unico


				const ids = proveedores.map(proveedor => proveedor.provider.id);

				const idsUnicos = [...new Set(ids)];


				// busco los proveedores que coincidan con los ids unicos


				proveedoresUnicos = await strapi.entityService.findMany('plugin::users-permissions.user', {

					filters: {

						id: {
							$in: idsUnicos,
						},

					},

					fields: ['id', 'description', 'name', 'lastname', 'scoreAverage'],



					populate: { avatar_image: true }

				});


				// los recorro con un ciclo for para  agregar la url de la imagen


				for (const proveedor of proveedoresUnicos) {

					proveedor.avatar_image = proveedor.avatar_image ? proveedor.avatar_image.url : false;

				}




			} else {



				// busco los proovedore smarcados como favoritos


				const proveedores = await strapi.entityService.findMany('api::favorite.favorite', {

					filters: {

						user: {

							id: {

								$eq: user.id
							}
						}
					},
					populate: { favorite: true }
				});


				// saco los ids de los proveedores y los guardo en un array unico


				const ids = proveedores.map(proveedor => proveedor.favorite.id);


				const idsUnicos = [...new Set(ids)];


				// busco los proveedores que coincidan con los ids unicos


				proveedoresUnicos = await strapi.entityService.findMany('plugin::users-permissions.user', {

					filters: {

						id: {

							$in: idsUnicos,

						},

					},

					fields: ['id', 'description', 'name', 'lastname', 'scoreAverage'],

					populate: { avatar_image: true }

				});


				// los recorro con un ciclo for para  agregar la url de la imagen


				for (const proveedor of proveedoresUnicos) {

					proveedor.avatar_image = proveedor.avatar_image ? proveedor.avatar_image.url : false;

				}








			}









			return ctx.send({ data: proveedoresUnicos });



		} catch (error) {
			console.error('Error al buscar proveedores:', error);

			return ctx.badRequest('Error al buscar proveedores');

		}



	}

	plugin.controllers.user.buscarConversation = async (ctx) => {

		try {


			// saco el usuario del token

			const user = ctx.state.user;

			//verifico exista 

			if (!user) return ctx.badRequest('No se envio el usuario');


			// saco el id	del proveedor enviado como parametro

			const { id } = ctx.params;

			const {isNew} = ctx.query; 


			// busco la conversacion entre el usuario y el proveedor , recordando que en una conversacion los usuarios se	guardan en el campo users que es un array de ids de usuarios
			let conversation = [];

			if(!isNew){
				conversation = await strapi.db.query('api::conversation.conversation').findMany({

					where: {
	
						$and: [
	
							{
								users: {
									id: {
										$eq: user.id
									}
								}
							},
	
							{
								users: {
	
									id: {
										$eq: id
									}
								}
							}
	
						]
					}
	
				});
	
	
	
	
				if (conversation.length == 0) {
	
	
					// creo una conversacion con los usuarios
	
	
					conversation = await strapi.entityService.create('api::conversation.conversation', {
	
						data: {
							name: "Conversacion between " + user.id + " and " + id,
							users: [user.id, id]
	
						}
	
					})
	
	
	
				} else {
	
					conversation = conversation[0];
				}
	
	
	
	
	

			}else{

				conversation = await strapi.entityService.create('api::conversation.conversation', {
	
					data: {
						name: "Conversacion between " + user.id + " and " + id,
						users: [user.id, id]

					}

				})

				
			}







			return ctx.send({ data: conversation });


		} catch (error) {
			console.error('Error al buscar proveedores:', error);

			return ctx.badRequest('Error al buscar proveedores');

		}



	}

	// ruta para cobro de comision por registro

	plugin.controllers.user.cobrarComisionPedido = async (ctx) => {


		try {

			// saco el usuario del token

			const user = ctx.state.user;

			//verifico exista 

			if (!user) return ctx.badRequest('No se envio el usuario');



			// establezco el costo de la comision que son 15$ pero en centimos


			const comision = 1500;

			// busco el usuario en la base de datos



			// si el usuario tiene el campo stripe_customer_id vacio entonces lo creo en stripe

			let customer = {};

			if (!user.stripe_customer_id) {

				customer["stripe_customer_id"] = await stripe.customers.create();
				await strapi.entityService.update('plugin::users-permissions.user', user.id, {

					data: {

						stripe_customer_id: customer["stripe_customer_id"]

					}

				});

			} else {

				customer["stripe_customer_id"] = user.stripe_customer_id;
			}







			const ephemeralKey = await stripe.ephemeralKeys.create(
				{ customer: customer.stripe_customer_id },
				{ apiVersion: '2022-11-15' }
			);

			// actualizo el usuario con el id del cliente de stripe



			const paymentIntent = await stripe.paymentIntents.create({
				amount: comision,
				currency: 'usd',
				customer: customer.stripe_customer_id,
				payment_method_types: ['card'],
				statement_descriptor: 'Fee register ' + user.id,
				description: 'Fee register how provider, ID: ' + user.id + " " + user.name + " " + user.lastname,

			});



			data = {
				paymentIntent: paymentIntent.client_secret,
				ephemeralKey: ephemeralKey.secret,
				customer: customer.stripe_customer_id,
				publishableKey: STRIPE_PUBLIC_KEY,
			};

			console.log(data);


			return ctx.send({ data: data });












		} catch (error) {
			console.error('Error al buscar proveedores:', error);

			return ctx.badRequest('Error al cobrar comisión', error);
		}


	}

	// ruta para cobro de comision por registro

	plugin.controllers.user.stripeCobrarTask = async (ctx) => {


		try {

			// saco el usuario del token

			const user = ctx.state.user;

			//verifico exista 

			if (!user) return ctx.badRequest('No se envio el usuario');


			let { provider, location, location_geo, length, date, time, car, description, category, price } = ctx.request.body.data;



			console.log(ctx.request.body.data);
			let comision = price; // tiene forma "57.45" en dolares lo convierto en 

			comision = comision * 100; // lo paso a centimos

			comision = parseInt(comision); // lo paso a entero

			comision = parseInt(comision);











			// si el usuario tiene el campo stripe_customer_id vacio entonces lo creo en stripe

			let customer = {};

			if (!user.stripe_customer_id) {

				customer["stripe_customer_id"] = await stripe.customers.create();
				await strapi.entityService.update('plugin::users-permissions.user', user.id, {

					data: {

						stripe_customer_id: customer["stripe_customer_id"]

					}

				});

			} else {

				customer["stripe_customer_id"] = user.stripe_customer_id;
			}







			const ephemeralKey = await stripe.ephemeralKeys.create(
				{ customer: customer.stripe_customer_id },
				{ apiVersion: '2022-11-15' }
			);






			const paymentIntent = await stripe.paymentIntents.create({
				amount: comision,
				currency: 'usd',
				customer: customer.stripe_customer_id,
				payment_method_types: ['card'],
				statement_descriptor: 'Payment for task ' + user.id,
				description: 'Payment for task ' + user.id + " " + user.name + " " + user.lastname + " " + provider + category + " " + price,

			});



			data = {
				paymentIntent: paymentIntent.client_secret,
				ephemeralKey: ephemeralKey.secret,
				customer: customer.stripe_customer_id,
				publishableKey: STRIPE_PUBLIC_KEY,
				paymentIntentId: paymentIntent.id
			};




			return ctx.send({ data: data });



		} catch (error) {
			console.error('Error al buscar proveedores:', error);

			return ctx.badRequest('Error al cobrar comisión', error);
		}


	}

	function getTimes(start, end) {
		const startHour = parseInt(start.split(":")[0]);
		const endHour = parseInt(end.split(":")[0]);

		// Si endHour es menor que startHour, asumimos que abarca la medianoche
		if (endHour < startHour) {
			// Generamos un array de horas desde startHour hasta 23
			const hours1 = Array.from({ length: 24 - startHour }, (_, i) => (i + startHour) % 24);
			// Generamos un array de horas desde 0 hasta endHour
			const hours2 = Array.from({ length: endHour + 1 }, (_, i) => i);
			// Concatenamos los dos arrays de horas
			const hours = hours1.concat(hours2);
			// Formateamos el resultado en formato de 24 horas
			return hours.map(h => `${h.toString().padStart(2, '0')}:00`);
		} else {
			// Si endHour es mayor o igual que startHour, generamos un array de horas normalmente
			return Array.from({ length: endHour - startHour + 1 }, (_, i) =>
				[(i + startHour) % 24, 0]
			).map(([h, m]) =>
				`${h.toString().padStart(2, '0')}:00`
			);
		}
	}

	plugin.controllers.user.stripeConnect = async (ctx) => {
		// recibo el usuario logueado

		const user = ctx.state.user;

		// verifico que sea usuario y tenga role instructor

		if (!user || !user.isProvider) {
			//ctx.response.status	= 401;
			return ctx.response.unauthorized("No autorizado",

				{
					id: "No autorizado",

					message: "No autorizado",
				},

			);
		}



		// verifico que no tenga ya una cuenta creada con el campo stripe_account_id

		if (user.is_stripe_connect) {


			// entonces quiere desconectar la cuenta

			await stripe.accounts.del(
				user.stripe_connect_id
			);

			await strapi.entityService.update("plugin::users-permissions.user", user.id, {
				data: {
					stripe_connect_id: "",
					is_stripe_connect: false,

				},

			})
			return ctx.send("ok");

		}

		//	si no tiene cuenta creada, creo la cuenta

		const account = await stripe.accounts.create({
			type: 'express',
			country: 'US',
			email: user.email,
			capabilities: {
				transfers: { requested: true },
			},
			//tos_acceptance: {service_agreement: 'recipient'},
			business_type: 'individual',
			individual: {
				first_name: user.name,
				last_name: user.lastname,
			}
		});

		// saco URL del .env

		const host = process.env.URL;

		await strapi.entityService.update("plugin::users-permissions.user", user.id, {
			data: {
				stripe_connect_id: account.id,
				is_stripe_connect: false,

			},

		})






		const data = await stripe.accountLinks.create({
			account: account.id,
			refresh_url: `${host}/api/users-permissions/strapi/account/refresh?account_id=${account.id}`,
			return_url: `${host}/api/users-permissions/strapi/account/reauth?account_id=${account.id}`,
			type: 'account_onboarding',
		});
		console.log("host", data);
		return ctx.send(data.url);




	}

	plugin.controllers.user.stripeConnectReauth = async (ctx) => {


		const { account_id } = ctx.query;


		if (!account_id) {

			return ctx.badRequest("No se ha encontrado la cuenta", { message: "No se ha encontrado la cuenta" });

		}



		// busco el user con el	account_id

		const user = await strapi.db.query('plugin::users-permissions.user').findOne({
			where: { stripe_connect_id: account_id }
		})


		console.log("user", user);



		if (!user || !user.isProvider) {

			return ctx.response.unauthorized("No autorizado", { id: "No autorizado", message: "No autorizado", });

		}


		// verifico que no tenga ya una cuenta creada con el campo stripe_account_id

		/*	if (user.is_stripe_connect) {
	
				return ctx.badRequest("Ya tienes una cuenta creada", { message: "Ya tienes una cuenta creada" });
	
			}
	*/






		// busco id de la cuenta con stripe_account_id

		const account = await stripe.accounts.retrieve(account_id);


		if (!account) {

			return ctx.badRequest("No se encontró la cuenta", { message: "No se encontró la cuenta" });

		}


		await strapi.entityService.update("plugin::users-permissions.user", user.id, {
			data: {
				stripe_connect_id: account.id,
				is_stripe_connect: true,

			},

		})




		// redirecciono a la pagon

		return ctx.redirect(`${process.env.URL}/return-app.html`);


	}

	plugin.controllers.user.stripeDeleteAcountTest = async (ctx) => {


		const { account_id } = ctx.query;


		const deleted = await stripe.accounts.del(
			account_id
		);

		return ctx.send(deleted);

	}


	plugin.routes['content-api'].routes.push(

		{
			"method": "GET",
			"path": "/proveedores/",
			"handler": "user.buscarProveedores"

		},
		{
			"method": "GET",
			"path": "/proveedores/",
			"handler": "user.buscarProveedores"

		},
		{
			"method": "GET",
			"path": "/proveedores/conversation/:id",
			"handler": "user.buscarConversation"

		},
		{
			"method": "GET",
			"path": "/proveedores/fav-or-book",
			"handler": "user.buscarProveedoresBorF"

		},
		{
			"method": "GET",
			"path": "/proveedores/:id",
			"handler": "user.perfilProveedor"

		},
		{
			"method": "POST",
			"path": "/users/otp",
			"handler": "user.getOTP",
			"config": {
				prefix: ''
			}

		},

		// ruta /otp/verify
		{
			"method": "POST",
			"path": "/users/otp/verify",
			"handler": "user.verifyOTP",
			"config": {
				prefix: ''
			}
		},
		// change password for otp 
		{
			"method": "POST",
			"path": "/users/otp/change-password",
			"handler": "user.otpChangePassword",
			"config": {
				prefix: ''
			}
		},
		{

			"method": "GET",
			"path": "/users-permissions/create-payment-intent-register",
			"handler": "user.cobrarComisionPedido",
			"config": {
				prefix: ''

			}


		}
		,
		{

			"method": "GET",
			"path": "/users-permissions/connet-stripe",
			"handler": "user.stripeConnect",
			"config": {
				prefix: ''

			}


		}
		,
		{
			"method": "GET",
			"path": "/users-permissions/strapi/account/reauth",
			"handler": "user.stripeConnectReauth",
			"config": {
				prefix: ''

			}


		},
		{

			"method": "GET",
			"path": "/users-permissions/strapi/account/delete",
			"handler": "user.stripeDeleteAcountTest",
			"config": {
				prefix: ''

			}

		},

		{

			"method": "POST",
			"path": "/users-permissions/create-payment-task",
			"handler": "user.stripeCobrarTask",
			"config": {
				prefix: ''
			}

		}

	)

	return plugin
}