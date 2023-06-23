const { faker } = require("@faker-js/faker/locale/tr");

const baseUrl = "http://127.0.0.1:1337/api/";
const headers = {
  Authorization:
    "Bearer 524049829523de0a06e2bc747b53fe3e277e0c3c9ae8365cb1e7efe4b4f01c927ede0e55f1a98c29c2a050aac35a344ad7239d0fbb8ec8557fd3429a25b6a60822ee93f6722558e80e185f808f3519cd9d9f024affcf0ee1f6d8e763c2da53246371582ab79571a3963e40fc07719d4bbed9b8cc17f7981c9472650383b84c72",
  "Content-Type": "application/json",
};

async function createPositions() {
  try {
    for (let i = 0; i < 15; i++) {
      let pos = faker.location.nearbyGPSCoordinate({
        origin: [37.214994, 28.363613],
        radius: 1,
        isMetric: true,
      });

      const position = { latitude: pos[0], longitude: pos[1] };
      const response = await fetch(baseUrl + "positions", {
        method: "POST",
        mode: "cors",
        headers: headers,
        body: JSON.stringify({ data: position }),
      });

      if (response.status !== 200) {
        console.error("Error:", await response.json());
        break;
      }
    }
  } catch (error) {
    console.error("Error:", error);
  }
}

async function createAddresses() {
  try {
    for (let i = 0; i < 30; i++) {
      const response = await fetch(baseUrl + "addresses", {
        method: "POST",
        mode: "cors",
        headers: headers,
        body: JSON.stringify({
          data: {
            firstName: faker.person.firstName(),
            lastName: faker.person.lastName(),
            phoneNumber: faker.phone.number(),
            city: faker.location.city(),
            district: faker.location.county(),
            address: faker.location.streetAddress(),
            postalCode: faker.location.zipCode(),
          },
        }),
      });

      if (response.status !== 200) {
        console.error("Error:", await response.json());
        break;
      }
    }
  } catch (error) {
    console.error("Error:", error);
  }
}

async function createPackages() {
  try {
    for (let i = 1; i <= 30; i++) {
      const senderAndReceiverIds = getRandom2Nums();

      const response = await fetch(baseUrl + "packages", {
        method: "POST",
        headers: headers,
        body: JSON.stringify({
          data: {
            typeName: "Standart Teslimat",
            status: "Bekleniyor",
            price: Number(faker.finance.amount(10, 100, 2)),
            description: `${i}. pakete dair açıklama`,
            position: { id: faker.number.int({ min: 4, max: 18 }) },
            sender: { id: senderAndReceiverIds[0] },
            receiver: { id: senderAndReceiverIds[1] },
          },
        }),
      });

      if (response.status !== 200) {
        console.error("Error:", await response.json());
        break;
      }
    }
  } catch (error) {
    console.error("Catch Error:", error);
  }
}

function getRandom2Nums() {
  let num = faker.number.int({ min: 4, max: 33 });
  let num1 = faker.number.int({ min: 4, max: 33 });

  while (num === num1) {
    num = faker.number.int({ min: 4, max: 33 });
    num1 = faker.number.int({ min: 4, max: 33 });
  }

  return [num, num1];
}

createPackages();
