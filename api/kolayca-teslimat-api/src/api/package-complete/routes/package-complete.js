module.exports = {
  routes: [
    {
      method: "POST",
      path: "/package-complete",
      handler: "package-complete.packageComplete",
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};
