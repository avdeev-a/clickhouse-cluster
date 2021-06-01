CREATE DATABASE graphite;

CREATE TABLE graphite.metrics (
  Date Date,
  Level UInt32,
  Path String,
  Deleted UInt8,
  Version UInt32 )
ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{shard}/graphite.metrics','{replica}', Date, (Level, Path), 8192, Version);

CREATE TABLE graphite.data (
  Path String,
  Value Float64,
  Time UInt32,
  Date Date,
  Timestamp UInt32 )
ENGINE = ReplicatedGraphiteMergeTree('/clickhouse/tables/{shard}/graphite.data', '{replica}', Date, (Path, Time), 8192, 'graphite_rollup');

CREATE TABLE graphite.tags (
  Date Date,
  Tag1 String,
  Path String,
  Tags Array(String),
  Version UInt32
) ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{shard}/graphite.tags','{replica}', Date, (Tag1, Path), 8192, Version);