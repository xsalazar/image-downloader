const axios = require("axios");

exports.handler = async (event, context) => {
  console.log(JSON.stringify(event));

  var errorReturnResponse = {
    cookies: [],
    isBase64Encoded: false,
    statusCode: 400,
    headers: {},
    body: "",
  };

  if (event.queryStringParameters) {
    if (!event.queryStringParameters.imageSource) {
      return errorReturnResponse;
    }

    var imageSource = event.queryStringParameters.imageSource;

    if (
      !imageSource.startsWith(
        "https://www.gstatic.com/android/keyboard/emojikitchen"
      )
    ) {
      return errorReturnResponse;
    }

    // Get image from internet
    var response = await axios.get(imageSource, {
      responseType: "arraybuffer",
    });

    return {
      cookies: [],
      isBase64Encoded: true,
      statusCode: 200,
      headers: { "content-type": "application/octet-stream" },
      body: Buffer.from(response.data, "binary").toString("base64"),
    };
  }
};
