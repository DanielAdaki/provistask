'use strict';
const {URL} = process.env;
const { v4: uuid } = require('uuid');
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
      try {
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
  
  
            console.log(result)
  
            if (!result) {
  
              throw new Error('Invalid Token');
  
            }
  
            const user = await strapi.entityService.findOne('plugin::users-permissions.user', result.id, {
              populate: { avatar_image: true },
  
              fields: ['id', "name", "lastname"],
            });
  
  
  
            user.avatar_image =  user.avatar_image ? URL + user.avatar_image.url :  URL+'/uploads/user_147dd8408e.png';
  
            let onlineUser = await strapi.db.query('api::online-user.online-user').findOne({
              where: {user: user.id },});
  
  
  
            if (!onlineUser) {
  
               await strapi.entityService.create('api::online-user.online-user', {
  
                data: {
  
                  user: user.id,
  
                  socket_id: socket.id,
                  lastConnection: new Date().getTime(),
                  status: 'online'
  
                }
  
              });
  
        
  
            } else {
  
               await strapi.entityService.update('api::online-user.online-user', onlineUser.id,
  
  
  
                {
                  data: {
                    socket_id: socket.id,
                    lastConnection: new Date().getTime(),
                    status: 'online'
                  }
                });
  
            }
  
  
            user["socket_id"] = socket.id;
            user["lastConnection"] = new Date().getTime();
            user["status"] = 'online';
  
  
            socket.user = user;
            console.log('user', user)
            next();
          } catch (error) {
  
            
            console.log(error)
          
          }
  
  
  
        }).on('connection', function (socket) {
  
  
  
  
          if (interval) {
            clearInterval(interval);
          }
  
  
        /*  interval = setInterval(() => {
            io.emit('serverTime', { time: new Date().getTime() }); // This will emit the event to all connected sockets
  
          }, 1000);*/
  
  
          socket.on('join', async (data) => {
  
            try {
 
              let { id } = data;
  
  
              if (!id) {
  
                socket.emit('error', { error: 'Id de conversacion no encontrado' , id: id , type: 'join' , user: socket.user.id , datetime: new Date().getTime() , status: 'error' , message: 'Id de conversacion no encontrado' });
  
                throw new Error('Id de conversacion no encontrado');
  
              }
  
              console.log(id, "conversacion")
  
              let conversacion = await strapi.entityService.findOne('api::conversation.conversation', id, {
  
                populate: { users: true }
  
              })
  
  
  
              if (!conversacion) {
  
  
                // respondo con el webhook para error
  
                socket.emit('error', { error: 'Conversacion no encontrada' , id: id , type: 'join' , user: socket.user.id , datetime: new Date().getTime() , status: 'error' , message: 'Conversacion no encontrada' });
  
                
  
                throw new Error('Conversacion no encontrada');
  
              }
  
              let user = conversacion.users.filter(us => us.id == socket.user.id);
  
              if (user.length == 0) {
  
                socket.emit('error', { error: 'No pertenece a la conversación' , id: id , type: 'join' , user: socket.user.id , datetime: new Date().getTime() , status: 'error' , message: 'No pertenece a la conversación' });
  
                throw new Error('No pertenece a la conversacion');
  
  
              }
  
              // verifico el tipo de de dato de id de conversacion si es number lo paso a string
  
  
              if (typeof id == 'number') {
  
                id = id.toString();
  
              }
  
  
  
  
              socket.join(`sala_${id}`);
  
              
  
              console.log(`Cliente ${socket.id} se ha unido a la sala ${id}`);
  
              // notifico a los demas usuarios que se unio a la conversacion
  
              
  
             let otherUser = conversacion.users.filter(us => us.id != socket.user.id);
  
              otherUser = otherUser[0];
  
              // busco el usuario que envio el mensaje
  
  
           /*   otherUser = await strapi.entityService.findOne('plugin::users-permissions.user', otherUser.id, {
  
                fields: ['id', "name", "lastname"],
  
                populate: { avatar_image: true }
  
              });
  
  
              otherUser.avatar_image = otherUser.avatar_image ? URL + otherUser.avatar_image.url : URL+'/uploads/user_147dd8408e.png';*/
  
              socket.broadcast.to(`sala_${id}`).emit('joinResponse', { otherUser: otherUser.id });
  
              //socket.emit('joinResponse', { otherUser });
  
            } catch (error) {
  
              console.log(error)
  
              throw error;
  
            }
  
          });
  
  
  
          socket.on('getChat', async (data) => {
  
            try {
              let otherUser = [];
  
              console.log(data)
  
              const { id, page, limit } = data;
             
  
              page ? parseInt(page) : 1;
  
              limit ? parseInt(limit) : 10;
  
  
              const start = (page - 1) * limit;
  
             let mensajes =  await strapi.db.query('api::chat-message.chat-message').findMany({
  
                where: { conversation: id.toString() },
  
                orderBy :{ createdAt: 'DESC' } ,
  
                limit : limit,
  
                offset : start,
  
                populate: [ "emit", "emit.avatar_image"]
  
              });
  
  
  
              let conversacion = await strapi.entityService.findOne('api::conversation.conversation', id, {
  
                populate: { users: true }
  
              })
  
            ///  socket.join(id);
  
  
  
              otherUser = conversacion.users.filter(us => us.id != socket.user.id);
  
              otherUser = otherUser[0];
  
              // busco el usuario que envio el mensaje
  
  
              otherUser = await strapi.entityService.findOne('plugin::users-permissions.user', otherUser.id, {
  
                fields: ['id', "name", "lastname"],
                populate: { avatar_image: true }
  
              });
  
              otherUser.avatar_image = otherUser.avatar_image ? URL + otherUser.avatar_image.url : URL+'/uploads/user_147dd8408e.png';
  
  
  
  
              /*
                recorro el chat para formatear lso mensajes, recorro usando for
    
    
              */
  
              for (let i = 0; i < mensajes.length; i++) {
  
                let mensaje = mensajes[i];
  
  
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
                  user.avatar_image = user.avatar_image ? process.env.URL + user.avatar_image.url : process.env.URL+'/uploads/user_147dd8408e.png';
  
  
                } else {
  
                  user = { id: 'bot', name: 'Provistask', lastname: 'Systems', online: true, avatar_image: process.env.LOGO_APP }
  
                }
  
                mensaje.datetime = mensaje.datetime ? mensaje.datetime : mensaje.createdAt;
  
                let fechaUnix = new Date(mensaje.datetime).getTime();
  
                mensajes[i] = {
  
                  'author': {
                    'firstName': user.name,
                    'id': user.id.toString(),
                    'imageUrl': user.avatar_image,
                    'lastName': user.lastname
                  },
                  'createdAt': fechaUnix,//paso hora en formato unix  ,
                  'remoteId': mensaje.id.toString(),
                  'id': uuid(),
                  'status': mensaje.status ?? 'seen',
                  'text': mensaje.message ?? '',
                  'type': mensaje.type ?? 'text',
                  'roomId': id.toString(),
                }
  
  
  
  
  
              }
  
  
  
              //socket.join(conversation);
  
              // busco si la conversacion con id = id tiene una tarea asiugnada api::task-assigned.task-assigned
  
  
              //ordeno por datetime de manera descendente
  
              mensajes.sort((a, b) => b.createdAt - a.createdAt);
  
  
              console.log(otherUser)
  
              socket.emit('getChatResponse', { mensajes, otherUser});
            } catch (error) {
  
              console.log(error)
  
              throw error;
            }
          
          });
  
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
  
            console.log(data)
  
  
          
  
            if (!data.id){
              data.id = uuid();
            }
  
  
            io.to(`sala_${data.roomId.toString()}`).emit('sendMessageResponse', {
  
              'author': {
                'firstName': socket.user.name,
                'id': socket.user.id.toString(),
                'imageUrl': socket.user.avatar_image,
                'lastName': socket.user.lastname
              },
  
              'createdAt': data.createdAt,
              'id': data.id.toString(),
              'remoteId': mensaje.id.toString(), //id del mensaje en la base de datos
              'status': 'sent',
              'text': data.text,
              'type': data.type,
              'roomId': data.roomId.toString(),
            });
            
  
  
  
          })
  
  
          socket.on('disconnect', async () => {
  
  
            await strapi.db.query('api::online-user.online-user').update({
              where: { socket_id: socket.id },
              data: {
                status: 'offline', 
                lastConnection: new Date().getTime()
              },
            });
  
            // lo saco de todas las salas
  
            let rooms = Object.keys(socket.rooms);
  
            for (let i = 0; i < rooms.length; i++) {
  
              if (rooms[i] != socket.id) {
  
                socket.leave(rooms[i]);
  
              }
  
            }
  
  
          });
  
  
          //socekt para obterner mensajes de lo
  
  
  
  
  
  
        });
      } catch (error) {
        console.log(error)
        throw error;
      }


    });
  },



};
