module.exports = {
  routes: [
    {
      method: "GET",
      path: "/get-filter-packages",
      handler: "get-filter-packages.getFilterPackages",
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};
