{
  "spriteId": {
    "name": "s_charMithraGaurd1_Stand",
    "path": "sprites/s_charMithraGaurd1_Stand/s_charMithraGaurd1_Stand.yy",
  },
  "solid": false,
  "visible": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "ob_spawner",
    "path": "objects/ob_spawner/ob_spawner.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 0,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"isDnD":false,"eventNum":11,"eventType":7,"collisionObjectId":null,"parent":{"name":"o_spawnerMithraGuard","path":"objects/o_spawnerMithraGuard/o_spawnerMithraGuard.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":5,"value":"noone","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":null,"multiselect":false,"filters":[
        "GMObject",
      ],"resourceVersion":"1.0","name":"m_patrolPathStart","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":3,"value":"0","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":null,"multiselect":false,"filters":[
        "GMTileSet",
        "GMSprite",
        "GMSound",
        "GMPath",
        "GMScript",
        "GMShader",
        "GMFont",
        "GMTimeLine",
        "GMObject",
        "GMRoom",
      ],"resourceVersion":"1.0","name":"m_ai_disableAggression","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [
    {"propertyId":{"name":"m_characterToSpawn","path":"objects/ob_spawner/ob_spawner.yy",},"objectId":{"name":"ob_spawner","path":"objects/ob_spawner/ob_spawner.yy",},"value":"o_chMithraGaurdNpc","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"m_activeDespawnManagement","path":"objects/ob_spawner/ob_spawner.yy",},"objectId":{"name":"ob_spawner","path":"objects/ob_spawner/ob_spawner.yy",},"value":"True","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
  ],
  "parent": {
    "name": "Mithra",
    "path": "folders/Objects/Spawners/Mithra.yy",
  },
  "resourceVersion": "1.0",
  "name": "o_spawnerMithraGuard",
  "tags": [],
  "resourceType": "GMObject",
}