require 'time'
THING_KEYS = {
  padmaj: [ 
            "41t547b49t", 
            "48efea8t89", 
            "53496a77e3", 
            "6aaft35c19",
            "6c4cb551cc", 
            "74be721212", 
            "81318ta45d", 
            "9b247feedb", 
            "af32826d38", 
            "bf38e652ec", 
            "d4c3da6ab7", 
            "t17a695c27"
          ]
}


FIELDS = ["pulsel", "pulseh", "valvestatus", "meterstatus"]

LAST_SYNC_AT = Time.now - 10*60

SENSOR_CONFIG = {
    url: "https://api.datonis.io",
    username: "api@simplysmart.com",
    password: "josh12345",
    access_key: "ada77t53d59efte2642192a5247tf3dd14cb911e",
    secret_key: "8ffebft8f836dt881d88c258d2ecc3b34937ft8a",
    interval: 1,
    api_version: "v3"
  }

ACCESS_KEYS = {
  padmaj: "537t8aca797b5a4dfetcb812a6bb32dd48a337t3"
}