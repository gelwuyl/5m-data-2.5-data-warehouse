Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices



## Project Structure: Austin Bikeshare Demo

```
austin_bikeshare_demo/
├── dbt_project.yml          # Project configuration
├── profiles.yml             # BigQuery connection details
├── models/
│   ├── sources.yml          # Source declarations for Austin Bikeshare
│   ├── fact_trips.sql       # Fact table: one row per bike trip
│   ├── schema.yml           # Tests for fact table
│   └── star/
│       └── dim_station.sql  # Dimension table: bike stations
└── README.md                # This file
```

### Star Schema Design

**Fact Table (`fact_trips`):**
- One row per bike trip
- Foreign keys: `start_station_id`, `end_station_id`
- Measures: `duration_minutes`

**Dimension Table (`dim_station`):**
- One row per bike station
- Attributes: `station_id`, `name`, `location`, `address`, `capacity`, etc.