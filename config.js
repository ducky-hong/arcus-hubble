/*
 * arcus-hubble - A dashboard service to monitor Arcus clusters
 * Copyright 2012-2014 NAVER Corp.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
angular.module("config", [])
  .constant("VERSION", "0.1.0")
/* for Arcus */
///*
  .constant("SERVICE_NAME", "ARCUS")
  .constant("HUBBLE_ADDRESS", "localhost:3000")
  .constant("DEFAULT_TABS", [ "cpu", "memory", "protocols", "interface", "disk", "swap", "vmem", "processes", "load", "arcus_stat", "sum_arcus", "sum_prefix", "stacked_sum_prefix" ])
  .constant("PLUGINS", [
    {
      name: "sum_arcus",
      tabs: {
        "A_memory": null,
        "B_key-value": null,
        "C_list": null,
        "D_set": null,
        "E_btree": null,
        "F_others": null
      }
    },
    {
      name: "sum_prefix",
      tabs: {
        "A_key-value": null,
        "B_list": null,
        "C_set": null,
        "D_btree": null
      }
    },
    {
      name: "stacked_sum_prefix",
      tabs: {
        "A_key-value": null,
        "B_list": null,
        "C_set": null,
        "D_btree": null
      }
    }
  ])
  .constant("SERVER_LIST", function(callback) {
    // FIXME $http를 어떻게 사용할 수 있지?
  })
//*/
/* for Others */
/*
  .constant("SERVICE_NAME", "MY_SERVICE")
  .constant("DEFAULT_TABS", [
    "cpu", "memory", "protocols", "interface", "disk", "swap", "vmem", "processes"
  ])
  .constant("PLUGINS", [
  ])
  .constant("SERVER_LIST", {
    "mycluster": {
      "servers": {
        "cluster001.test.domain.com": {
          "ip": "10.0.0.1",
          "ports": []
        },
        "cluster002.test.domain.com": {
          "ip": "10.0.0.2",
          "ports": []
        }
      },
      "hubble": "10.0.0.1:25832",
      "zookeeper": "10.0.0.1:2181",
      "ports": []
    }
  })
*/
