# telescope-analysis

Greynet and darknet data analysis and comparison.

## Notebooks

| Notebook | Runs on | What it does |
|---|---|---|
| [`greynet_data_access.ipynb`](greynet_data_access.ipynb) | SDSC Expanse (plain Jupyter session) | Connects to the greynet S3 containers (`sdscgreynetlist`, `telescope-sdscnt-pcap-live`) using the key in `/expanse/lustre/projects/sdp178/kmok/.ucsdnts3greynet.env`, lists their contents, byte-sniffs sample objects, and confirms whether the data is in FlowTuple (Avro) format. |
| [`greynet_pcap_to_flowtuple.ipynb`](greynet_pcap_to_flowtuple.ipynb) | SDSC Expanse (Jupyter session or `run_nb.sh` batch job) | Streams the raw greynet pcaps from `telescope-sdscnt-pcap-live`, aggregates packets into per-destination FlowTuple records (one Parquet file per pcap under `flowtuples/`), then reports on them: unique source/destination addresses, protocol mix, TCP/UDP ports, TCP flags, ICMP types, top sources, TTLs and packet sizes. |

The notebooks are read-only against the object store and print no credential values.
Companion context: the darknet-side modules
[`nids-telescope-traffic`](https://github.com/CAIDA/nids-telescope-traffic) and
[`nids-ucsdnt-expanse`](https://github.com/CAIDA/nids-ucsdnt-expanse).
