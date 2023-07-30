'use strict';

module.exports = {
  /**
   * An asynchronous register function that runs before
   * your application is initialized.
   *
   * This gives you an opportunity to extend code.
   */
  register({ strapi }) { },

  /**
   * An asynchronous bootstrap function that runs before
   * your application gets started.
   *
   * This gives you an opportunity to set up your data model,
   * run jobs, or perform some special logic.
   */
  bootstrap({ strapi }) {
    process.nextTick(() => {

      let interval;
      var io = require("socket.io")(strapi.server.httpServer, {
        cors: { // cors setup
          origin: "*",
          methods: ["GET", "POST"],
          allowedHeaders: ["Authorization"],
          credentials: true,
        },
      });

      io.use(async (socket, next) => {


        try {


          //Socket Authentication
          const result = await strapi.plugins[
            'users-permissions'
          ].services.jwt.verify(socket.handshake.query.token);


          // buscamos el usuario en la base de datos

          const user = await strapi.entityService.findOne('plugin::users-permissions.user', result.id, {
            populate: { avatar_image: true }
          });

          delete user.createdAt;
          delete user.updatedAt;
          delete user.provider;
          delete user.password;
          delete user.resetPasswordToken;
          delete user.confirmationToken;


          user.avatar_image = user.avatar_image ? user.avatar_image.url : false;


          // actualizo el usuario como online

          await strapi.entityService.update('plugin::users-permissions.user', result.id,

            { data: {  socket_id: socket.id } });



          socket.user = user;
          next();
        } catch (error) {


          console.log(error)
        }



      }).on('connection', function (socket) {




        if (interval) {
          clearInterval(interval);
        }


        interval = setInterval(() => {
          io.emit('serverTime', { time: new Date().getTime() }); // This will emit the event to all connected sockets

        }, 1000);



        socket.on('getChat', async (id) => {

          try {
            let otherUser = [];

            const chat = await strapi.entityService.findMany('api::chat-message.chat-message', {

              filters: { conversation: id },


              populate: { emit: true }
            });

            // busco al otro usuario integrante del chat buscando a los usuarios de la conversacion que no sean el usuario logueado


            let conversacion = await strapi.entityService.findOne('api::conversation.conversation', id, {

              populate: { users: true }

            })

            socket.join(id);



            otherUser = conversacion.users.filter(us => us.id != socket.user.id);

            otherUser = otherUser[0];

            // busco el usuario que envio el mensaje


            otherUser = await strapi.entityService.findOne('plugin::users-permissions.user', otherUser.id, {

              fields: ['id', "name", "lastname"],
              populate: { avatar_image: true }

            });

            otherUser.avatar_image = otherUser.avatar_image ? otherUser.avatar_image.url : false;




            /*
              recorro el chat para formatear lso mensajes, recorro usando for
  
  
            */

            for (let i = 0; i < chat.length; i++) {

              let mensaje = chat[i];


              delete mensaje.updatedAt;


              // si el mensaje no es del usuario logueado o es del bot reviso status y lo marco como leido


              if (mensaje.bot || mensaje.emit.id != socket.user.id) {



                if (mensaje.status == 'delivered' || mensaje.status == 'sent') {

                  await strapi.entityService.update('api::chat-message.chat-message', mensaje.id,

                    { data: { status: 'seen' } });

                  mensaje.status = 'seen';

                }

              }




              let user = {};
              if (!mensaje.bot) {
                user = await strapi.entityService.findOne('plugin::users-permissions.user', mensaje.emit.id, {

                  populate: { avatar_image: true },
                  fields: ['id', "name", "lastname"],
                  //ordeno por createdAt
                  sort: 'createdAt:DESC'

                });
                user.avatar_image = user.avatar_image ? process.env.URL + user.avatar_image.url : false;


              } else {

                user = { id: 'bot', name: 'Provistask', lastname: 'Systems', online: true, avatar_image: process.env.LOGO_APP }

              }



              let fechaUnix = new Date(mensaje.datetime).getTime();

              chat[i] = {

                'author': {
                  'firstName': user.name,
                  'id': user.id.toString(),
                  'imageUrl': user.avatar_image,
                  'lastName': user.lastname
                },
                'createdAt': fechaUnix,//paso hora en formato unix  ,
                'id': mensaje.id.toString(),
                'status': mensaje.status ?? 'seen',
                'text': mensaje.message ?? '',
                'type': mensaje.type ?? 'text',
                'roomId': id.toString(),
              }





            }



            //socket.join(conversation);

            // busco si la conversacion con id = id tiene una tarea asiugnada api::task-assigned.task-assigned


            //ordeno por datetime

            chat.sort((a, b) => (a.datetime > b.datetime) ? 1 : -1);



            socket.emit('getChat', { chat: chat, user: otherUser });
          } catch (error) {

            console.log(error)

            throw error;
          }




        })

        // send mensaje

        socket.on('sendMessage', async (data) => {


          console.log(data)



          const mensaje = await strapi.entityService.create('api::chat-message.chat-message', {

            data: {

              conversation: data.roomId,

              emit: socket.user.id,

              message: data.text,
              datetime: data.createdAt,

              status: 'sent',
              type: data.type

            }

          });


          socket.emit('sendMessageResponse', { status: 'sent', message: mensaje });

          io.to(data.conversation).emit('sendMessageResponse', { status: 'sent', message: mensaje });



        })


        socket.on('disconnect', async () => {


          // actualizo el usuario como offline

          await strapi.entityService.update('plugin::users-permissions.user', socket.user.id,

            { data: { online: false, socket_id: null } });


        });




      });

    });
  },



};
