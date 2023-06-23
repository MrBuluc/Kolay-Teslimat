module.exports = {
  routes: [
    {
      method: "PUT",
      path: "/move-to-car",
      handler: "move-to-car.moveToCar",
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};
