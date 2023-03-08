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
          ],
  ace:
          [
            "9dtce1fb35",
            "e4ef9bab1f",
            "59d6d32bt7",
            "28b4t62tdc",
            "392c8tc8at",
            "2ca1137186",
            "d7tt8916eb",
            "1b7a89cf83",
            "5feef431a2",
            "135fbc7dea",
            "ba2b95d3fc",
            "1898ce92bd",
            "d6ea546d86",
            "5ff193ec97",
            "fae9d581t5",
            "t5965697d9",
            "f2f6a1f37f",
            "3a36t42a87",
            "157823fcd6"
          ]
}


FIELDS = ["pulsel", "pulseh", "valvestatus", "meterstatus"]

LAST_SYNC_AT = Time.now - 10*60*23

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
  padmaj: "537t8aca797b5a4dfetcb812a6bb32dd48a337t3",
  ace: "fd5d79b4e919ad44d33cb46f9f615e736516f26d"
}