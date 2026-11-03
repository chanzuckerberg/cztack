# Changelog

## 0.1.0 (2026-11-03)


### ⚠ BREAKING CHANGES

* catalog member attributes are renamed to tier codes (all_privileges_members -> all_members, manage_privileges_members -> mng_members, read_privileges_members -> r_members, write_privileges_members -> rw_members, use_privileges_members -> usg_members); the old names fail validation. catalog_groups keys change to all, mng, r, rw, usg, crt. Members of rw who create schemas must also be added to crt_members. Catalog-level r and rw grant more privileges, inherited by every schema and Volume in the catalog. See the module README.

### Features

* shared Unity Catalog privilege tiers in databricks-catalog-external-location ([#939](https://github.com/chanzuckerberg/cztack/issues/939)) ([0d9c894](https://github.com/chanzuckerberg/cztack/commit/0d9c8941a6ded353f836736c93a3be533c7245ed))
