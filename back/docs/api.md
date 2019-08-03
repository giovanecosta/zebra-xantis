# API Documentation

  * [API /partners](#api-partners)
    * [index](#api-partners-index)
    * [create](#api-partners-create)
    * [show](#api-partners-show)
    * [update](#api-partners-update)
    * [delete](#api-partners-delete)
    * [get_nearest_covering](#api-partners-get_nearest_covering)

## API /partners
### <a id=api-partners-index></a>index
#### List all partners
##### Request
* __Method:__ GET
* __Path:__ /api/partners
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: Fbc9R9pzdb1hr0YAAAjl
```
* __Response body:__
```json
{
  "data": [
    {
      "address": {
        "coordinates": [
          0.0,
          0.0
        ],
        "type": "Point"
      },
      "coverageArea": {
        "coordinates": [
          [
            [
              [
                10.0,
                10.0
              ],
              [
                10.0,
                -10.0
              ],
              [
                -10.0,
                -10.0
              ],
              [
                -10.0,
                10.0
              ],
              [
                10.0,
                10.0
              ]
            ]
          ]
        ],
        "type": "MultiPolygon"
      },
      "distance": null,
      "document": "35.685.536/0001-72",
      "id": 2148,
      "ownerName": "Test Suite",
      "tradingName": "Center Square Partner"
    },
    {
      "address": {
        "coordinates": [
          10.0,
          10.0
        ],
        "type": "Point"
      },
      "coverageArea": {
        "coordinates": [
          [
            [
              [
                20.0,
                20.0
              ],
              [
                20.0,
                0.0
              ],
              [
                0.0,
                0.0
              ],
              [
                0.0,
                20.0
              ],
              [
                20.0,
                20.0
              ]
            ]
          ]
        ],
        "type": "MultiPolygon"
      },
      "distance": null,
      "document": "34.413.275/0001-79",
      "id": 2149,
      "ownerName": "Test Suite",
      "tradingName": "Top Right Square Partner"
    }
  ]
}
```

### <a id=api-partners-create></a>create
#### Create partner
##### Request
* __Method:__ POST
* __Path:__ /api/partners
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "partner": {
    "address": {
      "coordinates": [
        10.2,
        20.5
      ],
      "type": "Point"
    },
    "coverageArea": {
      "coordinates": [
        [
          [
            [
              23,
              45
            ],
            [
              12.1,
              23
            ],
            [
              45.4,
              87
            ],
            [
              23.6,
              23
            ],
            [
              23,
              45
            ]
          ]
        ]
      ],
      "type": "MultiPolygon"
    },
    "document": "some document",
    "ownerName": "some owner_name",
    "tradingName": "some trading_name"
  }
}
```

##### Response
* __Status__: 201
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: Fbc9R9lPjZIfquAAAAil
location: /api/partners/2140
```
* __Response body:__
```json
{
  "data": {
    "address": {
      "coordinates": [
        10.2,
        20.5
      ],
      "type": "Point"
    },
    "coverageArea": {
      "coordinates": [
        [
          [
            [
              23,
              45
            ],
            [
              12.1,
              23
            ],
            [
              45.4,
              87
            ],
            [
              23.6,
              23
            ],
            [
              23,
              45
            ]
          ]
        ]
      ],
      "type": "MultiPolygon"
    },
    "distance": null,
    "document": "some document",
    "id": 2140,
    "ownerName": "some owner_name",
    "tradingName": "some trading_name"
  }
}
```

### <a id=api-partners-show></a>show
#### Show partner
##### Request
* __Method:__ GET
* __Path:__ /api/partners/2141
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: Fbc9R9nJA0o6gH4AAAbh
```
* __Response body:__
```json
{
  "data": {
    "address": {
      "coordinates": [
        10.2,
        20.5
      ],
      "type": "Point"
    },
    "coverageArea": {
      "coordinates": [
        [
          [
            [
              23.0,
              45.0
            ],
            [
              12.1,
              23.0
            ],
            [
              45.4,
              87.0
            ],
            [
              23.6,
              23.0
            ],
            [
              23.0,
              45.0
            ]
          ]
        ]
      ],
      "type": "MultiPolygon"
    },
    "distance": null,
    "document": "some document",
    "id": 2141,
    "ownerName": "some owner_name",
    "tradingName": "some trading_name"
  }
}
```

### <a id=api-partners-update></a>update
#### Update partner
##### Request
* __Method:__ PUT
* __Path:__ /api/partners/2131
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "partner": {
    "address": {
      "coordinates": [
        16.8,
        28
      ],
      "type": "Point"
    },
    "coverageArea": {
      "coordinates": [
        [
          [
            [
              12.1,
              23
            ],
            [
              -11,
              11
            ],
            [
              34,
              23
            ],
            [
              54.2,
              76
            ],
            [
              12.1,
              23
            ]
          ]
        ]
      ],
      "type": "MultiPolygon"
    },
    "document": "some updated document",
    "ownerName": "some updated owner_name",
    "tradingName": "some updated trading_name"
  }
}
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: Fbc9R9MrA50HnfIAAAYB
```
* __Response body:__
```json
{
  "data": {
    "address": {
      "coordinates": [
        16.8,
        28
      ],
      "type": "Point"
    },
    "coverageArea": {
      "coordinates": [
        [
          [
            [
              12.1,
              23
            ],
            [
              -11,
              11
            ],
            [
              34,
              23
            ],
            [
              54.2,
              76
            ],
            [
              12.1,
              23
            ]
          ]
        ]
      ],
      "type": "MultiPolygon"
    },
    "distance": null,
    "document": "some updated document",
    "id": 2131,
    "ownerName": "some updated owner_name",
    "tradingName": "some updated trading_name"
  }
}
```

### <a id=api-partners-delete></a>delete
#### Delete partner
##### Request
* __Method:__ DELETE
* __Path:__ /api/partners/2139
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 204
* __Response headers:__
```
cache-control: max-age=0, private, must-revalidate
x-request-id: Fbc9R9YqXReGKcwAAAiF
```
* __Response body:__
```json

```

### <a id=api-partners-get_nearest_covering></a>get_nearest_covering
#### Get nearest partner by location (latitude, longitude)
##### Request
* __Method:__ GET
* __Path:__ /api/partners/nearest_covering/5/3
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: Fbc9R9oU8EXYqQQAAAcB
```
* __Response body:__
```json
{
  "data": {
    "address": {
      "coordinates": [
        0.0,
        0.0
      ],
      "type": "Point"
    },
    "coverageArea": {
      "coordinates": [
        [
          [
            [
              10.0,
              10.0
            ],
            [
              10.0,
              -10.0
            ],
            [
              -10.0,
              -10.0
            ],
            [
              -10.0,
              10.0
            ],
            [
              10.0,
              10.0
            ]
          ]
        ]
      ],
      "type": "MultiPolygon"
    },
    "distance": 647735.5654323,
    "document": "35.685.536/0001-72",
    "id": 2142,
    "ownerName": "Test Suite",
    "tradingName": "Center Square Partner"
  }
}
```

