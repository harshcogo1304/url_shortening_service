# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_12_01_110571) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_topology"
  enable_extension "uuid-ossp"

  create_table "air_customs_rate_audits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "bulk_operation_id"
    t.uuid "rate_sheet_id"
    t.string "object_type"
    t.uuid "object_id"
    t.string "action_name"
    t.uuid "performed_by_id"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "procured_by_id"
    t.uuid "sourced_by_id"
    t.index ["bulk_operation_id"], name: "index_air_customs_rate_audits_on_bulk_operation_id"
    t.index ["object_type", "object_id"], name: "index_air_customs_rate_audits_on_object_type_and_object_id"
    t.index ["rate_sheet_id"], name: "index_air_customs_rate_audits_on_rate_sheet_id"
  end

  create_table "air_customs_rate_bulk_operations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "progress", default: 0
    t.string "action_name"
    t.uuid "performed_by_id"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "service_provider_id"
    t.index ["service_provider_id"], name: "index_air_customs_rate_bulk_operations_on_service_provider_id"
  end

  create_table "air_customs_rate_feedbacks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "source"
    t.uuid "source_id"
    t.uuid "performed_by_id"
    t.string "performed_by_org_id"
    t.string "performed_by_type"
    t.float "preferred_customs_rate"
    t.string "preferred_customs_rate_currency"
    t.string "feedbacks", array: true
    t.string "remarks", array: true
    t.uuid "air_customs_rate_id"
    t.uuid "validity_id"
    t.string "outcome"
    t.uuid "outcome_object_id"
    t.jsonb "booking_params"
    t.string "feedback_type"
    t.string "status"
    t.string "closing_remarks", array: true
    t.uuid "closed_by_id"
    t.bigserial "serial_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "air_customs_rate_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "source"
    t.uuid "source_id"
    t.uuid "performed_by_id"
    t.string "performed_by_org_id"
    t.string "performed_by_type"
    t.float "preferred_customs_rate"
    t.string "preferred_customs_rate_currency"
    t.integer "preferred_detention_free_days"
    t.integer "preferred_storage_free_days"
    t.datetime "cargo_readiness_date"
    t.string "remarks", array: true
    t.jsonb "booking_params"
    t.string "request_type"
    t.string "status"
    t.string "closing_remarks", array: true
    t.uuid "closed_by_id"
    t.bigserial "serial_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "weight"
    t.float "volume"
    t.string "commodity"
    t.uuid "country_id"
    t.uuid "airport_id"
    t.uuid "trade_id"
    t.uuid "continent_id"
    t.uuid "city_id"
    t.string "trade_type"
  end

  create_table "air_customs_rates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "airport_id"
    t.uuid "country_id"
    t.uuid "trade_id"
    t.uuid "continent_id"
    t.string "trade_type"
    t.uuid "service_provider_id"
    t.uuid "importer_exporter_id"
    t.string "commodity"
    t.jsonb "line_items"
    t.boolean "is_line_items_error_messages_present"
    t.boolean "is_line_items_info_messages_present"
    t.jsonb "line_items_error_messages"
    t.jsonb "line_items_info_messages"
    t.boolean "rate_not_available_entry", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "location_ids", array: true
    t.string "rate_type"
    t.index ["airport_id", "trade_type", "importer_exporter_id", "commodity"], name: "index_air_customs_search_params"
    t.index ["airport_id"], name: "index_air_customs_rates_on_airport_id"
    t.index ["continent_id"], name: "index_air_customs_rates_on_continent_id"
    t.index ["country_id"], name: "index_air_customs_rates_on_country_id"
    t.index ["location_ids"], name: "air_customs_rates_idx_on_location_ids", using: :gin
    t.index ["service_provider_id"], name: "index_air_customs_rates_on_service_provider_id"
    t.index ["trade_id"], name: "index_air_customs_rates_on_trade_id"
    t.index ["updated_at", "id", "service_provider_id"], name: "index_air_customs_rates_on_uad_id_spid", order: { updated_at: :desc }
    t.index ["updated_at", "service_provider_id"], name: "index_air_customs_rates_on_uad_spid", order: { updated_at: :desc }
  end

  create_table "air_flight_infos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "air_tracking_id"
    t.datetime "expected_depart_time"
    t.datetime "actual_depart_time"
    t.string "depart_station"
    t.datetime "expected_arrival_time"
    t.datetime "actual_arrival_time"
    t.string "arrival_station"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "flight_number"
    t.string "arrival_lat"
    t.string "arrival_long"
    t.string "departure_lat"
    t.string "departure_long"
    t.string "depart_port_code"
    t.string "arrival_port_code"
    t.index ["air_tracking_id"], name: "index_air_flight_info_on_air_trcking_id"
  end

  create_table "air_freight_rate_audits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "bulk_operation_id"
    t.uuid "rate_sheet_id"
    t.string "object_type"
    t.uuid "object_id"
    t.string "action_name"
    t.uuid "performed_by_id"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "procured_by_id"
    t.uuid "sourced_by_id"
    t.uuid "validity_id"
    t.index ["bulk_operation_id"], name: "index_air_freight_rate_audits_on_bulk_operation_id"
    t.index ["object_type", "object_id"], name: "index_air_freight_rate_audits_on_object_type_and_object_id"
    t.index ["rate_sheet_id"], name: "index_air_freight_rate_audits_on_rate_sheet_id"
  end

  create_table "air_freight_rate_bulk_operations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "progress", default: 0
    t.string "action_name"
    t.uuid "performed_by_id"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "service_provider_id"
    t.index ["service_provider_id"], name: "index_air_freight_rate_bulk_operations_on_service_provider_id"
  end

  create_table "air_freight_rate_feedbacks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "source"
    t.uuid "source_id"
    t.string "feedbacks", array: true
    t.string "remarks", array: true
    t.uuid "air_freight_rate_id"
    t.uuid "validity_id"
    t.uuid "performed_by_id"
    t.uuid "performed_by_org_id"
    t.string "performed_by_type"
    t.float "preferred_freight_rate"
    t.string "preferred_freight_rate_currency"
    t.integer "preferred_storage_free_days"
    t.uuid "preferred_airline_ids", array: true
    t.string "outcome"
    t.uuid "outcome_object_id"
    t.jsonb "booking_params"
    t.string "feedback_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "closing_remarks", default: [], array: true
    t.bigserial "serial_id", null: false
    t.uuid "closed_by_id"
    t.string "trade_type"
  end

  create_table "air_freight_rate_locals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "airline_id"
    t.uuid "airport_id"
    t.uuid "country_id"
    t.uuid "trade_id"
    t.uuid "continent_id"
    t.string "trade_type"
    t.string "commodity"
    t.uuid "service_provider_id"
    t.decimal "min_price", precision: 10, scale: 2
    t.string "currency"
    t.integer "bookings_count"
    t.integer "bookings_importer_exporters_count"
    t.integer "spot_searches_count"
    t.integer "spot_searches_importer_exporters_count"
    t.integer "priority_score"
    t.datetime "priority_score_updated_at"
    t.jsonb "line_items"
    t.boolean "is_line_items_error_messages_present"
    t.boolean "is_line_items_info_messages_present"
    t.jsonb "line_items_error_messages"
    t.jsonb "line_items_info_messages"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "storage_rate_id"
    t.uuid "location_ids", array: true
    t.string "commodity_type"
    t.string "rate_type"
    t.index ["location_ids"], name: "air_freight_rate_locals_idx_on_location_ids", using: :gin
    t.index ["priority_score", "id", "service_provider_id"], name: "index_air_freight_rate_locals_on_psd_id_spid", order: { priority_score: :desc }
    t.index ["priority_score", "service_provider_id"], name: "index_air_freight_rate_locals_on_psd_spid", order: { priority_score: :desc }
    t.index ["updated_at", "id", "service_provider_id"], name: "index_air_freight_rate_locals_on_uad_id_spid", order: { updated_at: :desc }
    t.index ["updated_at", "service_provider_id"], name: "index_air_freight_rate_locals_on_uad_spid", order: { updated_at: :desc }
  end

  create_table "air_freight_rate_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "source"
    t.uuid "source_id"
    t.uuid "performed_by_id"
    t.string "performed_by_org_id"
    t.string "performed_by_type"
    t.jsonb "booking_params"
    t.string "request_type"
    t.string "status"
    t.float "preferred_freight_rate"
    t.string "preferred_freight_rate_currency"
    t.integer "preferred_detention_free_days"
    t.integer "preferred_storage_free_days"
    t.uuid "preferred_airline_ids", default: [], array: true
    t.string "remarks", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "closing_remarks", array: true
    t.datetime "cargo_readiness_date"
    t.bigserial "serial_id", null: false
    t.uuid "closed_by_id"
    t.float "weight"
    t.float "volume"
    t.string "inco_term"
    t.string "commodity"
    t.string "cargo_stacking_type"
    t.integer "packages_count"
    t.jsonb "packages"
    t.uuid "destination_continent_id"
    t.uuid "destination_country_id"
    t.uuid "destination_airport_id"
    t.uuid "destination_trade_id"
    t.uuid "origin_continent_id"
    t.uuid "origin_country_id"
    t.uuid "origin_airport_id"
    t.uuid "origin_trade_id"
    t.string "commodity_type"
    t.string "commodity_sub_type"
    t.string "trade_type"
    t.uuid "cogo_entity_id"
  end

  create_table "air_freight_rate_surcharges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "origin_airport_id"
    t.uuid "origin_country_id"
    t.uuid "origin_trade_id"
    t.uuid "origin_continent_id"
    t.uuid "destination_airport_id"
    t.uuid "destination_country_id"
    t.uuid "destination_trade_id"
    t.uuid "destination_continent_id"
    t.string "commodity"
    t.uuid "airline_id"
    t.uuid "service_provider_id"
    t.jsonb "line_items"
    t.boolean "is_line_items_error_messages_present"
    t.boolean "is_line_items_info_messages_present"
    t.jsonb "line_items_error_messages"
    t.jsonb "line_items_info_messages"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "origin_location_ids", array: true
    t.uuid "destination_location_ids", array: true
    t.string "operation_type"
    t.string "commodity_type"
    t.index ["destination_location_ids"], name: "air_freight_rate_surcharges_idx_on_des_location_ids", using: :gin
    t.index ["operation_type"], name: "index_air_freight_rate_surcharges_on_operation_type"
    t.index ["origin_location_ids"], name: "air_freight_rate_surcharges_idx_on_ori_location_ids", using: :gin
    t.index ["updated_at", "id", "service_provider_id"], name: "index_air_freight_rate_surcharges_on_uad_id_spid", order: { updated_at: :desc }
    t.index ["updated_at", "service_provider_id"], name: "index_air_freight_rate_surcharges_on_uad_spid", order: { updated_at: :desc }
  end

  create_table "air_freight_rate_tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "service"
    t.uuid "airport_id"
    t.uuid "country_id"
    t.uuid "trade_id"
    t.uuid "location_ids", array: true
    t.string "commodity"
    t.string "commodity_type"
    t.string "logistics_service_type"
    t.string "trade_type"
    t.uuid "airline_id"
    t.string "source"
    t.integer "source_count"
    t.string "task_type"
    t.string "status"
    t.jsonb "completion_data"
    t.string "completed_at"
    t.string "completed_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "job_data"
    t.string "shipment_serial_ids", default: [], array: true
    t.index ["airport_id", "commodity", "trade_type", "airline_id"], name: "idx_airpt_com_trd_airline"
    t.index ["status"], name: "idx_freight_rate_tasks_on_status"
  end

  create_table "air_freight_rates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "origin_airport_id"
    t.uuid "origin_country_id"
    t.uuid "origin_trade_id"
    t.uuid "origin_continent_id"
    t.uuid "destination_airport_id"
    t.uuid "destination_country_id"
    t.uuid "destination_trade_id"
    t.uuid "destination_continent_id"
    t.string "commodity"
    t.uuid "airline_id"
    t.uuid "service_provider_id"
    t.uuid "importer_exporter_id"
    t.decimal "min_price", precision: 10, scale: 2
    t.string "currency"
    t.string "discount_type"
    t.integer "bookings_count"
    t.integer "bookings_importer_exporters_count"
    t.integer "spot_searches_count"
    t.integer "spot_searches_importer_exporters_count"
    t.integer "priority_score"
    t.datetime "priority_score_updated_at"
    t.jsonb "weight_slabs"
    t.boolean "is_best_price"
    t.uuid "origin_local_id"
    t.uuid "destination_local_id"
    t.uuid "surcharge_id"
    t.uuid "warehouse_rate_id"
    t.boolean "rate_not_available_entry", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "origin_storage_id"
    t.uuid "destination_storage_id"
    t.uuid "origin_location_ids", array: true
    t.uuid "destination_location_ids", array: true
    t.string "operation_type"
    t.jsonb "validities", default: []
    t.datetime "last_rate_available_date"
    t.integer "length"
    t.integer "breadth"
    t.integer "height"
    t.integer "maximum_weight"
    t.string "shipment_type"
    t.string "stacking_type"
    t.string "commodity_sub_type"
    t.string "commodity_type"
    t.string "price_type"
    t.uuid "cogo_entity_id"
    t.string "rate_type"
    t.string "source"
    t.string "external_rate_id"
    t.string "flight_uuid"
    t.index ["cogo_entity_id"], name: "index_on_cogo_entity"
    t.index ["destination_location_ids"], name: "air_freight_rates_idx_on_des_location_ids", using: :gin
    t.index ["operation_type"], name: "index_air_freight_rates_on_operation_type"
    t.index ["origin_airport_id", "destination_airport_id", "commodity", "commodity_type", "commodity_sub_type", "service_provider_id", "airline_id", "operation_type", "shipment_type", "stacking_type", "price_type", "cogo_entity_id", "rate_type", "source"], name: "index_afr_oaid_daid_co_sp_ai_ot_ei_rt_sr", unique: true, where: "(cogo_entity_id IS NOT NULL)"
    t.index ["origin_airport_id", "destination_airport_id", "commodity", "commodity_type", "commodity_sub_type", "service_provider_id", "airline_id", "operation_type", "shipment_type", "stacking_type", "price_type", "rate_type", "source"], name: "index_afr_oaid_daid_co_sp_ai_ot_ei_nl_rt_sr", unique: true, where: "(cogo_entity_id IS NULL)"
    t.index ["origin_airport_id", "destination_airport_id", "commodity", "rate_not_available_entry", "last_rate_available_date"], name: "index_air_freight_rates_on_spot_search_params"
    t.index ["origin_location_ids"], name: "air_freight_rates_idx_on_ori_location_ids", using: :gin
    t.index ["priority_score", "id", "service_provider_id"], name: "index_air_freight_rates_on_psd_id_spid", order: { priority_score: :desc }
    t.index ["priority_score", "service_provider_id", "last_rate_available_date"], name: "index_air_freight_rates_on_priority_score_spid_lrad", order: { priority_score: :desc }
    t.index ["priority_score", "service_provider_id"], name: "index_air_freight_rates_on_psd_spid", order: { priority_score: :desc }
    t.index ["updated_at", "id", "service_provider_id"], name: "index_air_freight_rates_on_uad_id_spid", order: { updated_at: :desc }
    t.index ["updated_at", "service_provider_id"], name: "index_air_freight_rates_on_uad_spid", order: { updated_at: :desc }
  end

  create_table "air_freight_storage_rates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "airline_id"
    t.uuid "airport_id"
    t.uuid "country_id"
    t.uuid "trade_id"
    t.uuid "continent_id"
    t.uuid "location_ids", default: [], array: true
    t.uuid "service_provider_id"
    t.uuid "importer_exporter_id"
    t.string "commodity"
    t.string "trade_type"
    t.integer "priority_score"
    t.datetime "priority_score_updated_at"
    t.integer "free_limit"
    t.jsonb "slabs"
    t.boolean "is_slabs_missing"
    t.string "remarks", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["airport_id", "airline_id", "commodity", "trade_type"], name: "air_freight_st_portid_aid_co_tt_idx"
    t.index ["airport_id", "airline_id", "trade_type", "commodity", "service_provider_id"], name: "air_fsr_portid_aid_tt_co_spid_uniq_idx", unique: true
    t.index ["location_ids"], name: "air_freight_st_idx_on_location_ids", using: :gin
  end

  create_table "air_freight_warehouse_rates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "airport_id"
    t.uuid "country_id"
    t.uuid "trade_id"
    t.uuid "continent_id"
    t.string "trade_type"
    t.string "commodity"
    t.uuid "service_provider_id"
    t.uuid "importer_exporter_id"
    t.integer "bookings_count"
    t.integer "bookings_importer_exporters_count"
    t.integer "spot_searches_count"
    t.integer "spot_searches_importer_exporters_count"
    t.integer "priority_score"
    t.datetime "priority_score_updated_at"
    t.jsonb "line_items"
    t.boolean "is_line_items_error_messages_present"
    t.boolean "is_line_items_info_messages_present"
    t.jsonb "line_items_error_messages"
    t.jsonb "line_items_info_messages"
    t.boolean "rate_not_available_entry", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "location_ids", array: true
    t.index ["location_ids"], name: "air_freight_wh_rates_idx_on_location_ids", using: :gin
    t.index ["priority_score", "id", "service_provider_id"], name: "index_air_freight_warehouse_rates_on_psd_id_spid", order: { priority_score: :desc }
    t.index ["priority_score", "service_provider_id"], name: "index_air_freight_warehouse_rates_on_psd_spid", order: { priority_score: :desc }
    t.index ["updated_at", "id", "service_provider_id"], name: "index_air_freight_warehouse_rates_on_uad_id_spid", order: { updated_at: :desc }
    t.index ["updated_at", "service_provider_id"], name: "index_air_freight_warehouse_rates_on_uad_spid", order: { updated_at: :desc }
  end

  create_table "air_india_awb_numbers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "booking_information_id"
    t.string "awb_number"
    t.string "flight_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["awb_number"], name: "air_india_awb_number"
  end

  create_table "air_india_lms", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.uuid "lms_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "air_milestones", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "air_tracking_id"
    t.datetime "actual_date"
    t.datetime "expected_date"
    t.string "milestone"
    t.string "station"
    t.string "flight_number"
    t.string "status"
    t.string "piece"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "weight"
    t.index ["air_tracking_id"], name: "index_air_milestone_data_on_air_trcking_no"
  end

  create_table "air_schedule_airport_pairs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "origin_airport_id"
    t.uuid "destination_airport_id"
    t.string "status"
    t.datetime "last_scraped_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destination_airport_id", "origin_airport_id", "status"], name: "index_air_schedule_airport_pair_on_oair_dair_status"
    t.index ["last_scraped_at"], name: "index_air_schedule_airport_pair_on_last_scraped_at"
    t.index ["origin_airport_id", "destination_airport_id"], name: "index_air_schedule_airport_pair_on_oair_dair", unique: true
    t.index ["status", "last_scraped_at"], name: "index_air_schedule_airport_pair_on_status_last_scraped_at"
  end

  create_table "air_schedule_scrapings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "origin_airport_id"
    t.uuid "destination_airport_id"
    t.jsonb "schedules"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destination_airport_id", "origin_airport_id"], name: "index_air_schedule_scraping_on_dair_oair"
  end

  create_table "air_schedule_subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "origin_airport_id"
    t.uuid "destination_airport_id"
    t.uuid "organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destination_airport_id", "origin_airport_id", "organization_id"], name: "index_air_schedule_subscription_on_dair_oair_org"
    t.index ["organization_id"], name: "index_air_schedule_subscription_on_org"
    t.index ["origin_airport_id", "organization_id"], name: "index_air_schedule_subscription_on_oair_org"
  end

  create_table "air_schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "origin_airport_id"
    t.uuid "origin_country_id"
    t.uuid "origin_trade_id"
    t.uuid "destination_airport_id"
    t.uuid "destination_country_id"
    t.uuid "destination_trade_id"
    t.uuid "airline_id"
    t.datetime "departure"
    t.datetime "arrival"
    t.integer "number_of_stops"
    t.integer "transit_time"
    t.string "operation_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["origin_airport_id", "destination_airport_id", "departure"], name: "index_air_schedule_on_oair_dair_dept"
  end

  create_table "air_tracking_api_audits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "air_tracking_id"
    t.jsonb "data"
    t.string "action"
    t.string "object_type"
    t.uuid "performed_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["air_tracking_id"], name: "index_air_trking_audits_on_air_trkig_id"
  end

  create_table "air_tracking_external_sources", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "source"
    t.string "airway_bill_no"
    t.uuid "airline_id"
    t.jsonb "response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "original_response"
    t.index ["airway_bill_no"], name: "index_air_trking_ext_src_on_arwy_bill_no"
  end

  create_table "air_trackings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "airway_bill_no"
    t.uuid "airline_id"
    t.string "final_eta"
    t.string "origin"
    t.string "destination"
    t.string "tracking_status"
    t.datetime "first_scrapped_at"
    t.datetime "last_scrapped_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "weight"
    t.string "piece"
    t.datetime "departure_date"
    t.datetime "arrival_date"
    t.jsonb "airline_info"
    t.index ["airway_bill_no"], name: "index_air_tracking_on_arwy_bill_no"
  end

  create_table "airline_airport_terminal_mappings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "airline_id"
    t.uuid "airport_id"
    t.uuid "terminal_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["airline_id", "airport_id"], name: "index_on_airline_airport"
    t.index ["terminal_id", "airport_id"], name: "index_on_terminal_airport"
  end

