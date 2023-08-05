'use strict';

/**
 * provider-skill controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::provider-skill.provider-skill' ,({ strapi }) => ({




 async create(ctx) {


	const user = ctx.state.user;

	if (!user) {

		return ctx.unauthorized("No tienes permiso", { error: 'No autorizado' });

	}


	const {  skill_id, cost , type_cost, description } = ctx.request.body.data;


console.log(ctx.request.body);

	const skill = await strapi.query('api::skill.skill').findOne({where:{ id: skill_id }});


	if (!skill) {

		return ctx.unauthorized("No existe el skill", { error: 'No existe el skill' });

	}


	// verifico se hayan mandado los demas datos

	if (!cost || !type_cost || !description) {


		return ctx.unauthorized("Faltan datos", { error: 'Faltan datos' });

	}





	//	verifico si existe el provider_skill








	let provider_skill = await strapi.query('api::provider-skill.provider-skill').findOne({
		
		
		where:{ provider: user.id, categorias_skill: skill_id }
	
	
	});
	
	
	if (provider_skill) {

		// si existe la actualizo


		 await strapi.query('api::provider-skill.provider-skill').update(

{			where:{ id: provider_skill.id },

			data:{ cost: cost, type_price: type_cost, description: description }}

		);


	}else{


		// si no existe la creo

		 provider_skill = await strapi.query('api::provider-skill.provider-skill').create({

			data:{provider: user.id,
			categorias_skill: skill_id,
			cost: cost,
			type_price: type_cost,
			description: description}

		});

	}


	console.log(provider_skill);

	return provider_skill;




	},


	async deleteImageByPath(ctx) {
		console.log(ctx.request.body);

		let {	ref, refId, path } = ctx.request.body;



		const user = ctx.state.user;


		if (!user) {

			return ctx.unauthorized("No tienes permiso", { error: 'No autorizado' });

		}


		if (!ref || !refId || !path) {

				return ctx.badRequest("Faltan datos", { error: 'Faltan datos' });

		}


		// elimino la url base para quedarme con la relativa


		path = path.replace(process.env.URL, "");


		console.log(path);


		 let archivo = await strapi.db.connection.raw(`SELECT * FROM files WHERE url = '${path}'`);


			console.log(archivo[0]);



			return ctx.send ({message: "hola"});
	}



}));
