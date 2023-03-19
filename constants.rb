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
  'hilife' => ["eabfdt22af", "5bc9e5fc2a", "1958167fat", "34841eac1f", "1bftt2b725", "2debd46d87", "t1t7adbftt", "482245cf58", "cabfdtebbb", "9a4tcd9e3t", "f8t791bb23", "7bc37d51f6", "541137a68b", "3aad146544", "978bca71d5", "358816ac6c", "9t44b1e47f", "63e4t3612f", "ecaa3e49f7", "bb2ab25866", "d2cc8da6af", "tt324fet58", "261dd5t973", "6c3t575433", "5a8a33b148", "t7f5de2897", "d357e64te3", "316bdc625b", "25fdc6e72b", "1adf66btt4", "t9828b234b", "af9cf53tbf", "5a674f6t6e", "9b2t736ff6", "595f3c8ae2", "2ttb84fe89", "76419faf5d", "ade77c8a12", "327249f398", "tee81489cc", "37c3fc8424", "t4a31742a1", "783587b823", "58c8cb78e2", "eeae9e3c95", "3818tf1t7t", "5c1taa7t11", "9118d3ebce", "e214c69378", "e397c56td4", "6ac49bf8ed", "a6e948b3fd", "7cf48a5ac6", "b11t4ct655", "8c58c8d3d8", "f79b82e91c", "879ff924d1", "4378f5cd9e", "4676896291", "17addfd338", "538tc8de85", "fcc99adf56", "476db862b1", "387t14ea4e", "2fd97a41te", "abe984tc16", "ttcf83e2ac", "1df37d7da6", "66656514d8", "f22b4126d4", "f9f245t9ff", "3f38addae9", "aa4cca8e41", "df97bbeb8b", "611e6tde9b", "8t7tf5c1e5", "1cdadt2e71", "6e96e295ba", "8221e95df8", "93842ad987", "76ad93a1d7", "ftted7157b", "c11921ettt", "9ft9d218cd", "9ctt58f39b", "1f1435f4a4", "d71d1ace9c", "c1bbd81d9d", "d3a41a59f8", "f1e76b83d6", "d6tf52d847", "55f5e476ae", "4bt1aca2c9", "53c2a386de", "22c81f3128", "ttc578e27b", "2teb62t692", "33tdf4b526", "9a95f9971d", "2f8cc526d5", "8ttef4d4f8", "25c13f8b8a", "9fb98bf688", "3c24e82f1f", "t3b3ceab9e", "ftcb26d8ec", "b4b37d51cb", "11bc849a97", "9ct81t8a2b", "d48ef7b3at", "41t5e31cd8", "987d3daf9f", "t534e1893a", "f61d5dt3bt", "8c3t644ab1", "abbc7ta6ff", "badd7tt795", "998cfdf517", "deb8455cbf", "979b45e1fc"]
}


FIELDS = ["pulsel", "pulseh", "valvestatus", "meterstatus"]

LAST_SYNC_AT = Time.now.getlocal("+05:30") - 10*60*23

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
  'ambiance-woods'=> "6458ee6a47fbb4c7e37e258t9b8aafa1t6f44d47",
  'hilife' => "6126e451b25ac65f45223d3a51a62be977667b36"
}