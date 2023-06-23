module.exports = {
  routes: [
    {
      method: "GET",
      path: "/get-packages",
      handler: "get-packages.getPackages",
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};
