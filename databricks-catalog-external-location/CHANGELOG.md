# Changelog

## [0.3.0](https://github.com/chanzuckerberg/cztack/compare/databricks-catalog-external-location-v0.2.3...databricks-catalog-external-location-v0.3.0) (2026-11-03)


### ⚠ BREAKING CHANGES

* catalog member attributes are renamed to tier codes (all_privileges_members -> all_members, manage_privileges_members -> mng_members, read_privileges_members -> r_members, write_privileges_members -> rw_members, use_privileges_members -> usg_members); the old names fail validation. catalog_groups keys change to all, mng, r, rw, usg, crt. Members of rw who create schemas must also be added to crt_members. Catalog-level r and rw grant more privileges, inherited by every schema and Volume in the catalog. See the module README.

### Features

* shared Unity Catalog privilege tiers in databricks-catalog-external-location ([#939](https://github.com/chanzuckerberg/cztack/issues/939)) ([0d9c894](https://github.com/chanzuckerberg/cztack/commit/0d9c8941a6ded353f836736c93a3be533c7245ed))

## [0.2.3](https://github.com/chanzuckerberg/cztack/compare/databricks-catalog-external-location-v0.2.2...databricks-catalog-external-location-v0.2.3) (2026-06-18)


### Bug Fixes

* relax databricks provider pin in databricks-catalog-external-location to &gt;= 1.49.1 ([#882](https://github.com/chanzuckerberg/cztack/issues/882)) ([7b46912](https://github.com/chanzuckerberg/cztack/commit/7b46912895cf1dab23a5efb46c982c88ef154b22))

## [0.2.2](https://github.com/chanzuckerberg/cztack/compare/databricks-catalog-external-location-v0.2.1...databricks-catalog-external-location-v0.2.2) (2026-01-13)


### Bug Fixes

* typo with external dns sources ([#803](https://github.com/chanzuckerberg/cztack/issues/803)) ([80c27fc](https://github.com/chanzuckerberg/cztack/commit/80c27fcacd9ea7d0d3e856ad91f8d9f2bc8a0ef7))

## [0.2.1](https://github.com/chanzuckerberg/cztack/compare/databricks-catalog-external-location-v0.2.0...databricks-catalog-external-location-v0.2.1) (2025-12-18)


### Bug Fixes

* CDI-4634 - dbx permission assignment ([#781](https://github.com/chanzuckerberg/cztack/issues/781)) ([dbc296b](https://github.com/chanzuckerberg/cztack/commit/dbc296b617bf7ecef96cfb9e70d28918b2827e10))

## [0.2.0](https://github.com/chanzuckerberg/cztack/compare/databricks-catalog-external-location-v0.1.0...databricks-catalog-external-location-v0.2.0) (2025-12-17)


### Features

* add catalog group map output to dbx catalogs ([#774](https://github.com/chanzuckerberg/cztack/issues/774)) ([9b2d5f3](https://github.com/chanzuckerberg/cztack/commit/9b2d5f3b383803e3b798065180611f35881310e7))
