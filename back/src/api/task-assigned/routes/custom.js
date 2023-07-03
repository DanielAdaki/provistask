

module.exports = {
	routes: [
		{
			method: "GET",
			path: "/task-assigneds/completed/:id",
			handler: "task-assigned.taskCompleted",
			
		},
		{
			method: "GET",
			path: "/task-assigneds/acepted/:id",
			handler: "task-assigned.taskAcepted",
			
		},
		{
			method: "GET",
			path: "/task-assigneds/by-conversation/:id",
			handler: "task-assigned.taskByConversation",
			
		},
	],
};