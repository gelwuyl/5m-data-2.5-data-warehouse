{{ config(materialized='table', schema='star') }}

SELECT
    station_id,
    name as station_name,
    status,
    location,
    address,
    alternate_name,
    city_asset_number,
    property_type,
    number_of_docks,
    power_type,
    footprint_length,
    footprint_width,
    notes,
    council_district,
    image,
    modified_date
    , COALESCE(trips_start.total_duration, 0) AS total_duration
    , COALESCE(trips_start.total_starts, 0) AS total_starts
    , COALESCE(trips_end.total_ends, 0) AS total_ends
FROM {{ source('austin_bikeshare', 'bikeshare_stations') }}
LEFT JOIN (
    SELECT
        SAFE_CAST(start_station_id AS INT64) AS start_station_id,
        SUM(duration_minutes * 60) AS total_duration,
        COUNT(start_station_name) AS total_starts
    FROM {{ source('austin_bikeshare', 'bikeshare_trips') }}
    WHERE SAFE_CAST(start_station_id AS INT64) IS NOT NULL
    GROUP BY SAFE_CAST(start_station_id AS INT64)
) AS trips_start
    ON trips_start.start_station_id = station_id
LEFT JOIN (
    SELECT
        SAFE_CAST(end_station_id AS INT64) AS end_station_id,
        COUNT(end_station_name) AS total_ends
    FROM {{ source('austin_bikeshare', 'bikeshare_trips') }}
    WHERE SAFE_CAST(end_station_id AS INT64) IS NOT NULL
    GROUP BY SAFE_CAST(end_station_id AS INT64)
) AS trips_end
    ON trips_end.end_station_id = station_id