require 'time'
THING_KEYS = {
  'padmaj'=> [ 
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
  'ambiance-woods'=> [
    "e459e6ff8c", "21783eaa69", "4ca248a488", "17a2dfdt18", "2dbbe48afc", "f1cba6a759", "775376f356", "4ebfbetb9t", "a863622ed2", "b8f4776e96", "tta27198f2", "38a82cdct5", "635879646a", "ccb4ffdec9", "5a6cc1b96f", "42t3t1b56t", "7t4ft6ef85", "241bt7b686", "11a8tt4cf4", "a7ef9241ct", "bd1be12ef8", "847fad33t1", "25ed9bc295", "96bcc3c6d7", "5fde21bt28", "817282fcc9", "dat2f7c6fa", "btdft777db", "993b6cfd24", "5e332ctat3", "ef6f2deac5", "b4794283tb", "bt7e22c2bt", "7c3f4e12t9", "9bct76td12", "2c9673c5e8", "29f5316bf9"]
}


FIELDS = ["pulsel", "pulseh", "valvestatus", "meterstatus"]

LAST_SYNC_AT = Time.now.getlocal("+05:30") - 10*60*6

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
  'padmaj'=> "537t8aca797b5a4dfetcb812a6bb32dd48a337t3",
  'ace'=> "fd5d79b4e919ad44d33cb46f9f615e736516f26d",
  'ambiance-woods'=> "6458ee6a47fbb4c7e37e258t9b8aafa1t6f44d47"
}