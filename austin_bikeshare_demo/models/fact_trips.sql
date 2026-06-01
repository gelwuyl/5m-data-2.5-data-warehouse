{{ config(materialized='view') }}

SELECT
    trip_id,
    subscriber_type,
    bike_id,
    bike_type,
    start_time,
    start_station_id,
    start_station_name,
    CAST(end_station_id AS INT64) as end_station_id,
    end_station_name,
    duration_minutes
FROM {{ source('austin_bikeshare', 'bikeshare_trips') }}