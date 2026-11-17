# telescope-analysis

Greynet and darknet data analysis and comparison.

## Notebooks

| Notebook | Runs on | What it does |
|---|---|---|
| [`greynet_data_access.ipynb`](greynet_data_access.ipynb) | SDSC Expanse (plain Jupyter session) | Connects to the greynet S3 containers (`sdscgreynetlist`, `telescope-sdscnt-pcap-live`) using the key in `/expanse/lustre/projects/sdp178/kmok/.ucsdnts3greynet.env`, lists their contents, byte-sniffs sample objects, and confirms whether the data is in FlowTuple (Avro) format. |
| [`greynet_pcap_to_flowtuple.ipynb`](greynet_pcap_to_flowtuple.ipynb) | SDSC Expanse (batch job with many cores; see the notebook's §1) | Streams the raw greynet pcaps from `telescope-sdscnt-pcap-live` — a whole month by default — and aggregates packets into per-destination FlowTuple records, one Parquet file per pcap on Lustre scratch. Conversion is parallel and resumable. It then analyses the Parquet with PySpark (local mode, same pattern as `nids-ucsdnt-expanse`): per-day coverage and trends, unique source/destination addresses, protocol mix, TCP/UDP ports, TCP flags, ICMP types, top sources, TTLs and packet sizes. Source addresses are geolocated to countries with the MaxMind GeoLite2 City database (the copy `nids-telescope-traffic` uses, fetched from the NRP S3 gateway) and to origin ASes with a RouteViews RIB for the same month (found through OSDF, longest-prefix match); both are cached as range tables next to the Parquet output. |

The notebooks are read-only against the object store and print no credential values.
Companion context: the darknet-side modules
[`nids-telescope-traffic`](https://github.com/CAIDA/nids-telescope-traffic) and
[`nids-ucsdnt-expanse`](https://github.com/CAIDA/nids-ucsdnt-expanse).
