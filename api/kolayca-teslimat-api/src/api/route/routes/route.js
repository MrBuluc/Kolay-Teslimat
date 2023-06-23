module.exports = {
  routes: [
    {
      method: "GET",
      path: "/route",
      handler: "route.route",
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};
