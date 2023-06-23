module.exports = {
  routes: [
    {
      method: "GET",
      path: "/login",
      handler: "login.login",
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};
