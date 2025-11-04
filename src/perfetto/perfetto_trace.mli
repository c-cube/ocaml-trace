
(** Code for perfetto_trace.proto *)

(* generated from "perfetto_trace.proto", do not edit *)



(** {2 Types} *)

type ftrace_descriptor_atrace_category = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable description : string;
}

type ftrace_descriptor = private {
  mutable atrace_categories : ftrace_descriptor_atrace_category list;
}

type gpu_counter_descriptor_gpu_counter_group =
  | Unclassified 
  | System 
  | Vertices 
  | Fragments 
  | Primitives 
  | Memory 
  | Compute 
  | Ray_tracing 

type gpu_counter_descriptor_measure_unit =
  | None 
  | Bit 
  | Kilobit 
  | Megabit 
  | Gigabit 
  | Terabit 
  | Petabit 
  | Byte 
  | Kilobyte 
  | Megabyte 
  | Gigabyte 
  | Terabyte 
  | Petabyte 
  | Hertz 
  | Kilohertz 
  | Megahertz 
  | Gigahertz 
  | Terahertz 
  | Petahertz 
  | Nanosecond 
  | Microsecond 
  | Millisecond 
  | Second 
  | Minute 
  | Hour 
  | Vertex 
  | Pixel 
  | Triangle 
  | Primitive 
  | Fragment 
  | Milliwatt 
  | Watt 
  | Kilowatt 
  | Joule 
  | Volt 
  | Ampere 
  | Celsius 
  | Fahrenheit 
  | Kelvin 
  | Percent 
  | Instruction 

type gpu_counter_descriptor_gpu_counter_spec_peak_value =
  | Int_peak_value of int64
  | Double_peak_value of float

and gpu_counter_descriptor_gpu_counter_spec = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable counter_id : int32;
  mutable name : string;
  mutable description : string;
  mutable peak_value : gpu_counter_descriptor_gpu_counter_spec_peak_value option;
  mutable numerator_units : gpu_counter_descriptor_measure_unit list;
  mutable denominator_units : gpu_counter_descriptor_measure_unit list;
  mutable select_by_default : bool;
  mutable groups : gpu_counter_descriptor_gpu_counter_group list;
}

type gpu_counter_descriptor_gpu_counter_block = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable block_id : int32;
  mutable block_capacity : int32;
  mutable name : string;
  mutable description : string;
  mutable counter_ids : int32 list;
}

type gpu_counter_descriptor = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable specs : gpu_counter_descriptor_gpu_counter_spec list;
  mutable blocks : gpu_counter_descriptor_gpu_counter_block list;
  mutable min_sampling_period_ns : int64;
  mutable max_sampling_period_ns : int64;
  mutable supports_instrumented_sampling : bool;
}

type track_event_category = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable description : string;
  mutable tags : string list;
}

type track_event_descriptor = private {
  mutable available_categories : track_event_category list;
}

type data_source_descriptor = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable name : string;
  mutable id : int64;
  mutable will_notify_on_stop : bool;
  mutable will_notify_on_start : bool;
  mutable handles_incremental_state_clear : bool;
  mutable no_flush : bool;
  mutable gpu_counter_descriptor : gpu_counter_descriptor option;
  mutable track_event_descriptor : track_event_descriptor option;
  mutable ftrace_descriptor : ftrace_descriptor option;
}

type tracing_service_state_producer = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable id : int32;
  mutable name : string;
  mutable pid : int32;
  mutable uid : int32;
  mutable sdk_version : string;
  mutable frozen : bool;
}

type tracing_service_state_data_source = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable ds_descriptor : data_source_descriptor option;
  mutable producer_id : int32;
}

type tracing_service_state_tracing_session = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 10 fields *)
  mutable id : int64;
  mutable consumer_uid : int32;
  mutable state : string;
  mutable unique_session_name : string;
  mutable buffer_size_kb : int32 list;
  mutable duration_ms : int32;
  mutable num_data_sources : int32;
  mutable start_realtime_ns : int64;
  mutable bugreport_score : int32;
  mutable bugreport_filename : string;
  mutable is_started : bool;
}

type tracing_service_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable producers : tracing_service_state_producer list;
  mutable data_sources : tracing_service_state_data_source list;
  mutable tracing_sessions : tracing_service_state_tracing_session list;
  mutable supports_tracing_sessions : bool;
  mutable num_sessions : int32;
  mutable num_sessions_started : int32;
  mutable tracing_service_version : string;
}

type builtin_clock =
  | Builtin_clock_unknown 
  | Builtin_clock_realtime 
  | Builtin_clock_realtime_coarse 
  | Builtin_clock_monotonic 
  | Builtin_clock_monotonic_coarse 
  | Builtin_clock_monotonic_raw 
  | Builtin_clock_boottime 
  | Builtin_clock_tsc 
  | Builtin_clock_perf 
  | Builtin_clock_max_id 

type android_game_intervention_list_config = private {
  mutable package_name_filter : string list;
}

type proto_log_level =
  | Protolog_level_undefined 
  | Protolog_level_debug 
  | Protolog_level_verbose 
  | Protolog_level_info 
  | Protolog_level_warn 
  | Protolog_level_error 
  | Protolog_level_wtf 

type proto_log_config_tracing_mode =
  | Default 
  | Enable_all 

type proto_log_group = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable group_name : string;
  mutable log_from : proto_log_level;
  mutable collect_stacktrace : bool;
}

type proto_log_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable group_overrides : proto_log_group list;
  mutable tracing_mode : proto_log_config_tracing_mode;
  mutable default_log_from_level : proto_log_level;
}

type surface_flinger_layers_config_mode =
  | Mode_unspecified 
  | Mode_active 
  | Mode_generated 
  | Mode_dump 
  | Mode_generated_bugreport_only 

type surface_flinger_layers_config_trace_flag =
  | Trace_flag_unspecified 
  | Trace_flag_input 
  | Trace_flag_composition 
  | Trace_flag_extra 
  | Trace_flag_hwc 
  | Trace_flag_buffers 
  | Trace_flag_virtual_displays 
  | Trace_flag_all 

type surface_flinger_layers_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable mode : surface_flinger_layers_config_mode;
  mutable trace_flags : surface_flinger_layers_config_trace_flag list;
}

type surface_flinger_transactions_config_mode =
  | Mode_unspecified 
  | Mode_continuous 
  | Mode_active 

type surface_flinger_transactions_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable mode : surface_flinger_transactions_config_mode;
}

type window_manager_config_log_frequency =
  | Log_frequency_unspecified 
  | Log_frequency_frame 
  | Log_frequency_transaction 
  | Log_frequency_single_dump 

type window_manager_config_log_level =
  | Log_level_unspecified 
  | Log_level_verbose 
  | Log_level_debug 
  | Log_level_critical 

type window_manager_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable log_frequency : window_manager_config_log_frequency;
  mutable log_level : window_manager_config_log_level;
}

type chrome_config_client_priority =
  | Unknown 
  | Background 
  | User_initiated 

type chrome_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable trace_config : string;
  mutable privacy_filtering_enabled : bool;
  mutable convert_to_legacy_json : bool;
  mutable client_priority : chrome_config_client_priority;
  mutable json_agent_label_filter : string;
  mutable event_package_name_filter_enabled : bool;
}

type chromium_histogram_samples_config_histogram_sample = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable histogram_name : string;
  mutable min_value : int64;
  mutable max_value : int64;
}

type chromium_histogram_samples_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable histograms : chromium_histogram_samples_config_histogram_sample list;
  mutable filter_histogram_names : bool;
}

type chromium_system_metrics_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable sampling_interval_ms : int32;
}

type v8_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable log_script_sources : bool;
  mutable log_instructions : bool;
}

type etw_config_kernel_flag =
  | Cswitch 
  | Dispatcher 

type etw_config = private {
  mutable kernel_flags : etw_config_kernel_flag list;
  mutable scheduler_provider_events : string list;
  mutable memory_provider_events : string list;
  mutable file_provider_events : string list;
}

type frozen_ftrace_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable instance_name : string;
}

type inode_file_config_mount_point_mapping_entry = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable mountpoint : string;
  mutable scan_roots : string list;
}

type inode_file_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable scan_interval_ms : int32;
  mutable scan_delay_ms : int32;
  mutable scan_batch_size : int32;
  mutable do_not_scan : bool;
  mutable scan_mount_points : string list;
  mutable mount_point_mapping : inode_file_config_mount_point_mapping_entry list;
}

type console_config_output =
  | Output_unspecified 
  | Output_stdout 
  | Output_stderr 

type console_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable output : console_config_output;
  mutable enable_colors : bool;
}

type interceptor_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable name : string;
  mutable console_config : console_config option;
}

type android_power_config_battery_counters =
  | Battery_counter_unspecified 
  | Battery_counter_charge 
  | Battery_counter_capacity_percent 
  | Battery_counter_current 
  | Battery_counter_current_avg 
  | Battery_counter_voltage 

type android_power_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable battery_poll_ms : int32;
  mutable battery_counters : android_power_config_battery_counters list;
  mutable collect_power_rails : bool;
  mutable collect_energy_estimation_breakdown : bool;
  mutable collect_entity_state_residency : bool;
}

type priority_boost_config_boost_policy =
  | Policy_unspecified 
  | Policy_sched_other 
  | Policy_sched_fifo 

type priority_boost_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable policy : priority_boost_config_boost_policy;
  mutable priority : int32;
}

type process_stats_config_quirks =
  | Quirks_unspecified 
  | Disable_initial_dump 
  | Disable_on_demand 

type process_stats_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 9 fields *)
  mutable quirks : process_stats_config_quirks list;
  mutable scan_all_processes_on_start : bool;
  mutable record_thread_names : bool;
  mutable proc_stats_poll_ms : int32;
  mutable proc_stats_cache_ttl_ms : int32;
  mutable scan_smaps_rollup : bool;
  mutable record_process_age : bool;
  mutable record_process_runtime : bool;
  mutable record_process_dmabuf_rss : bool;
  mutable resolve_process_fds : bool;
}

type heapprofd_config_continuous_dump_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable dump_phase_ms : int32;
  mutable dump_interval_ms : int32;
}

type heapprofd_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 17 fields *)
  mutable sampling_interval_bytes : int64;
  mutable adaptive_sampling_shmem_threshold : int64;
  mutable adaptive_sampling_max_sampling_interval_bytes : int64;
  mutable process_cmdline : string list;
  mutable pid : int64 list;
  mutable target_installed_by : string list;
  mutable heaps : string list;
  mutable exclude_heaps : string list;
  mutable stream_allocations : bool;
  mutable heap_sampling_intervals : int64 list;
  mutable all_heaps : bool;
  mutable all : bool;
  mutable min_anonymous_memory_kb : int32;
  mutable max_heapprofd_memory_kb : int32;
  mutable max_heapprofd_cpu_secs : int64;
  mutable skip_symbol_prefix : string list;
  mutable continuous_dump_config : heapprofd_config_continuous_dump_config option;
  mutable shmem_size_bytes : int64;
  mutable block_client : bool;
  mutable block_client_timeout_us : int32;
  mutable no_startup : bool;
  mutable no_running : bool;
  mutable dump_at_max : bool;
  mutable disable_fork_teardown : bool;
  mutable disable_vfork_detection : bool;
}

type meminfo_counters =
  | Meminfo_unspecified 
  | Meminfo_mem_total 
  | Meminfo_mem_free 
  | Meminfo_mem_available 
  | Meminfo_buffers 
  | Meminfo_cached 
  | Meminfo_swap_cached 
  | Meminfo_active 
  | Meminfo_inactive 
  | Meminfo_active_anon 
  | Meminfo_inactive_anon 
  | Meminfo_active_file 
  | Meminfo_inactive_file 
  | Meminfo_unevictable 
  | Meminfo_mlocked 
  | Meminfo_swap_total 
  | Meminfo_swap_free 
  | Meminfo_dirty 
  | Meminfo_writeback 
  | Meminfo_anon_pages 
  | Meminfo_mapped 
  | Meminfo_shmem 
  | Meminfo_slab 
  | Meminfo_slab_reclaimable 
  | Meminfo_slab_unreclaimable 
  | Meminfo_kernel_stack 
  | Meminfo_page_tables 
  | Meminfo_commit_limit 
  | Meminfo_commited_as 
  | Meminfo_vmalloc_total 
  | Meminfo_vmalloc_used 
  | Meminfo_vmalloc_chunk 
  | Meminfo_cma_total 
  | Meminfo_cma_free 
  | Meminfo_gpu 
  | Meminfo_zram 
  | Meminfo_misc 
  | Meminfo_ion_heap 
  | Meminfo_ion_heap_pool 

type vmstat_counters =
  | Vmstat_unspecified 
  | Vmstat_nr_free_pages 
  | Vmstat_nr_alloc_batch 
  | Vmstat_nr_inactive_anon 
  | Vmstat_nr_active_anon 
  | Vmstat_nr_inactive_file 
  | Vmstat_nr_active_file 
  | Vmstat_nr_unevictable 
  | Vmstat_nr_mlock 
  | Vmstat_nr_anon_pages 
  | Vmstat_nr_mapped 
  | Vmstat_nr_file_pages 
  | Vmstat_nr_dirty 
  | Vmstat_nr_writeback 
  | Vmstat_nr_slab_reclaimable 
  | Vmstat_nr_slab_unreclaimable 
  | Vmstat_nr_page_table_pages 
  | Vmstat_nr_kernel_stack 
  | Vmstat_nr_overhead 
  | Vmstat_nr_unstable 
  | Vmstat_nr_bounce 
  | Vmstat_nr_vmscan_write 
  | Vmstat_nr_vmscan_immediate_reclaim 
  | Vmstat_nr_writeback_temp 
  | Vmstat_nr_isolated_anon 
  | Vmstat_nr_isolated_file 
  | Vmstat_nr_shmem 
  | Vmstat_nr_dirtied 
  | Vmstat_nr_written 
  | Vmstat_nr_pages_scanned 
  | Vmstat_workingset_refault 
  | Vmstat_workingset_activate 
  | Vmstat_workingset_nodereclaim 
  | Vmstat_nr_anon_transparent_hugepages 
  | Vmstat_nr_free_cma 
  | Vmstat_nr_swapcache 
  | Vmstat_nr_dirty_threshold 
  | Vmstat_nr_dirty_background_threshold 
  | Vmstat_pgpgin 
  | Vmstat_pgpgout 
  | Vmstat_pgpgoutclean 
  | Vmstat_pswpin 
  | Vmstat_pswpout 
  | Vmstat_pgalloc_dma 
  | Vmstat_pgalloc_normal 
  | Vmstat_pgalloc_movable 
  | Vmstat_pgfree 
  | Vmstat_pgactivate 
  | Vmstat_pgdeactivate 
  | Vmstat_pgfault 
  | Vmstat_pgmajfault 
  | Vmstat_pgrefill_dma 
  | Vmstat_pgrefill_normal 
  | Vmstat_pgrefill_movable 
  | Vmstat_pgsteal_kswapd_dma 
  | Vmstat_pgsteal_kswapd_normal 
  | Vmstat_pgsteal_kswapd_movable 
  | Vmstat_pgsteal_direct_dma 
  | Vmstat_pgsteal_direct_normal 
  | Vmstat_pgsteal_direct_movable 
  | Vmstat_pgscan_kswapd_dma 
  | Vmstat_pgscan_kswapd_normal 
  | Vmstat_pgscan_kswapd_movable 
  | Vmstat_pgscan_direct_dma 
  | Vmstat_pgscan_direct_normal 
  | Vmstat_pgscan_direct_movable 
  | Vmstat_pgscan_direct_throttle 
  | Vmstat_pginodesteal 
  | Vmstat_slabs_scanned 
  | Vmstat_kswapd_inodesteal 
  | Vmstat_kswapd_low_wmark_hit_quickly 
  | Vmstat_kswapd_high_wmark_hit_quickly 
  | Vmstat_pageoutrun 
  | Vmstat_allocstall 
  | Vmstat_pgrotated 
  | Vmstat_drop_pagecache 
  | Vmstat_drop_slab 
  | Vmstat_pgmigrate_success 
  | Vmstat_pgmigrate_fail 
  | Vmstat_compact_migrate_scanned 
  | Vmstat_compact_free_scanned 
  | Vmstat_compact_isolated 
  | Vmstat_compact_stall 
  | Vmstat_compact_fail 
  | Vmstat_compact_success 
  | Vmstat_compact_daemon_wake 
  | Vmstat_unevictable_pgs_culled 
  | Vmstat_unevictable_pgs_scanned 
  | Vmstat_unevictable_pgs_rescued 
  | Vmstat_unevictable_pgs_mlocked 
  | Vmstat_unevictable_pgs_munlocked 
  | Vmstat_unevictable_pgs_cleared 
  | Vmstat_unevictable_pgs_stranded 
  | Vmstat_nr_zspages 
  | Vmstat_nr_ion_heap 
  | Vmstat_nr_gpu_heap 
  | Vmstat_allocstall_dma 
  | Vmstat_allocstall_movable 
  | Vmstat_allocstall_normal 
  | Vmstat_compact_daemon_free_scanned 
  | Vmstat_compact_daemon_migrate_scanned 
  | Vmstat_nr_fastrpc 
  | Vmstat_nr_indirectly_reclaimable 
  | Vmstat_nr_ion_heap_pool 
  | Vmstat_nr_kernel_misc_reclaimable 
  | Vmstat_nr_shadow_call_stack_bytes 
  | Vmstat_nr_shmem_hugepages 
  | Vmstat_nr_shmem_pmdmapped 
  | Vmstat_nr_unreclaimable_pages 
  | Vmstat_nr_zone_active_anon 
  | Vmstat_nr_zone_active_file 
  | Vmstat_nr_zone_inactive_anon 
  | Vmstat_nr_zone_inactive_file 
  | Vmstat_nr_zone_unevictable 
  | Vmstat_nr_zone_write_pending 
  | Vmstat_oom_kill 
  | Vmstat_pglazyfree 
  | Vmstat_pglazyfreed 
  | Vmstat_pgrefill 
  | Vmstat_pgscan_direct 
  | Vmstat_pgscan_kswapd 
  | Vmstat_pgskip_dma 
  | Vmstat_pgskip_movable 
  | Vmstat_pgskip_normal 
  | Vmstat_pgsteal_direct 
  | Vmstat_pgsteal_kswapd 
  | Vmstat_swap_ra 
  | Vmstat_swap_ra_hit 
  | Vmstat_workingset_restore 
  | Vmstat_allocstall_device 
  | Vmstat_allocstall_dma32 
  | Vmstat_balloon_deflate 
  | Vmstat_balloon_inflate 
  | Vmstat_balloon_migrate 
  | Vmstat_cma_alloc_fail 
  | Vmstat_cma_alloc_success 
  | Vmstat_nr_file_hugepages 
  | Vmstat_nr_file_pmdmapped 
  | Vmstat_nr_foll_pin_acquired 
  | Vmstat_nr_foll_pin_released 
  | Vmstat_nr_sec_page_table_pages 
  | Vmstat_nr_shadow_call_stack 
  | Vmstat_nr_swapcached 
  | Vmstat_nr_throttled_written 
  | Vmstat_pgalloc_device 
  | Vmstat_pgalloc_dma32 
  | Vmstat_pgdemote_direct 
  | Vmstat_pgdemote_kswapd 
  | Vmstat_pgreuse 
  | Vmstat_pgscan_anon 
  | Vmstat_pgscan_file 
  | Vmstat_pgskip_device 
  | Vmstat_pgskip_dma32 
  | Vmstat_pgsteal_anon 
  | Vmstat_pgsteal_file 
  | Vmstat_thp_collapse_alloc 
  | Vmstat_thp_collapse_alloc_failed 
  | Vmstat_thp_deferred_split_page 
  | Vmstat_thp_fault_alloc 
  | Vmstat_thp_fault_fallback 
  | Vmstat_thp_fault_fallback_charge 
  | Vmstat_thp_file_alloc 
  | Vmstat_thp_file_fallback 
  | Vmstat_thp_file_fallback_charge 
  | Vmstat_thp_file_mapped 
  | Vmstat_thp_migration_fail 
  | Vmstat_thp_migration_split 
  | Vmstat_thp_migration_success 
  | Vmstat_thp_scan_exceed_none_pte 
  | Vmstat_thp_scan_exceed_share_pte 
  | Vmstat_thp_scan_exceed_swap_pte 
  | Vmstat_thp_split_page 
  | Vmstat_thp_split_page_failed 
  | Vmstat_thp_split_pmd 
  | Vmstat_thp_swpout 
  | Vmstat_thp_swpout_fallback 
  | Vmstat_thp_zero_page_alloc 
  | Vmstat_thp_zero_page_alloc_failed 
  | Vmstat_vma_lock_abort 
  | Vmstat_vma_lock_miss 
  | Vmstat_vma_lock_retry 
  | Vmstat_vma_lock_success 
  | Vmstat_workingset_activate_anon 
  | Vmstat_workingset_activate_file 
  | Vmstat_workingset_nodes 
  | Vmstat_workingset_refault_anon 
  | Vmstat_workingset_refault_file 
  | Vmstat_workingset_restore_anon 
  | Vmstat_workingset_restore_file 

type sys_stats_config_stat_counters =
  | Stat_unspecified 
  | Stat_cpu_times 
  | Stat_irq_counts 
  | Stat_softirq_counts 
  | Stat_fork_count 

type sys_stats_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 11 fields *)
  mutable meminfo_period_ms : int32;
  mutable meminfo_counters : meminfo_counters list;
  mutable vmstat_period_ms : int32;
  mutable vmstat_counters : vmstat_counters list;
  mutable stat_period_ms : int32;
  mutable stat_counters : sys_stats_config_stat_counters list;
  mutable devfreq_period_ms : int32;
  mutable cpufreq_period_ms : int32;
  mutable buddyinfo_period_ms : int32;
  mutable diskstat_period_ms : int32;
  mutable psi_period_ms : int32;
  mutable thermal_period_ms : int32;
  mutable cpuidle_period_ms : int32;
  mutable gpufreq_period_ms : int32;
}

type system_info_config = unit

type test_config_dummy_fields = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 14 fields *)
  mutable field_uint32 : int32;
  mutable field_int32 : int32;
  mutable field_uint64 : int64;
  mutable field_int64 : int64;
  mutable field_fixed64 : int64;
  mutable field_sfixed64 : int64;
  mutable field_fixed32 : int32;
  mutable field_sfixed32 : int32;
  mutable field_double : float;
  mutable field_float : float;
  mutable field_sint64 : int64;
  mutable field_sint32 : int32;
  mutable field_string : string;
  mutable field_bytes : bytes;
}

type test_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable message_count : int32;
  mutable max_messages_per_second : int32;
  mutable seed : int32;
  mutable message_size : int32;
  mutable send_batch_on_register : bool;
  mutable dummy_fields : test_config_dummy_fields option;
}

type track_event_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable disabled_categories : string list;
  mutable enabled_categories : string list;
  mutable disabled_tags : string list;
  mutable enabled_tags : string list;
  mutable disable_incremental_timestamps : bool;
  mutable timestamp_unit_multiplier : int64;
  mutable filter_debug_annotations : bool;
  mutable enable_thread_time_sampling : bool;
  mutable thread_time_subsampling_ns : int64;
  mutable filter_dynamic_event_names : bool;
}

type data_source_config_session_initiator =
  | Session_initiator_unspecified 
  | Session_initiator_trusted_system 

type data_source_config_buffer_exhausted_policy =
  | Buffer_exhausted_unspecified 
  | Buffer_exhausted_drop 
  | Buffer_exhausted_stall_then_abort 
  | Buffer_exhausted_stall_then_drop 

type data_source_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 11 fields *)
  mutable name : string;
  mutable target_buffer : int32;
  mutable trace_duration_ms : int32;
  mutable prefer_suspend_clock_for_duration : bool;
  mutable stop_timeout_ms : int32;
  mutable enable_extra_guardrails : bool;
  mutable session_initiator : data_source_config_session_initiator;
  mutable tracing_session_id : int64;
  mutable buffer_exhausted_policy : data_source_config_buffer_exhausted_policy;
  mutable priority_boost : priority_boost_config option;
  mutable inode_file_config : inode_file_config option;
  mutable process_stats_config : process_stats_config option;
  mutable sys_stats_config : sys_stats_config option;
  mutable heapprofd_config : heapprofd_config option;
  mutable android_power_config : android_power_config option;
  mutable android_game_intervention_list_config : android_game_intervention_list_config option;
  mutable track_event_config : track_event_config option;
  mutable system_info_config : unit;
  mutable chrome_config : chrome_config option;
  mutable v8_config : v8_config option;
  mutable interceptor_config : interceptor_config option;
  mutable surfaceflinger_layers_config : surface_flinger_layers_config option;
  mutable surfaceflinger_transactions_config : surface_flinger_transactions_config option;
  mutable etw_config : etw_config option;
  mutable protolog_config : proto_log_config option;
  mutable windowmanager_config : window_manager_config option;
  mutable chromium_system_metrics : chromium_system_metrics_config option;
  mutable chromium_histogram_samples : chromium_histogram_samples_config option;
  mutable legacy_config : string;
  mutable for_testing : test_config option;
}

type trace_config_buffer_config_fill_policy =
  | Unspecified 
  | Ring_buffer 
  | Discard 

type trace_config_buffer_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable size_kb : int32;
  mutable fill_policy : trace_config_buffer_config_fill_policy;
  mutable transfer_on_clone : bool;
  mutable clear_before_clone : bool;
}

type trace_config_data_source = private {
  mutable config : data_source_config option;
  mutable producer_name_filter : string list;
  mutable producer_name_regex_filter : string list;
  mutable machine_name_filter : string list;
}

type trace_config_builtin_data_source = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable disable_clock_snapshotting : bool;
  mutable disable_trace_config : bool;
  mutable disable_system_info : bool;
  mutable disable_service_events : bool;
  mutable primary_trace_clock : builtin_clock;
  mutable snapshot_interval_ms : int32;
  mutable prefer_suspend_clock_for_snapshot : bool;
  mutable disable_chunk_usage_histograms : bool;
}

type trace_config_lockdown_mode_operation =
  | Lockdown_unchanged 
  | Lockdown_clear 
  | Lockdown_set 

type trace_config_producer_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable producer_name : string;
  mutable shm_size_kb : int32;
  mutable page_size_kb : int32;
}

type trace_config_statsd_metadata = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable triggering_alert_id : int64;
  mutable triggering_config_uid : int32;
  mutable triggering_config_id : int64;
  mutable triggering_subscription_id : int64;
}

type trace_config_guardrail_overrides = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable max_upload_per_day_bytes : int64;
  mutable max_tracing_buffer_size_kb : int32;
}

type trace_config_trigger_config_trigger_mode =
  | Unspecified 
  | Start_tracing 
  | Stop_tracing 
  | Clone_snapshot 

type trace_config_trigger_config_trigger = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable name : string;
  mutable producer_name_regex : string;
  mutable stop_delay_ms : int32;
  mutable max_per_24_h : int32;
  mutable skip_probability : float;
}

type trace_config_trigger_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable trigger_mode : trace_config_trigger_config_trigger_mode;
  mutable use_clone_snapshot_if_available : bool;
  mutable triggers : trace_config_trigger_config_trigger list;
  mutable trigger_timeout_ms : int32;
}

type trace_config_incremental_state_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable clear_period_ms : int32;
}

type trace_config_compression_type =
  | Compression_type_unspecified 
  | Compression_type_deflate 

type trace_config_incident_report_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable destination_package : string;
  mutable destination_class : string;
  mutable privacy_level : int32;
  mutable skip_incidentd : bool;
  mutable skip_dropbox : bool;
}

type trace_config_statsd_logging =
  | Statsd_logging_unspecified 
  | Statsd_logging_enabled 
  | Statsd_logging_disabled 

type trace_config_trace_filter_string_filter_policy =
  | Sfp_unspecified 
  | Sfp_match_redact_groups 
  | Sfp_atrace_match_redact_groups 
  | Sfp_match_break 
  | Sfp_atrace_match_break 
  | Sfp_atrace_repeated_search_redact_groups 

type trace_config_trace_filter_string_filter_rule = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable policy : trace_config_trace_filter_string_filter_policy;
  mutable regex_pattern : string;
  mutable atrace_payload_starts_with : string;
}

type trace_config_trace_filter_string_filter_chain = private {
  mutable rules : trace_config_trace_filter_string_filter_rule list;
}

type trace_config_trace_filter = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable bytecode : bytes;
  mutable bytecode_v2 : bytes;
  mutable string_filter_chain : trace_config_trace_filter_string_filter_chain option;
}

type trace_config_android_report_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable reporter_service_package : string;
  mutable reporter_service_class : string;
  mutable skip_report : bool;
  mutable use_pipe_in_framework_for_testing : bool;
}

type trace_config_cmd_trace_start_delay = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable min_delay_ms : int32;
  mutable max_delay_ms : int32;
}

type trace_config_session_semaphore = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable max_other_session_count : int64;
}

type trace_config = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 23 fields *)
  mutable buffers : trace_config_buffer_config list;
  mutable data_sources : trace_config_data_source list;
  mutable builtin_data_sources : trace_config_builtin_data_source option;
  mutable duration_ms : int32;
  mutable prefer_suspend_clock_for_duration : bool;
  mutable enable_extra_guardrails : bool;
  mutable lockdown_mode : trace_config_lockdown_mode_operation;
  mutable producers : trace_config_producer_config list;
  mutable statsd_metadata : trace_config_statsd_metadata option;
  mutable write_into_file : bool;
  mutable output_path : string;
  mutable file_write_period_ms : int32;
  mutable max_file_size_bytes : int64;
  mutable guardrail_overrides : trace_config_guardrail_overrides option;
  mutable deferred_start : bool;
  mutable flush_period_ms : int32;
  mutable flush_timeout_ms : int32;
  mutable data_source_stop_timeout_ms : int32;
  mutable notify_traceur : bool;
  mutable bugreport_score : int32;
  mutable bugreport_filename : string;
  mutable trigger_config : trace_config_trigger_config option;
  mutable activate_triggers : string list;
  mutable incremental_state_config : trace_config_incremental_state_config option;
  mutable allow_user_build_tracing : bool;
  mutable unique_session_name : string;
  mutable compression_type : trace_config_compression_type;
  mutable incident_report_config : trace_config_incident_report_config option;
  mutable statsd_logging : trace_config_statsd_logging;
  mutable trace_uuid_msb : int64;
  mutable trace_uuid_lsb : int64;
  mutable trace_filter : trace_config_trace_filter option;
  mutable android_report_config : trace_config_android_report_config option;
  mutable cmd_trace_start_delay : trace_config_cmd_trace_start_delay option;
  mutable session_semaphores : trace_config_session_semaphore list;
  mutable priority_boost : priority_boost_config option;
  mutable exclusive_prio : int32;
  mutable no_flush_before_write_into_file : bool;
}

type utsname = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable sysname : string;
  mutable version : string;
  mutable release : string;
  mutable machine : string;
}

type system_info = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 14 fields *)
  mutable utsname : utsname option;
  mutable android_build_fingerprint : string;
  mutable android_device_manufacturer : string;
  mutable android_soc_model : string;
  mutable android_guest_soc_model : string;
  mutable android_hardware_revision : string;
  mutable android_storage_model : string;
  mutable android_ram_model : string;
  mutable android_serial_console : string;
  mutable tracing_service_version : string;
  mutable android_sdk_version : int64;
  mutable page_size : int32;
  mutable num_cpus : int32;
  mutable timezone_off_mins : int32;
  mutable hz : int64;
}

type trace_stats_buffer_stats = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 19 fields *)
  mutable buffer_size : int64;
  mutable bytes_written : int64;
  mutable bytes_overwritten : int64;
  mutable bytes_read : int64;
  mutable padding_bytes_written : int64;
  mutable padding_bytes_cleared : int64;
  mutable chunks_written : int64;
  mutable chunks_rewritten : int64;
  mutable chunks_overwritten : int64;
  mutable chunks_discarded : int64;
  mutable chunks_read : int64;
  mutable chunks_committed_out_of_order : int64;
  mutable write_wrap_count : int64;
  mutable patches_succeeded : int64;
  mutable patches_failed : int64;
  mutable readaheads_succeeded : int64;
  mutable readaheads_failed : int64;
  mutable abi_violations : int64;
  mutable trace_writer_packet_loss : int64;
}

type trace_stats_writer_stats = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable sequence_id : int64;
  mutable buffer : int32;
  mutable chunk_payload_histogram_counts : int64 list;
  mutable chunk_payload_histogram_sum : int64 list;
}

type trace_stats_filter_stats = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable input_packets : int64;
  mutable input_bytes : int64;
  mutable output_bytes : int64;
  mutable errors : int64;
  mutable time_taken_ns : int64;
  mutable bytes_discarded_per_buffer : int64 list;
}

type trace_stats_final_flush_outcome =
  | Final_flush_unspecified 
  | Final_flush_succeeded 
  | Final_flush_failed 

type trace_stats = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 13 fields *)
  mutable buffer_stats : trace_stats_buffer_stats list;
  mutable chunk_payload_histogram_def : int64 list;
  mutable writer_stats : trace_stats_writer_stats list;
  mutable producers_connected : int32;
  mutable producers_seen : int64;
  mutable data_sources_registered : int32;
  mutable data_sources_seen : int64;
  mutable tracing_sessions : int32;
  mutable total_buffers : int32;
  mutable chunks_discarded : int64;
  mutable patches_discarded : int64;
  mutable invalid_packets : int64;
  mutable filter_stats : trace_stats_filter_stats option;
  mutable flushes_requested : int64;
  mutable flushes_succeeded : int64;
  mutable flushes_failed : int64;
  mutable final_flush_outcome : trace_stats_final_flush_outcome;
}

type proto_log_message = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable message_id : int64;
  mutable str_param_iids : int32 list;
  mutable sint64_params : int64 list;
  mutable double_params : float list;
  mutable boolean_params : int32 list;
  mutable stacktrace_iid : int32;
}

type proto_log_viewer_config_message_data = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable message_id : int64;
  mutable message : string;
  mutable level : proto_log_level;
  mutable group_id : int32;
  mutable location : string;
}

type proto_log_viewer_config_group = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable id : int32;
  mutable name : string;
  mutable tag : string;
}

type proto_log_viewer_config = private {
  mutable messages : proto_log_viewer_config_message_data list;
  mutable groups : proto_log_viewer_config_group list;
}

type shell_transition_target = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable mode : int32;
  mutable layer_id : int32;
  mutable window_id : int32;
  mutable flags : int32;
}

type shell_transition = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 16 fields *)
  mutable id : int32;
  mutable create_time_ns : int64;
  mutable send_time_ns : int64;
  mutable dispatch_time_ns : int64;
  mutable merge_time_ns : int64;
  mutable merge_request_time_ns : int64;
  mutable shell_abort_time_ns : int64;
  mutable wm_abort_time_ns : int64;
  mutable finish_time_ns : int64;
  mutable start_transaction_id : int64;
  mutable finish_transaction_id : int64;
  mutable handler : int32;
  mutable type_ : int32;
  mutable targets : shell_transition_target list;
  mutable merge_target : int32;
  mutable flags : int32;
  mutable starting_window_remove_time_ns : int64;
}

type shell_handler_mapping = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable id : int32;
  mutable name : string;
}

type shell_handler_mappings = private {
  mutable mapping : shell_handler_mapping list;
}

type rect_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable left : int32;
  mutable top : int32;
  mutable right : int32;
  mutable bottom : int32;
}

type region_proto = private {
  mutable rect : rect_proto list;
}

type size_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable w : int32;
  mutable h : int32;
}

type transform_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable dsdx : float;
  mutable dtdx : float;
  mutable dsdy : float;
  mutable dtdy : float;
  mutable type_ : int32;
}

type color_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable r : float;
  mutable g : float;
  mutable b : float;
  mutable a : float;
}

type input_window_info_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 13 fields *)
  mutable layout_params_flags : int32;
  mutable layout_params_type : int32;
  mutable frame : rect_proto option;
  mutable touchable_region : region_proto option;
  mutable surface_inset : int32;
  mutable visible : bool;
  mutable can_receive_keys : bool;
  mutable focusable : bool;
  mutable has_wallpaper : bool;
  mutable global_scale_factor : float;
  mutable window_x_scale : float;
  mutable window_y_scale : float;
  mutable crop_layer_id : int32;
  mutable replace_touchable_region_with_crop : bool;
  mutable touchable_region_crop : rect_proto option;
  mutable transform : transform_proto option;
  mutable input_config : int32;
}

type blur_region = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 18 fields *)
  mutable blur_radius : int32;
  mutable corner_radius_tl : int32;
  mutable corner_radius_tr : int32;
  mutable corner_radius_bl : int32;
  mutable corner_radius_br : float;
  mutable corner_radius_tlx : float;
  mutable corner_radius_tly : float;
  mutable corner_radius_trx : float;
  mutable corner_radius_try : float;
  mutable corner_radius_blx : float;
  mutable corner_radius_bly : float;
  mutable corner_radius_brx : float;
  mutable corner_radius_bry : float;
  mutable alpha : float;
  mutable left : int32;
  mutable top : int32;
  mutable right : int32;
  mutable bottom : int32;
}

type color_transform_proto = private {
  mutable val_ : float list;
}

type trusted_overlay =
  | Unset 
  | Disabled 
  | Enabled 

type box_shadow_settings_box_shadow_params = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable blur_radius : float;
  mutable spread_radius : float;
  mutable color : int32;
  mutable offset_x : float;
  mutable offset_y : float;
}

type box_shadow_settings = private {
  mutable box_shadows : box_shadow_settings_box_shadow_params list;
}

type border_settings = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable stroke_width : float;
  mutable color : int32;
}

type layers_trace_file_proto_magic_number =
  | Invalid 
  | Magic_number_l 
  | Magic_number_h 

type position_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable x : float;
  mutable y : float;
}

type active_buffer_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable width : int32;
  mutable height : int32;
  mutable stride : int32;
  mutable format : int32;
  mutable usage : int64;
}

type float_rect_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable left : float;
  mutable top : float;
  mutable right : float;
  mutable bottom : float;
}

type hwc_composition_type =
  | Hwc_type_unspecified 
  | Hwc_type_client 
  | Hwc_type_device 
  | Hwc_type_solid_color 
  | Hwc_type_cursor 
  | Hwc_type_sideband 
  | Hwc_type_display_decoration 

type barrier_layer_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable id : int32;
  mutable frame_number : int64;
}

type corner_radii_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable tl : float;
  mutable tr : float;
  mutable bl : float;
  mutable br : float;
}

type layer_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 32 fields *)
  mutable id : int32;
  mutable name : string;
  mutable children : int32 list;
  mutable relatives : int32 list;
  mutable type_ : string;
  mutable transparent_region : region_proto option;
  mutable visible_region : region_proto option;
  mutable damage_region : region_proto option;
  mutable layer_stack : int32;
  mutable z : int32;
  mutable position : position_proto option;
  mutable requested_position : position_proto option;
  mutable size : size_proto option;
  mutable crop : rect_proto option;
  mutable final_crop : rect_proto option;
  mutable is_opaque : bool;
  mutable invalidate : bool;
  mutable dataspace : string;
  mutable pixel_format : string;
  mutable color : color_proto option;
  mutable requested_color : color_proto option;
  mutable flags : int32;
  mutable transform : transform_proto option;
  mutable requested_transform : transform_proto option;
  mutable parent : int32;
  mutable z_order_relative_of : int32;
  mutable active_buffer : active_buffer_proto option;
  mutable queued_frames : int32;
  mutable refresh_pending : bool;
  mutable hwc_frame : rect_proto option;
  mutable hwc_crop : float_rect_proto option;
  mutable hwc_transform : int32;
  mutable window_type : int32;
  mutable app_id : int32;
  mutable hwc_composition_type : hwc_composition_type;
  mutable is_protected : bool;
  mutable curr_frame : int64;
  mutable barrier_layer : barrier_layer_proto list;
  mutable buffer_transform : transform_proto option;
  mutable effective_scaling_mode : int32;
  mutable corner_radius : float;
  mutable metadata : (int32 * string) list;
  mutable effective_transform : transform_proto option;
  mutable source_bounds : float_rect_proto option;
  mutable bounds : float_rect_proto option;
  mutable screen_bounds : float_rect_proto option;
  mutable input_window_info : input_window_info_proto option;
  mutable corner_radius_crop : float_rect_proto option;
  mutable shadow_radius : float;
  mutable color_transform : color_transform_proto option;
  mutable is_relative_of : bool;
  mutable background_blur_radius : int32;
  mutable owner_uid : int32;
  mutable blur_regions : blur_region list;
  mutable is_trusted_overlay : bool;
  mutable requested_corner_radius : float;
  mutable destination_frame : rect_proto option;
  mutable original_id : int32;
  mutable trusted_overlay : trusted_overlay;
  mutable background_blur_scale : float;
  mutable corner_radii : corner_radii_proto option;
  mutable requested_corner_radii : corner_radii_proto option;
  mutable client_drawn_corner_radii : corner_radii_proto option;
  mutable system_content_priority : int32;
  mutable box_shadow_settings : box_shadow_settings option;
  mutable border_settings : border_settings option;
  mutable effective_radii : corner_radii_proto option;
}

type layers_proto = private {
  mutable layers : layer_proto list;
}

type display_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable id : int64;
  mutable name : string;
  mutable layer_stack : int32;
  mutable size : size_proto option;
  mutable layer_stack_space_rect : rect_proto option;
  mutable transform : transform_proto option;
  mutable is_virtual : bool;
  mutable dpi_x : float;
  mutable dpi_y : float;
}

type layers_snapshot_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable elapsed_realtime_nanos : int64;
  mutable where : string;
  mutable layers : layers_proto option;
  mutable hwc_blob : string;
  mutable excludes_composition_state : bool;
  mutable missed_entries : int32;
  mutable displays : display_proto list;
  mutable vsync_id : int64;
}

type layers_trace_file_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable magic_number : int64;
  mutable entry : layers_snapshot_proto list;
  mutable real_to_elapsed_time_offset_nanos : int64;
}

type transaction_trace_file_magic_number =
  | Invalid 
  | Magic_number_l 
  | Magic_number_h 

type layer_state_matrix22 = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable dsdx : float;
  mutable dtdx : float;
  mutable dtdy : float;
  mutable dsdy : float;
}

type layer_state_color3 = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable r : float;
  mutable g : float;
  mutable b : float;
}

type layer_state_buffer_data_pixel_format =
  | Pixel_format_unknown 
  | Pixel_format_custom 
  | Pixel_format_translucent 
  | Pixel_format_transparent 
  | Pixel_format_opaque 
  | Pixel_format_rgba_8888 
  | Pixel_format_rgbx_8888 
  | Pixel_format_rgb_888 
  | Pixel_format_rgb_565 
  | Pixel_format_bgra_8888 
  | Pixel_format_rgba_5551 
  | Pixel_format_rgba_4444 
  | Pixel_format_rgba_fp16 
  | Pixel_format_rgba_1010102 
  | Pixel_format_r_8 

type layer_state_buffer_data = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable buffer_id : int64;
  mutable width : int32;
  mutable height : int32;
  mutable frame_number : int64;
  mutable flags : int32;
  mutable cached_buffer_id : int64;
  mutable pixel_format : layer_state_buffer_data_pixel_format;
  mutable usage : int64;
}

type transform = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable dsdx : float;
  mutable dtdx : float;
  mutable dtdy : float;
  mutable dsdy : float;
  mutable tx : float;
  mutable ty : float;
}

type layer_state_window_info = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 9 fields *)
  mutable layout_params_flags : int32;
  mutable layout_params_type : int32;
  mutable touchable_region : region_proto option;
  mutable surface_inset : int32;
  mutable focusable : bool;
  mutable has_wallpaper : bool;
  mutable global_scale_factor : float;
  mutable crop_layer_id : int32;
  mutable replace_touchable_region_with_crop : bool;
  mutable touchable_region_crop : rect_proto option;
  mutable transform : transform option;
  mutable input_config : int32;
}

type layer_state_drop_input_mode =
  | None 
  | All 
  | Obscured 

type layer_state_corner_radii = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable tl : float;
  mutable tr : float;
  mutable bl : float;
  mutable br : float;
}

type layer_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 35 fields *)
  mutable layer_id : int32;
  mutable what : int64;
  mutable x : float;
  mutable y : float;
  mutable z : int32;
  mutable w : int32;
  mutable h : int32;
  mutable layer_stack : int32;
  mutable flags : int32;
  mutable mask : int32;
  mutable matrix : layer_state_matrix22 option;
  mutable corner_radius : float;
  mutable background_blur_radius : int32;
  mutable parent_id : int32;
  mutable relative_parent_id : int32;
  mutable alpha : float;
  mutable color : layer_state_color3 option;
  mutable transparent_region : region_proto option;
  mutable transform : int32;
  mutable transform_to_display_inverse : bool;
  mutable crop : rect_proto option;
  mutable buffer_data : layer_state_buffer_data option;
  mutable api : int32;
  mutable has_sideband_stream : bool;
  mutable color_transform : color_transform_proto option;
  mutable blur_regions : blur_region list;
  mutable window_info_handle : layer_state_window_info option;
  mutable bg_color_alpha : float;
  mutable bg_color_dataspace : int32;
  mutable color_space_agnostic : bool;
  mutable shadow_radius : float;
  mutable frame_rate_selection_priority : int32;
  mutable frame_rate : float;
  mutable frame_rate_compatibility : int32;
  mutable change_frame_rate_strategy : int32;
  mutable fixed_transform_hint : int32;
  mutable frame_number : int64;
  mutable auto_refresh : bool;
  mutable is_trusted_overlay : bool;
  mutable buffer_crop : rect_proto option;
  mutable destination_frame : rect_proto option;
  mutable drop_input_mode : layer_state_drop_input_mode;
  mutable trusted_overlay : trusted_overlay;
  mutable background_blur_scale : float;
  mutable corner_radii : layer_state_corner_radii option;
  mutable client_drawn_corner_radii : layer_state_corner_radii option;
  mutable system_content_priority : int32;
  mutable box_shadow_settings : box_shadow_settings option;
  mutable border_settings : border_settings option;
}

type display_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable id : int32;
  mutable what : int32;
  mutable flags : int32;
  mutable layer_stack : int32;
  mutable orientation : int32;
  mutable layer_stack_space_rect : rect_proto option;
  mutable oriented_display_space_rect : rect_proto option;
  mutable width : int32;
  mutable height : int32;
}

type transaction_barrier = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable barrier_token : string;
  mutable kind : int32;
}

type transaction_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable pid : int32;
  mutable uid : int32;
  mutable vsync_id : int64;
  mutable input_event_id : int32;
  mutable post_time : int64;
  mutable transaction_id : int64;
  mutable layer_changes : layer_state list;
  mutable display_changes : display_state list;
  mutable merged_transaction_ids : int64 list;
  mutable apply_token : int64;
  mutable transaction_barriers : transaction_barrier list;
}

type layer_creation_args = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable layer_id : int32;
  mutable name : string;
  mutable flags : int32;
  mutable parent_id : int32;
  mutable mirror_from_id : int32;
  mutable add_to_root : bool;
  mutable layer_stack_to_mirror : int32;
}

type display_info = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 10 fields *)
  mutable layer_stack : int32;
  mutable display_id : int32;
  mutable logical_width : int32;
  mutable logical_height : int32;
  mutable transform_inverse : transform option;
  mutable transform : transform option;
  mutable receives_input : bool;
  mutable is_secure : bool;
  mutable is_primary : bool;
  mutable is_virtual : bool;
  mutable rotation_flags : int32;
  mutable transform_hint : int32;
}

type transaction_trace_entry = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable elapsed_realtime_nanos : int64;
  mutable vsync_id : int64;
  mutable transactions : transaction_state list;
  mutable added_layers : layer_creation_args list;
  mutable destroyed_layers : int32 list;
  mutable added_displays : display_state list;
  mutable removed_displays : int32 list;
  mutable destroyed_layer_handles : int32 list;
  mutable displays_changed : bool;
  mutable displays : display_info list;
}

type transaction_trace_file = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable magic_number : int64;
  mutable entry : transaction_trace_entry list;
  mutable real_to_elapsed_time_offset_nanos : int64;
  mutable version : int32;
}

type layer_state_changes_lsb =
  | E_changes_lsb_none 
  | E_position_changed 
  | E_layer_changed 
  | E_alpha_changed 
  | E_matrix_changed 
  | E_transparent_region_changed 
  | E_flags_changed 
  | E_layer_stack_changed 
  | E_release_buffer_listener_changed 
  | E_shadow_radius_changed 
  | E_buffer_crop_changed 
  | E_relative_layer_changed 
  | E_reparent 
  | E_color_changed 
  | E_buffer_transform_changed 
  | E_transform_to_display_inverse_changed 
  | E_crop_changed 
  | E_buffer_changed 
  | E_acquire_fence_changed 
  | E_dataspace_changed 
  | E_hdr_metadata_changed 
  | E_surface_damage_region_changed 
  | E_api_changed 
  | E_sideband_stream_changed 
  | E_color_transform_changed 
  | E_has_listener_callbacks_changed 
  | E_input_info_changed 
  | E_corner_radius_changed 

type layer_state_changes_msb =
  | E_changes_msb_none 
  | E_destination_frame_changed 
  | E_cached_buffer_changed 
  | E_background_color_changed 
  | E_metadata_changed 
  | E_color_space_agnostic_changed 
  | E_frame_rate_selection_priority 
  | E_frame_rate_changed 
  | E_background_blur_radius_changed 
  | E_producer_disconnect 
  | E_fixed_transform_hint_changed 
  | E_frame_number_changed 
  | E_blur_regions_changed 
  | E_auto_refresh_changed 
  | E_stretch_changed 
  | E_trusted_overlay_changed 
  | E_drop_input_mode_changed 
  | E_client_drawn_corner_radius_changed 
  | E_system_content_priority_changed 
  | E_box_shadow_settings_changed 
  | E_border_settings_changed 

type layer_state_flags =
  | E_flags_none 
  | E_layer_hidden 
  | E_layer_opaque 
  | E_layer_skip_screenshot 
  | E_layer_secure 
  | E_enable_backpressure 
  | E_layer_is_display_decoration 

type layer_state_buffer_data_buffer_data_change =
  | Buffer_data_change_none 
  | Fence_changed 
  | Frame_number_changed 
  | Cached_buffer_changed 

type display_state_changes =
  | E_changes_none 
  | E_surface_changed 
  | E_layer_stack_changed 
  | E_display_projection_changed 
  | E_display_size_changed 
  | E_flags_changed 

type winscope_extensions = unit

type chrome_benchmark_metadata = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable benchmark_start_time_us : int64;
  mutable story_run_time_us : int64;
  mutable benchmark_name : string;
  mutable benchmark_description : string;
  mutable label : string;
  mutable story_name : string;
  mutable story_tags : string list;
  mutable story_run_index : int32;
  mutable had_failures : bool;
}

type chrome_metadata_packet_finch_hash = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : int32;
  mutable group : int32;
}

type background_tracing_metadata_trigger_rule_trigger_type =
  | Trigger_unspecified 
  | Monitor_and_dump_when_specific_histogram_and_value 
  | Monitor_and_dump_when_trigger_named 

type background_tracing_metadata_trigger_rule_histogram_rule = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable histogram_name_hash : int64;
  mutable histogram_min_trigger : int64;
  mutable histogram_max_trigger : int64;
}

type background_tracing_metadata_trigger_rule_named_rule_event_type =
  | Unspecified 
  | Session_restore 
  | Navigation 
  | Startup 
  | Reached_code 
  | Content_trigger 
  | Test_rule 

type background_tracing_metadata_trigger_rule_named_rule = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable event_type : background_tracing_metadata_trigger_rule_named_rule_event_type;
  mutable content_trigger_name_hash : int64;
}

type background_tracing_metadata_trigger_rule = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable trigger_type : background_tracing_metadata_trigger_rule_trigger_type;
  mutable histogram_rule : background_tracing_metadata_trigger_rule_histogram_rule option;
  mutable named_rule : background_tracing_metadata_trigger_rule_named_rule option;
  mutable name_hash : int32;
}

type background_tracing_metadata = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable triggered_rule : background_tracing_metadata_trigger_rule option;
  mutable active_rules : background_tracing_metadata_trigger_rule list;
  mutable scenario_name_hash : int32;
}

type chrome_metadata_packet = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable background_tracing_metadata : background_tracing_metadata option;
  mutable chrome_version_code : int32;
  mutable enabled_categories : string;
  mutable field_trial_hashes : chrome_metadata_packet_finch_hash list;
}

type chrome_traced_value_nested_type =
  | Dict 
  | Array 

type chrome_traced_value = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable nested_type : chrome_traced_value_nested_type;
  mutable dict_keys : string list;
  mutable dict_values : chrome_traced_value list;
  mutable array_values : chrome_traced_value list;
  mutable int_value : int32;
  mutable double_value : float;
  mutable bool_value : bool;
  mutable string_value : string;
}

type chrome_string_table_entry = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable value : string;
  mutable index : int32;
}

type chrome_trace_event_arg_value =
  | Bool_value of bool
  | Uint_value of int64
  | Int_value of int64
  | Double_value of float
  | String_value of string
  | Pointer_value of int64
  | Json_value of string
  | Traced_value of chrome_traced_value

and chrome_trace_event_arg = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable value : chrome_trace_event_arg_value option;
  mutable name_index : int32;
}

type chrome_trace_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 15 fields *)
  mutable name : string;
  mutable timestamp : int64;
  mutable phase : int32;
  mutable thread_id : int32;
  mutable duration : int64;
  mutable thread_duration : int64;
  mutable scope : string;
  mutable id : int64;
  mutable flags : int32;
  mutable category_group_name : string;
  mutable process_id : int32;
  mutable thread_timestamp : int64;
  mutable bind_id : int64;
  mutable args : chrome_trace_event_arg list;
  mutable name_index : int32;
  mutable category_group_name_index : int32;
}

type chrome_metadata_value =
  | String_value of string
  | Bool_value of bool
  | Int_value of int64
  | Json_value of string

and chrome_metadata = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable name : string;
  mutable value : chrome_metadata_value option;
}

type chrome_legacy_json_trace_trace_type =
  | User_trace 
  | System_trace 

type chrome_legacy_json_trace = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable type_ : chrome_legacy_json_trace_trace_type;
  mutable data : string;
}

type chrome_event_bundle = private {
  mutable trace_events : chrome_trace_event list;
  mutable metadata : chrome_metadata list;
  mutable legacy_ftrace_output : string list;
  mutable legacy_json_trace : chrome_legacy_json_trace list;
  mutable string_table : chrome_string_table_entry list;
}

type chrome_trigger = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable trigger_name : string;
  mutable trigger_name_hash : int32;
  mutable flow_id : int64;
}

type v8_string =
  | Latin1 of bytes
  | Utf16_le of bytes
  | Utf16_be of bytes

type interned_v8_string_encoded_string =
  | Latin1 of bytes
  | Utf16_le of bytes
  | Utf16_be of bytes

and interned_v8_string = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable iid : int64;
  mutable encoded_string : interned_v8_string_encoded_string option;
}

type interned_v8_js_script_type =
  | Type_unknown 
  | Type_normal 
  | Type_eval 
  | Type_module 
  | Type_native 
  | Type_extension 
  | Type_inspector 

type interned_v8_js_script = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable iid : int64;
  mutable script_id : int32;
  mutable type_ : interned_v8_js_script_type;
  mutable name : v8_string option;
  mutable source : v8_string option;
}

type interned_v8_wasm_script = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable iid : int64;
  mutable script_id : int32;
  mutable url : string;
  mutable wire_bytes : bytes;
}

type interned_v8_js_function_kind =
  | Kind_unknown 
  | Kind_normal_function 
  | Kind_module 
  | Kind_async_module 
  | Kind_base_constructor 
  | Kind_default_base_constructor 
  | Kind_default_derived_constructor 
  | Kind_derived_constructor 
  | Kind_getter_function 
  | Kind_static_getter_function 
  | Kind_setter_function 
  | Kind_static_setter_function 
  | Kind_arrow_function 
  | Kind_async_arrow_function 
  | Kind_async_function 
  | Kind_async_concise_method 
  | Kind_static_async_concise_method 
  | Kind_async_concise_generator_method 
  | Kind_static_async_concise_generator_method 
  | Kind_async_generator_function 
  | Kind_generator_function 
  | Kind_concise_generator_method 
  | Kind_static_concise_generator_method 
  | Kind_concise_method 
  | Kind_static_concise_method 
  | Kind_class_members_initializer_function 
  | Kind_class_static_initializer_function 
  | Kind_invalid 

type interned_v8_js_function = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable iid : int64;
  mutable v8_js_function_name_iid : int64;
  mutable v8_js_script_iid : int64;
  mutable is_toplevel : bool;
  mutable kind : interned_v8_js_function_kind;
  mutable byte_offset : int32;
  mutable line : int32;
  mutable column : int32;
}

type interned_v8_isolate_code_range = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable base_address : int64;
  mutable size : int64;
  mutable embedded_blob_code_copy_start_address : int64;
  mutable is_process_wide : bool;
}

type interned_v8_isolate = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable iid : int64;
  mutable pid : int32;
  mutable isolate_id : int32;
  mutable code_range : interned_v8_isolate_code_range option;
  mutable embedded_blob_code_start_address : int64;
  mutable embedded_blob_code_size : int64;
}

type v8_js_code_tier =
  | Tier_unknown 
  | Tier_ignition 
  | Tier_sparkplug 
  | Tier_maglev 
  | Tier_turboshaft 
  | Tier_turbofan 

type v8_js_code_instructions =
  | Machine_code of bytes
  | Bytecode of bytes

and v8_js_code = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable v8_isolate_iid : int64;
  mutable tid : int32;
  mutable v8_js_function_iid : int64;
  mutable tier : v8_js_code_tier;
  mutable instruction_start : int64;
  mutable instruction_size_bytes : int64;
  mutable instructions : v8_js_code_instructions option;
}

type v8_internal_code_type =
  | Type_unknown 
  | Type_bytecode_handler 
  | Type_for_testing 
  | Type_builtin 
  | Type_wasm_function 
  | Type_wasm_to_capi_function 
  | Type_wasm_to_js_function 
  | Type_js_to_wasm_function 
  | Type_js_to_js_function 
  | Type_c_wasm_entry 

type v8_internal_code = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable v8_isolate_iid : int64;
  mutable tid : int32;
  mutable name : string;
  mutable type_ : v8_internal_code_type;
  mutable builtin_id : int32;
  mutable instruction_start : int64;
  mutable instruction_size_bytes : int64;
  mutable machine_code : bytes;
}

type v8_wasm_code_tier =
  | Tier_unknown 
  | Tier_liftoff 
  | Tier_turbofan 

type v8_wasm_code = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 9 fields *)
  mutable v8_isolate_iid : int64;
  mutable tid : int32;
  mutable v8_wasm_script_iid : int64;
  mutable function_name : string;
  mutable tier : v8_wasm_code_tier;
  mutable code_offset_in_module : int32;
  mutable instruction_start : int64;
  mutable instruction_size_bytes : int64;
  mutable machine_code : bytes;
}

type v8_reg_exp_code = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable v8_isolate_iid : int64;
  mutable tid : int32;
  mutable pattern : v8_string option;
  mutable instruction_start : int64;
  mutable instruction_size_bytes : int64;
  mutable machine_code : bytes;
}

type v8_code_move_to_instructions =
  | To_machine_code of bytes
  | To_bytecode of bytes

and v8_code_move = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable isolate_iid : int64;
  mutable tid : int32;
  mutable from_instruction_start_address : int64;
  mutable to_instruction_start_address : int64;
  mutable instruction_size_bytes : int64;
  mutable to_instructions : v8_code_move_to_instructions option;
}

type v8_code_defaults = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable tid : int32;
}

type clock_snapshot_clock_builtin_clocks =
  | Unknown 
  | Realtime 
  | Realtime_coarse 
  | Monotonic 
  | Monotonic_coarse 
  | Monotonic_raw 
  | Boottime 
  | Builtin_clock_max_id 

type clock_snapshot_clock = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable clock_id : int32;
  mutable timestamp : int64;
  mutable is_incremental : bool;
  mutable unit_multiplier_ns : int64;
}

type clock_snapshot = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable clocks : clock_snapshot_clock list;
  mutable primary_trace_clock : builtin_clock;
}

type cswitch_etw_event_old_thread_wait_reason =
  | Executive 
  | Free_page 
  | Page_in 
  | Pool_allocation 
  | Delay_execution 
  | Suspend 
  | User_request 
  | Wr_executive 
  | Wr_free_page 
  | Wr_page_in 
  | Wr_pool_allocation 
  | Wr_delay_execution 
  | Wr_suspended 
  | Wr_user_request 
  | Wr_event_pair 
  | Wr_queue 
  | Wr_lpc_receiver 
  | Wr_lpc_reply 
  | Wr_virtual_memory 
  | Wr_page_out 
  | Wr_rendez_vous 
  | Wr_keyed_event 
  | Wr_terminated 
  | Wr_process_in_swap 
  | Wr_cpu_rate_control 
  | Wr_callout_stack 
  | Wr_kernel 
  | Wr_resource 
  | Wr_push_lock 
  | Wr_mutex 
  | Wr_quantum_end 
  | Wr_dispatch_int 
  | Wr_preempted 
  | Wr_yield_execution 
  | Wr_fast_mutex 
  | Wr_guard_mutex 
  | Wr_rundown 
  | Maximum_wait_reason 

type cswitch_etw_event_old_thread_wait_mode =
  | Kernel_mode 
  | User_mode 

type cswitch_etw_event_old_thread_state =
  | Initialized 
  | Ready 
  | Running 
  | Standby 
  | Terminated 
  | Waiting 
  | Transition 
  | Deferred_ready 

type cswitch_etw_event_old_thread_wait_reason_enum_or_int =
  | Old_thread_wait_reason of cswitch_etw_event_old_thread_wait_reason
  | Old_thread_wait_reason_int of int32

and cswitch_etw_event_old_thread_wait_mode_enum_or_int =
  | Old_thread_wait_mode of cswitch_etw_event_old_thread_wait_mode
  | Old_thread_wait_mode_int of int32

and cswitch_etw_event_old_thread_state_enum_or_int =
  | Old_thread_state of cswitch_etw_event_old_thread_state
  | Old_thread_state_int of int32

and cswitch_etw_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable new_thread_id : int32;
  mutable old_thread_id : int32;
  mutable new_thread_priority : int32;
  mutable old_thread_priority : int32;
  mutable previous_c_state : int32;
  mutable old_thread_wait_reason_enum_or_int : cswitch_etw_event_old_thread_wait_reason_enum_or_int option;
  mutable old_thread_wait_mode_enum_or_int : cswitch_etw_event_old_thread_wait_mode_enum_or_int option;
  mutable old_thread_state_enum_or_int : cswitch_etw_event_old_thread_state_enum_or_int option;
  mutable old_thread_wait_ideal_processor : int32;
  mutable new_thread_wait_time : int32;
}

type ready_thread_etw_event_adjust_reason =
  | Ignore_the_increment 
  | Apply_increment 
  | Apply_increment_boost 

type ready_thread_etw_event_trace_flag =
  | Trace_flag_unspecified 
  | Thread_readied 
  | Kernel_stack_swapped_out 
  | Process_address_swapped_out 

type ready_thread_etw_event_adjust_reason_enum_or_int =
  | Adjust_reason of ready_thread_etw_event_adjust_reason
  | Adjust_reason_int of int32

and ready_thread_etw_event_flag_enum_or_int =
  | Flag of ready_thread_etw_event_trace_flag
  | Flag_int of int32

and ready_thread_etw_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable t_thread_id : int32;
  mutable adjust_reason_enum_or_int : ready_thread_etw_event_adjust_reason_enum_or_int option;
  mutable adjust_increment : int32;
  mutable flag_enum_or_int : ready_thread_etw_event_flag_enum_or_int option;
}

type mem_info_etw_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 11 fields *)
  mutable priority_levels : int32;
  mutable zero_page_count : int64;
  mutable free_page_count : int64;
  mutable modified_page_count : int64;
  mutable modified_no_write_page_count : int64;
  mutable bad_page_count : int64;
  mutable standby_page_counts : int64 list;
  mutable repurposed_page_counts : int64 list;
  mutable modified_page_count_page_file : int64;
  mutable paged_pool_page_count : int64;
  mutable non_paged_pool_page_count : int64;
  mutable mdl_page_count : int64;
  mutable commit_page_count : int64;
}

type file_io_create_etw_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable irp_ptr : int64;
  mutable file_object : int64;
  mutable ttid : int32;
  mutable create_options : int32;
  mutable file_attributes : int32;
  mutable share_access : int32;
  mutable open_path : string;
}

type file_io_dir_enum_etw_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable irp_ptr : int64;
  mutable file_object : int64;
  mutable file_key : int64;
  mutable ttid : int32;
  mutable length : int32;
  mutable info_class : int32;
  mutable file_index : int32;
  mutable file_name : string;
}

type file_io_info_etw_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable irp_ptr : int64;
  mutable file_object : int64;
  mutable file_key : int64;
  mutable extra_info : int64;
  mutable ttid : int32;
  mutable info_class : int32;
}

type file_io_read_write_etw_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable offset : int64;
  mutable irp_ptr : int64;
  mutable file_object : int64;
  mutable file_key : int64;
  mutable ttid : int32;
  mutable io_size : int32;
  mutable io_flags : int32;
}

type file_io_simple_op_etw_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable irp_ptr : int64;
  mutable file_object : int64;
  mutable file_key : int64;
  mutable ttid : int32;
}

type file_io_op_end_etw_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable irp_ptr : int64;
  mutable extra_info : int64;
  mutable nt_status : int32;
}

type etw_trace_event_event =
  | C_switch of cswitch_etw_event
  | Ready_thread of ready_thread_etw_event
  | Mem_info of mem_info_etw_event
  | File_io_create of file_io_create_etw_event
  | File_io_dir_enum of file_io_dir_enum_etw_event
  | File_io_info of file_io_info_etw_event
  | File_io_read_write of file_io_read_write_etw_event
  | File_io_simple_op of file_io_simple_op_etw_event
  | File_io_op_end of file_io_op_end_etw_event

and etw_trace_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable timestamp : int64;
  mutable cpu : int32;
  mutable thread_id : int32;
  mutable event : etw_trace_event_event option;
}

type etw_trace_event_bundle = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable cpu : int32;
  mutable event : etw_trace_event list;
}

type evdev_event_input_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable kernel_timestamp : int64;
  mutable type_ : int32;
  mutable code : int32;
  mutable value : int32;
}

type evdev_event_event =
  | Input_event of evdev_event_input_event

and evdev_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable device_id : int32;
  mutable event : evdev_event_event option;
}

type field_descriptor_proto_label =
  | Label_optional 
  | Label_required 
  | Label_repeated 

type field_descriptor_proto_type =
  | Type_double 
  | Type_float 
  | Type_int64 
  | Type_uint64 
  | Type_int32 
  | Type_fixed64 
  | Type_fixed32 
  | Type_bool 
  | Type_string 
  | Type_group 
  | Type_message 
  | Type_bytes 
  | Type_uint32 
  | Type_enum 
  | Type_sfixed32 
  | Type_sfixed64 
  | Type_sint32 
  | Type_sint64 

type uninterpreted_option_name_part = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name_part : string;
  mutable is_extension : bool;
}

type uninterpreted_option = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable name : uninterpreted_option_name_part list;
  mutable identifier_value : string;
  mutable positive_int_value : int64;
  mutable negative_int_value : int64;
  mutable double_value : float;
  mutable string_value : bytes;
  mutable aggregate_value : string;
}

type field_options = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable packed : bool;
  mutable uninterpreted_option : uninterpreted_option list;
}

type field_descriptor_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable name : string;
  mutable number : int32;
  mutable label : field_descriptor_proto_label;
  mutable type_ : field_descriptor_proto_type;
  mutable type_name : string;
  mutable extendee : string;
  mutable default_value : string;
  mutable options : field_options option;
  mutable oneof_index : int32;
}

type enum_value_descriptor_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable number : int32;
}

type enum_descriptor_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable name : string;
  mutable value : enum_value_descriptor_proto list;
  mutable reserved_name : string list;
}

type oneof_options = unit

type oneof_descriptor_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable options : unit;
}

type descriptor_proto_reserved_range = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable start : int32;
  mutable end_ : int32;
}

type descriptor_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable name : string;
  mutable field : field_descriptor_proto list;
  mutable extension : field_descriptor_proto list;
  mutable nested_type : descriptor_proto list;
  mutable enum_type : enum_descriptor_proto list;
  mutable oneof_decl : oneof_descriptor_proto list;
  mutable reserved_range : descriptor_proto_reserved_range list;
  mutable reserved_name : string list;
}

type file_descriptor_proto = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable package : string;
  mutable dependency : string list;
  mutable public_dependency : int32 list;
  mutable weak_dependency : int32 list;
  mutable message_type : descriptor_proto list;
  mutable enum_type : enum_descriptor_proto list;
  mutable extension : field_descriptor_proto list;
}

type file_descriptor_set = private {
  mutable file : file_descriptor_proto list;
}

type extension_descriptor = private {
  mutable extension_set : file_descriptor_set option;
}

type inode_file_map_entry_type =
  | Unknown 
  | File 
  | Directory 

type inode_file_map_entry = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable inode_number : int64;
  mutable paths : string list;
  mutable type_ : inode_file_map_entry_type;
}

type inode_file_map = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable block_device_id : int64;
  mutable mount_points : string list;
  mutable entries : inode_file_map_entry list;
}

type generic_kernel_cpu_frequency_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable cpu : int32;
  mutable freq_hz : int64;
}

type generic_kernel_task_state_event_task_state_enum =
  | Task_state_unknown 
  | Task_state_created 
  | Task_state_runnable 
  | Task_state_running 
  | Task_state_interruptible_sleep 
  | Task_state_uninterruptible_sleep 
  | Task_state_stopped 
  | Task_state_dead 
  | Task_state_destroyed 

type generic_kernel_task_state_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable cpu : int32;
  mutable comm : string;
  mutable tid : int64;
  mutable state : generic_kernel_task_state_event_task_state_enum;
  mutable prio : int32;
}

type generic_kernel_task_rename_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable tid : int64;
  mutable comm : string;
}

type generic_kernel_process_tree_thread = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable tid : int64;
  mutable pid : int64;
  mutable comm : string;
  mutable is_main_thread : bool;
}

type generic_kernel_process_tree_process = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable pid : int64;
  mutable ppid : int64;
  mutable cmdline : string;
}

type generic_kernel_process_tree = private {
  mutable processes : generic_kernel_process_tree_process list;
  mutable threads : generic_kernel_process_tree_thread list;
}

type gpu_counter_event_gpu_counter_value =
  | Int_value of int64
  | Double_value of float

and gpu_counter_event_gpu_counter = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable counter_id : int32;
  mutable value : gpu_counter_event_gpu_counter_value option;
}

type gpu_counter_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable counter_descriptor : gpu_counter_descriptor option;
  mutable counters : gpu_counter_event_gpu_counter list;
  mutable gpu_id : int32;
}

type gpu_log_severity =
  | Log_severity_unspecified 
  | Log_severity_verbose 
  | Log_severity_debug 
  | Log_severity_info 
  | Log_severity_warning 
  | Log_severity_error 

type gpu_log = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable severity : gpu_log_severity;
  mutable tag : string;
  mutable log_message : string;
}

type gpu_render_stage_event_extra_data = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable value : string;
}

type gpu_render_stage_event_specifications_context_spec = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable context : int64;
  mutable pid : int32;
}

type gpu_render_stage_event_specifications_description = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable name : string;
  mutable description : string;
}

type gpu_render_stage_event_specifications = private {
  mutable context_spec : gpu_render_stage_event_specifications_context_spec option;
  mutable hw_queue : gpu_render_stage_event_specifications_description list;
  mutable stage : gpu_render_stage_event_specifications_description list;
}

type gpu_render_stage_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 13 fields *)
  mutable event_id : int64;
  mutable duration : int64;
  mutable hw_queue_iid : int64;
  mutable stage_iid : int64;
  mutable gpu_id : int32;
  mutable context : int64;
  mutable render_target_handle : int64;
  mutable submission_id : int32;
  mutable extra_data : gpu_render_stage_event_extra_data list;
  mutable render_pass_handle : int64;
  mutable render_pass_instance_id : int64;
  mutable render_subpass_index_mask : int64 list;
  mutable command_buffer_handle : int64;
  mutable specifications : gpu_render_stage_event_specifications option;
  mutable hw_queue_id : int32;
  mutable stage_id : int32;
}

type interned_graphics_context_api =
  | Undefined 
  | Open_gl 
  | Vulkan 
  | Open_cl 

type interned_graphics_context = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable iid : int64;
  mutable pid : int32;
  mutable api : interned_graphics_context_api;
}

type interned_gpu_render_stage_specification_render_stage_category =
  | Other 
  | Graphics 
  | Compute 

type interned_gpu_render_stage_specification = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable iid : int64;
  mutable name : string;
  mutable description : string;
  mutable category : interned_gpu_render_stage_specification_render_stage_category;
}

type vulkan_api_event_vk_debug_utils_object_name = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable pid : int32;
  mutable vk_device : int64;
  mutable object_type : int32;
  mutable object_ : int64;
  mutable object_name : string;
}

type vulkan_api_event_vk_queue_submit = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable duration_ns : int64;
  mutable pid : int32;
  mutable tid : int32;
  mutable vk_queue : int64;
  mutable vk_command_buffers : int64 list;
  mutable submission_id : int32;
}

type vulkan_api_event =
  | Vk_debug_utils_object_name of vulkan_api_event_vk_debug_utils_object_name
  | Vk_queue_submit of vulkan_api_event_vk_queue_submit

type vulkan_memory_event_annotation_value =
  | Int_value of int64
  | Double_value of float
  | String_iid of int64

and vulkan_memory_event_annotation = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable key_iid : int64;
  mutable value : vulkan_memory_event_annotation_value option;
}

type vulkan_memory_event_source =
  | Source_unspecified 
  | Source_driver 
  | Source_device 
  | Source_device_memory 
  | Source_buffer 
  | Source_image 

type vulkan_memory_event_operation =
  | Op_unspecified 
  | Op_create 
  | Op_destroy 
  | Op_bind 
  | Op_destroy_bound 
  | Op_annotations 

type vulkan_memory_event_allocation_scope =
  | Scope_unspecified 
  | Scope_command 
  | Scope_object 
  | Scope_cache 
  | Scope_device 
  | Scope_instance 

type vulkan_memory_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 13 fields *)
  mutable source : vulkan_memory_event_source;
  mutable operation : vulkan_memory_event_operation;
  mutable timestamp : int64;
  mutable pid : int32;
  mutable memory_address : int64;
  mutable memory_size : int64;
  mutable caller_iid : int64;
  mutable allocation_scope : vulkan_memory_event_allocation_scope;
  mutable annotations : vulkan_memory_event_annotation list;
  mutable device : int64;
  mutable device_memory : int64;
  mutable memory_type : int32;
  mutable heap : int32;
  mutable object_handle : int64;
}

type interned_string = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable iid : int64;
  mutable str : bytes;
}

type line = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable function_name : string;
  mutable source_file_name : string;
  mutable line_number : int32;
}

type address_symbols = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable address : int64;
  mutable lines : line list;
}

type module_symbols = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable path : string;
  mutable build_id : string;
  mutable address_symbols : address_symbols list;
}

type mapping = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable iid : int64;
  mutable build_id : int64;
  mutable exact_offset : int64;
  mutable start_offset : int64;
  mutable start : int64;
  mutable end_ : int64;
  mutable load_bias : int64;
  mutable path_string_ids : int64 list;
}

type frame = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable iid : int64;
  mutable function_name_id : int64;
  mutable mapping_id : int64;
  mutable rel_pc : int64;
  mutable source_path_iid : int64;
  mutable line_number : int32;
}

type callstack = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable iid : int64;
  mutable frame_ids : int64 list;
}

type histogram_name = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable iid : int64;
  mutable name : string;
}

type chrome_histogram_sample = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable name_hash : int64;
  mutable name : string;
  mutable sample : int64;
  mutable name_iid : int64;
}

type debug_annotation_nested_value_nested_type =
  | Unspecified 
  | Dict 
  | Array 

type debug_annotation_nested_value = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable nested_type : debug_annotation_nested_value_nested_type;
  mutable dict_keys : string list;
  mutable dict_values : debug_annotation_nested_value list;
  mutable array_values : debug_annotation_nested_value list;
  mutable int_value : int64;
  mutable double_value : float;
  mutable bool_value : bool;
  mutable string_value : string;
}

type debug_annotation_name_field =
  | Name_iid of int64
  | Name of string

and debug_annotation_value =
  | Bool_value of bool
  | Uint_value of int64
  | Int_value of int64
  | Double_value of float
  | Pointer_value of int64
  | Nested_value of debug_annotation_nested_value
  | Legacy_json_value of string
  | String_value of string
  | String_value_iid of int64

and debug_annotation_proto_type_descriptor =
  | Proto_type_name of string
  | Proto_type_name_iid of int64

and debug_annotation = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable name_field : debug_annotation_name_field option;
  mutable value : debug_annotation_value option;
  mutable proto_type_descriptor : debug_annotation_proto_type_descriptor option;
  mutable proto_value : bytes;
  mutable dict_entries : debug_annotation list;
  mutable array_values : debug_annotation list;
}

type debug_annotation_name = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable iid : int64;
  mutable name : string;
}

type debug_annotation_value_type_name = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable iid : int64;
  mutable name : string;
}

type log_message_priority =
  | Prio_unspecified 
  | Prio_unused 
  | Prio_verbose 
  | Prio_debug 
  | Prio_info 
  | Prio_warn 
  | Prio_error 
  | Prio_fatal 

type log_message = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable source_location_iid : int64;
  mutable body_iid : int64;
  mutable prio : log_message_priority;
}

type log_message_body = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable iid : int64;
  mutable body : string;
}

type unsymbolized_source_location = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable iid : int64;
  mutable mapping_id : int64;
  mutable rel_pc : int64;
}

type source_location = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable iid : int64;
  mutable file_name : string;
  mutable function_name : string;
  mutable line_number : int32;
}

type chrome_active_processes = private {
  mutable pid : int32 list;
}

type chrome_application_state_info_chrome_application_state =
  | Application_state_unknown 
  | Application_state_has_running_activities 
  | Application_state_has_paused_activities 
  | Application_state_has_stopped_activities 
  | Application_state_has_destroyed_activities 

type chrome_application_state_info = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable application_state : chrome_application_state_info_chrome_application_state;
}

type chrome_compositor_scheduler_action =
  | Cc_scheduler_action_unspecified 
  | Cc_scheduler_action_none 
  | Cc_scheduler_action_send_begin_main_frame 
  | Cc_scheduler_action_commit 
  | Cc_scheduler_action_activate_sync_tree 
  | Cc_scheduler_action_draw_if_possible 
  | Cc_scheduler_action_draw_forced 
  | Cc_scheduler_action_draw_abort 
  | Cc_scheduler_action_begin_layer_tree_frame_sink_creation 
  | Cc_scheduler_action_prepare_tiles 
  | Cc_scheduler_action_invalidate_layer_tree_frame_sink 
  | Cc_scheduler_action_perform_impl_side_invalidation 
  | Cc_scheduler_action_notify_begin_main_frame_not_expected_until 
  | Cc_scheduler_action_notify_begin_main_frame_not_expected_soon 

type chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode =
  | Deadline_mode_unspecified 
  | Deadline_mode_none 
  | Deadline_mode_immediate 
  | Deadline_mode_regular 
  | Deadline_mode_late 
  | Deadline_mode_blocked 

type chrome_compositor_state_machine_major_state_begin_impl_frame_state =
  | Begin_impl_frame_unspecified 
  | Begin_impl_frame_idle 
  | Begin_impl_frame_inside_begin_frame 
  | Begin_impl_frame_inside_deadline 

type chrome_compositor_state_machine_major_state_begin_main_frame_state =
  | Begin_main_frame_unspecified 
  | Begin_main_frame_idle 
  | Begin_main_frame_sent 
  | Begin_main_frame_ready_to_commit 

type chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state =
  | Layer_tree_frame_unspecified 
  | Layer_tree_frame_none 
  | Layer_tree_frame_active 
  | Layer_tree_frame_creating 
  | Layer_tree_frame_waiting_for_first_commit 
  | Layer_tree_frame_waiting_for_first_activation 

type chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state =
  | Forced_redraw_unspecified 
  | Forced_redraw_idle 
  | Forced_redraw_waiting_for_commit 
  | Forced_redraw_waiting_for_activation 
  | Forced_redraw_waiting_for_draw 

type chrome_compositor_state_machine_major_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable next_action : chrome_compositor_scheduler_action;
  mutable begin_impl_frame_state : chrome_compositor_state_machine_major_state_begin_impl_frame_state;
  mutable begin_main_frame_state : chrome_compositor_state_machine_major_state_begin_main_frame_state;
  mutable layer_tree_frame_sink_state : chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state;
  mutable forced_redraw_state : chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state;
}

type chrome_compositor_state_machine_minor_state_tree_priority =
  | Tree_priority_unspecified 
  | Tree_priority_same_priority_for_both_trees 
  | Tree_priority_smoothness_takes_priority 
  | Tree_priority_new_content_takes_priority 

type chrome_compositor_state_machine_minor_state_scroll_handler_state =
  | Scroll_handler_unspecified 
  | Scroll_affects_scroll_handler 
  | Scroll_does_not_affect_scroll_handler 

type chrome_compositor_state_machine_minor_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 45 fields *)
  mutable commit_count : int32;
  mutable current_frame_number : int32;
  mutable last_frame_number_submit_performed : int32;
  mutable last_frame_number_draw_performed : int32;
  mutable last_frame_number_begin_main_frame_sent : int32;
  mutable did_draw : bool;
  mutable did_send_begin_main_frame_for_current_frame : bool;
  mutable did_notify_begin_main_frame_not_expected_until : bool;
  mutable did_notify_begin_main_frame_not_expected_soon : bool;
  mutable wants_begin_main_frame_not_expected : bool;
  mutable did_commit_during_frame : bool;
  mutable did_invalidate_layer_tree_frame_sink : bool;
  mutable did_perform_impl_side_invalidaion : bool;
  mutable did_prepare_tiles : bool;
  mutable consecutive_checkerboard_animations : int32;
  mutable pending_submit_frames : int32;
  mutable submit_frames_with_current_layer_tree_frame_sink : int32;
  mutable needs_redraw : bool;
  mutable needs_prepare_tiles : bool;
  mutable needs_begin_main_frame : bool;
  mutable needs_one_begin_impl_frame : bool;
  mutable visible : bool;
  mutable begin_frame_source_paused : bool;
  mutable can_draw : bool;
  mutable resourceless_draw : bool;
  mutable has_pending_tree : bool;
  mutable pending_tree_is_ready_for_activation : bool;
  mutable active_tree_needs_first_draw : bool;
  mutable active_tree_is_ready_to_draw : bool;
  mutable did_create_and_initialize_first_layer_tree_frame_sink : bool;
  mutable tree_priority : chrome_compositor_state_machine_minor_state_tree_priority;
  mutable scroll_handler_state : chrome_compositor_state_machine_minor_state_scroll_handler_state;
  mutable critical_begin_main_frame_to_activate_is_fast : bool;
  mutable main_thread_missed_last_deadline : bool;
  mutable video_needs_begin_frames : bool;
  mutable defer_begin_main_frame : bool;
  mutable last_commit_had_no_updates : bool;
  mutable did_draw_in_last_frame : bool;
  mutable did_submit_in_last_frame : bool;
  mutable needs_impl_side_invalidation : bool;
  mutable current_pending_tree_is_impl_side : bool;
  mutable previous_pending_tree_was_impl_side : bool;
  mutable processing_animation_worklets_for_active_tree : bool;
  mutable processing_animation_worklets_for_pending_tree : bool;
  mutable processing_paint_worklets_for_pending_tree : bool;
}

type chrome_compositor_state_machine = private {
  mutable major_state : chrome_compositor_state_machine_major_state option;
  mutable minor_state : chrome_compositor_state_machine_minor_state option;
}

type begin_impl_frame_args_state =
  | Begin_frame_finished 
  | Begin_frame_using 

type begin_frame_args_begin_frame_args_type =
  | Begin_frame_args_type_unspecified 
  | Begin_frame_args_type_invalid 
  | Begin_frame_args_type_normal 
  | Begin_frame_args_type_missed 

type begin_frame_args_created_from =
  | Source_location_iid of int64
  | Source_location of source_location

and begin_frame_args = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 9 fields *)
  mutable type_ : begin_frame_args_begin_frame_args_type;
  mutable source_id : int64;
  mutable sequence_number : int64;
  mutable frame_time_us : int64;
  mutable deadline_us : int64;
  mutable interval_delta_us : int64;
  mutable on_critical_path : bool;
  mutable animate_only : bool;
  mutable created_from : begin_frame_args_created_from option;
  mutable frames_throttled_since_last : int64;
}

type begin_impl_frame_args_timestamps_in_us = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable interval_delta : int64;
  mutable now_to_deadline_delta : int64;
  mutable frame_time_to_now_delta : int64;
  mutable frame_time_to_deadline_delta : int64;
  mutable now : int64;
  mutable frame_time : int64;
  mutable deadline : int64;
}

type begin_impl_frame_args_args =
  | Current_args of begin_frame_args
  | Last_args of begin_frame_args

and begin_impl_frame_args = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable updated_at_us : int64;
  mutable finished_at_us : int64;
  mutable state : begin_impl_frame_args_state;
  mutable args : begin_impl_frame_args_args option;
  mutable timestamps_in_us : begin_impl_frame_args_timestamps_in_us option;
}

type begin_frame_observer_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable dropped_begin_frame_args : int64;
  mutable last_begin_frame_args : begin_frame_args option;
}

type begin_frame_source_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable source_id : int32;
  mutable paused : bool;
  mutable num_observers : int32;
  mutable last_begin_frame_args : begin_frame_args option;
}

type compositor_timing_history = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable begin_main_frame_queue_critical_estimate_delta_us : int64;
  mutable begin_main_frame_queue_not_critical_estimate_delta_us : int64;
  mutable begin_main_frame_start_to_ready_to_commit_estimate_delta_us : int64;
  mutable commit_to_ready_to_activate_estimate_delta_us : int64;
  mutable prepare_tiles_estimate_delta_us : int64;
  mutable activate_estimate_delta_us : int64;
  mutable draw_estimate_delta_us : int64;
}

type chrome_compositor_scheduler_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 11 fields *)
  mutable state_machine : chrome_compositor_state_machine option;
  mutable observing_begin_frame_source : bool;
  mutable begin_impl_frame_deadline_task : bool;
  mutable pending_begin_frame_task : bool;
  mutable skipped_last_frame_missed_exceeded_deadline : bool;
  mutable inside_action : chrome_compositor_scheduler_action;
  mutable deadline_mode : chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode;
  mutable deadline_us : int64;
  mutable deadline_scheduled_at_us : int64;
  mutable now_us : int64;
  mutable now_to_deadline_delta_us : int64;
  mutable now_to_deadline_scheduled_at_delta_us : int64;
  mutable begin_impl_frame_args : begin_impl_frame_args option;
  mutable begin_frame_observer_state : begin_frame_observer_state option;
  mutable begin_frame_source_state : begin_frame_source_state option;
  mutable compositor_timing_history : compositor_timing_history option;
}

type chrome_content_settings_event_info = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable number_of_exceptions : int32;
}

type chrome_frame_reporter_state =
  | State_no_update_desired 
  | State_presented_all 
  | State_presented_partial 
  | State_dropped 

type chrome_frame_reporter_frame_drop_reason =
  | Reason_unspecified 
  | Reason_display_compositor 
  | Reason_main_thread 
  | Reason_client_compositor 

type chrome_frame_reporter_scroll_state =
  | Scroll_none 
  | Scroll_main_thread 
  | Scroll_compositor_thread 
  | Scroll_raster 
  | Scroll_unknown 

type chrome_frame_reporter_frame_type =
  | Forked 
  | Backfill 

type chrome_frame_reporter = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 17 fields *)
  mutable state : chrome_frame_reporter_state;
  mutable reason : chrome_frame_reporter_frame_drop_reason;
  mutable frame_source : int64;
  mutable frame_sequence : int64;
  mutable affects_smoothness : bool;
  mutable scroll_state : chrome_frame_reporter_scroll_state;
  mutable has_main_animation : bool;
  mutable has_compositor_animation : bool;
  mutable has_smooth_input_main : bool;
  mutable has_missing_content : bool;
  mutable layer_tree_host_id : int64;
  mutable has_high_latency : bool;
  mutable frame_type : chrome_frame_reporter_frame_type;
  mutable high_latency_contribution_stage : string list;
  mutable checkerboarded_needs_raster : bool;
  mutable checkerboarded_needs_record : bool;
  mutable surface_frame_trace_id : int64;
  mutable display_trace_id : int64;
}

type chrome_keyed_service = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable name : string;
}

type chrome_latency_info_step =
  | Step_unspecified 
  | Step_send_input_event_ui 
  | Step_handle_input_event_impl 
  | Step_did_handle_input_and_overscroll 
  | Step_handle_input_event_main 
  | Step_main_thread_scroll_update 
  | Step_handle_input_event_main_commit 
  | Step_handled_input_event_main_or_impl 
  | Step_handled_input_event_impl 
  | Step_swap_buffers 
  | Step_draw_and_swap 
  | Step_finished_swap_buffers 

type chrome_latency_info_latency_component_type =
  | Component_unspecified 
  | Component_input_event_latency_begin_rwh 
  | Component_input_event_latency_scroll_update_original 
  | Component_input_event_latency_first_scroll_update_original 
  | Component_input_event_latency_original 
  | Component_input_event_latency_ui 
  | Component_input_event_latency_renderer_main 
  | Component_input_event_latency_rendering_scheduled_main 
  | Component_input_event_latency_rendering_scheduled_impl 
  | Component_input_event_latency_scroll_update_last_event 
  | Component_input_event_latency_ack_rwh 
  | Component_input_event_latency_renderer_swap 
  | Component_display_compositor_received_frame 
  | Component_input_event_gpu_swap_buffer 
  | Component_input_event_latency_frame_swap 

type chrome_latency_info_component_info = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable component_type : chrome_latency_info_latency_component_type;
  mutable time_us : int64;
}

type chrome_latency_info_input_type =
  | Unspecified_or_other 
  | Touch_moved 
  | Gesture_scroll_begin 
  | Gesture_scroll_update 
  | Gesture_scroll_end 
  | Gesture_tap 
  | Gesture_tap_cancel 

type chrome_latency_info = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable trace_id : int64;
  mutable step : chrome_latency_info_step;
  mutable frame_tree_node_id : int32;
  mutable component_info : chrome_latency_info_component_info list;
  mutable is_coalesced : bool;
  mutable gesture_scroll_id : int64;
  mutable touch_id : int64;
  mutable input_type : chrome_latency_info_input_type;
}

type chrome_legacy_ipc_message_class =
  | Class_unspecified 
  | Class_automation 
  | Class_frame 
  | Class_page 
  | Class_view 
  | Class_widget 
  | Class_input 
  | Class_test 
  | Class_worker 
  | Class_nacl 
  | Class_gpu_channel 
  | Class_media 
  | Class_ppapi 
  | Class_chrome 
  | Class_drag 
  | Class_print 
  | Class_extension 
  | Class_text_input_client 
  | Class_blink_test 
  | Class_accessibility 
  | Class_prerender 
  | Class_chromoting 
  | Class_browser_plugin 
  | Class_android_web_view 
  | Class_nacl_host 
  | Class_encrypted_media 
  | Class_cast 
  | Class_gin_java_bridge 
  | Class_chrome_utility_printing 
  | Class_ozone_gpu 
  | Class_web_test 
  | Class_network_hints 
  | Class_extensions_guest_view 
  | Class_guest_view 
  | Class_media_player_delegate 
  | Class_extension_worker 
  | Class_subresource_filter 
  | Class_unfreezable_frame 

type chrome_legacy_ipc = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable message_class : chrome_legacy_ipc_message_class;
  mutable message_line : int32;
}

type chrome_message_pump = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable sent_messages_in_queue : bool;
  mutable io_handler_location_iid : int64;
}

type chrome_mojo_event_info = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable watcher_notify_interface_tag : string;
  mutable ipc_hash : int32;
  mutable mojo_interface_tag : string;
  mutable mojo_interface_method_iid : int64;
  mutable is_reply : bool;
  mutable payload_size : int64;
  mutable data_num_bytes : int64;
}

type chrome_railmode =
  | Rail_mode_none 
  | Rail_mode_response 
  | Rail_mode_animation 
  | Rail_mode_idle 
  | Rail_mode_load 

type chrome_renderer_scheduler_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable rail_mode : chrome_railmode;
  mutable is_backgrounded : bool;
  mutable is_hidden : bool;
}

type chrome_user_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable action : string;
  mutable action_hash : int64;
}

type chrome_window_handle_event_info = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable dpi : int32;
  mutable message_id : int32;
  mutable hwnd_ptr : int64;
}

type screenshot = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable jpg_image : bytes;
}

type task_execution = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable posted_from_iid : int64;
}

type track_event_type =
  | Type_unspecified 
  | Type_slice_begin 
  | Type_slice_end 
  | Type_instant 
  | Type_counter 

type track_event_callstack_frame = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable function_name : string;
  mutable source_file : string;
  mutable line_number : int32;
}

type track_event_callstack = private {
  mutable frames : track_event_callstack_frame list;
}

type track_event_legacy_event_flow_direction =
  | Flow_unspecified 
  | Flow_in 
  | Flow_out 
  | Flow_inout 

type track_event_legacy_event_instant_event_scope =
  | Scope_unspecified 
  | Scope_global 
  | Scope_process 
  | Scope_thread 

type track_event_legacy_event_id =
  | Unscoped_id of int64
  | Local_id of int64
  | Global_id of int64

and track_event_legacy_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 13 fields *)
  mutable name_iid : int64;
  mutable phase : int32;
  mutable duration_us : int64;
  mutable thread_duration_us : int64;
  mutable thread_instruction_delta : int64;
  mutable id : track_event_legacy_event_id option;
  mutable id_scope : string;
  mutable use_async_tts : bool;
  mutable bind_id : int64;
  mutable bind_to_enclosing : bool;
  mutable flow_direction : track_event_legacy_event_flow_direction;
  mutable instant_event_scope : track_event_legacy_event_instant_event_scope;
  mutable pid_override : int32;
  mutable tid_override : int32;
}

type track_event_name_field =
  | Name_iid of int64
  | Name of string

and track_event_counter_value_field =
  | Counter_value of int64
  | Double_counter_value of float

and track_event_correlation_id_field =
  | Correlation_id of int64
  | Correlation_id_str of string
  | Correlation_id_str_iid of int64

and track_event_callstack_field =
  | Callstack of track_event_callstack
  | Callstack_iid of int64

and track_event_source_location_field =
  | Source_location of source_location
  | Source_location_iid of int64

and track_event_timestamp =
  | Timestamp_delta_us of int64
  | Timestamp_absolute_us of int64

and track_event_thread_time =
  | Thread_time_delta_us of int64
  | Thread_time_absolute_us of int64

and track_event_thread_instruction_count =
  | Thread_instruction_count_delta of int64
  | Thread_instruction_count_absolute of int64

and track_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable category_iids : int64 list;
  mutable categories : string list;
  mutable name_field : track_event_name_field option;
  mutable type_ : track_event_type;
  mutable track_uuid : int64;
  mutable counter_value_field : track_event_counter_value_field option;
  mutable extra_counter_track_uuids : int64 list;
  mutable extra_counter_values : int64 list;
  mutable extra_double_counter_track_uuids : int64 list;
  mutable extra_double_counter_values : float list;
  mutable flow_ids_old : int64 list;
  mutable flow_ids : int64 list;
  mutable terminating_flow_ids_old : int64 list;
  mutable terminating_flow_ids : int64 list;
  mutable correlation_id_field : track_event_correlation_id_field option;
  mutable callstack_field : track_event_callstack_field option;
  mutable debug_annotations : debug_annotation list;
  mutable task_execution : task_execution option;
  mutable log_message : log_message option;
  mutable cc_scheduler_state : chrome_compositor_scheduler_state option;
  mutable chrome_user_event : chrome_user_event option;
  mutable chrome_keyed_service : chrome_keyed_service option;
  mutable chrome_legacy_ipc : chrome_legacy_ipc option;
  mutable chrome_histogram_sample : chrome_histogram_sample option;
  mutable chrome_latency_info : chrome_latency_info option;
  mutable chrome_frame_reporter : chrome_frame_reporter option;
  mutable chrome_application_state_info : chrome_application_state_info option;
  mutable chrome_renderer_scheduler_state : chrome_renderer_scheduler_state option;
  mutable chrome_window_handle_event_info : chrome_window_handle_event_info option;
  mutable chrome_content_settings_event_info : chrome_content_settings_event_info option;
  mutable chrome_active_processes : chrome_active_processes option;
  mutable screenshot : screenshot option;
  mutable source_location_field : track_event_source_location_field option;
  mutable chrome_message_pump : chrome_message_pump option;
  mutable chrome_mojo_event_info : chrome_mojo_event_info option;
  mutable timestamp : track_event_timestamp option;
  mutable thread_time : track_event_thread_time option;
  mutable thread_instruction_count : track_event_thread_instruction_count option;
  mutable legacy_event : track_event_legacy_event option;
}

type track_event_defaults = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable track_uuid : int64;
  mutable extra_counter_track_uuids : int64 list;
  mutable extra_double_counter_track_uuids : int64 list;
}

type event_category = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable iid : int64;
  mutable name : string;
}

type event_name = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable iid : int64;
  mutable name : string;
}

type interned_data = private {
  mutable event_categories : event_category list;
  mutable event_names : event_name list;
  mutable debug_annotation_names : debug_annotation_name list;
  mutable debug_annotation_value_type_names : debug_annotation_value_type_name list;
  mutable source_locations : source_location list;
  mutable unsymbolized_source_locations : unsymbolized_source_location list;
  mutable log_message_body : log_message_body list;
  mutable histogram_names : histogram_name list;
  mutable build_ids : interned_string list;
  mutable mapping_paths : interned_string list;
  mutable source_paths : interned_string list;
  mutable function_names : interned_string list;
  mutable mappings : mapping list;
  mutable frames : frame list;
  mutable callstacks : callstack list;
  mutable vulkan_memory_keys : interned_string list;
  mutable graphics_contexts : interned_graphics_context list;
  mutable gpu_specifications : interned_gpu_render_stage_specification list;
  mutable kernel_symbols : interned_string list;
  mutable debug_annotation_string_values : interned_string list;
  mutable v8_js_function_name : interned_v8_string list;
  mutable v8_js_function : interned_v8_js_function list;
  mutable v8_js_script : interned_v8_js_script list;
  mutable v8_wasm_script : interned_v8_wasm_script list;
  mutable v8_isolate : interned_v8_isolate list;
  mutable protolog_string_args : interned_string list;
  mutable protolog_stacktrace : interned_string list;
  mutable viewcapture_package_name : interned_string list;
  mutable viewcapture_window_name : interned_string list;
  mutable viewcapture_view_id : interned_string list;
  mutable viewcapture_class_name : interned_string list;
  mutable correlation_id_str : interned_string list;
}

type memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units =
  | Unspecified 
  | Bytes 
  | Count 

type memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable name : string;
  mutable units : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units;
  mutable value_uint64 : int64;
  mutable value_string : string;
}

type memory_tracker_snapshot_process_snapshot_memory_node = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable id : int64;
  mutable absolute_name : string;
  mutable weak : bool;
  mutable size_bytes : int64;
  mutable entries : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry list;
}

type memory_tracker_snapshot_process_snapshot_memory_edge = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable source_id : int64;
  mutable target_id : int64;
  mutable importance : int32;
  mutable overridable : bool;
}

type memory_tracker_snapshot_process_snapshot = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable pid : int32;
  mutable allocator_dumps : memory_tracker_snapshot_process_snapshot_memory_node list;
  mutable memory_edges : memory_tracker_snapshot_process_snapshot_memory_edge list;
}

type memory_tracker_snapshot_level_of_detail =
  | Detail_full 
  | Detail_light 
  | Detail_background 

type memory_tracker_snapshot = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable global_dump_id : int64;
  mutable level_of_detail : memory_tracker_snapshot_level_of_detail;
  mutable process_memory_dumps : memory_tracker_snapshot_process_snapshot list;
}

type perfetto_metatrace_arg_key_or_interned_key =
  | Key of string
  | Key_iid of int64

and perfetto_metatrace_arg_value_or_interned_value =
  | Value of string
  | Value_iid of int64

and perfetto_metatrace_arg = private {
  mutable key_or_interned_key : perfetto_metatrace_arg_key_or_interned_key option;
  mutable value_or_interned_value : perfetto_metatrace_arg_value_or_interned_value option;
}

type perfetto_metatrace_interned_string = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable iid : int64;
  mutable value : string;
}

type perfetto_metatrace_record_type =
  | Event_id of int32
  | Counter_id of int32
  | Event_name of string
  | Event_name_iid of int64
  | Counter_name of string

and perfetto_metatrace = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable record_type : perfetto_metatrace_record_type option;
  mutable event_duration_ns : int64;
  mutable counter_value : int32;
  mutable thread_id : int32;
  mutable has_overruns : bool;
  mutable args : perfetto_metatrace_arg list;
  mutable interned_strings : perfetto_metatrace_interned_string list;
}

type tracing_service_event_data_sources_data_source = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable producer_name : string;
  mutable data_source_name : string;
}

type tracing_service_event_data_sources = private {
  mutable data_source : tracing_service_event_data_sources_data_source list;
}

type tracing_service_event =
  | Tracing_started of bool
  | All_data_sources_started of bool
  | Flush_started of bool
  | All_data_sources_flushed of bool
  | Read_tracing_buffers_completed of bool
  | Tracing_disabled of bool
  | Seized_for_bugreport of bool
  | Slow_starting_data_sources of tracing_service_event_data_sources
  | Last_flush_slow_data_sources of tracing_service_event_data_sources
  | Clone_started of bool
  | Buffer_cloned of int32

type android_energy_consumer = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable energy_consumer_id : int32;
  mutable ordinal : int32;
  mutable type_ : string;
  mutable name : string;
}

type android_energy_consumer_descriptor = private {
  mutable energy_consumers : android_energy_consumer list;
}

type android_energy_estimation_breakdown_energy_uid_breakdown = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable uid : int32;
  mutable energy_uws : int64;
}

type android_energy_estimation_breakdown = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable energy_consumer_descriptor : android_energy_consumer_descriptor option;
  mutable energy_consumer_id : int32;
  mutable energy_uws : int64;
  mutable per_uid_breakdown : android_energy_estimation_breakdown_energy_uid_breakdown list;
}

type entity_state_residency_power_entity_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable entity_index : int32;
  mutable state_index : int32;
  mutable entity_name : string;
  mutable state_name : string;
}

type entity_state_residency_state_residency = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable entity_index : int32;
  mutable state_index : int32;
  mutable total_time_in_state_ms : int64;
  mutable total_state_entry_count : int64;
  mutable last_entry_timestamp_ms : int64;
}

type entity_state_residency = private {
  mutable power_entity_state : entity_state_residency_power_entity_state list;
  mutable residency : entity_state_residency_state_residency list;
}

type battery_counters = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable charge_counter_uah : int64;
  mutable capacity_percent : float;
  mutable current_ua : int64;
  mutable current_avg_ua : int64;
  mutable name : string;
  mutable energy_counter_uwh : int64;
  mutable voltage_uv : int64;
}

type power_rails_rail_descriptor = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable index : int32;
  mutable rail_name : string;
  mutable subsys_name : string;
  mutable sampling_rate : int32;
}

type power_rails_energy_data = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable index : int32;
  mutable timestamp_ms : int64;
  mutable energy : int64;
}

type power_rails = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable rail_descriptor : power_rails_rail_descriptor list;
  mutable energy_data : power_rails_energy_data list;
  mutable session_uuid : int64;
}

type obfuscated_member = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable obfuscated_name : string;
  mutable deobfuscated_name : string;
}

type obfuscated_class = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable obfuscated_name : string;
  mutable deobfuscated_name : string;
  mutable obfuscated_members : obfuscated_member list;
  mutable obfuscated_methods : obfuscated_member list;
}

type deobfuscation_mapping = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable package_name : string;
  mutable version_code : int64;
  mutable obfuscated_classes : obfuscated_class list;
}

type heap_graph_root_type =
  | Root_unknown 
  | Root_jni_global 
  | Root_jni_local 
  | Root_java_frame 
  | Root_native_stack 
  | Root_sticky_class 
  | Root_thread_block 
  | Root_monitor_used 
  | Root_thread_object 
  | Root_interned_string 
  | Root_finalizing 
  | Root_debugger 
  | Root_reference_cleanup 
  | Root_vm_internal 
  | Root_jni_monitor 

type heap_graph_root = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable object_ids : int64 list;
  mutable root_type : heap_graph_root_type;
}

type heap_graph_type_kind =
  | Kind_unknown 
  | Kind_normal 
  | Kind_noreferences 
  | Kind_string 
  | Kind_array 
  | Kind_class 
  | Kind_classloader 
  | Kind_dexcache 
  | Kind_soft_reference 
  | Kind_weak_reference 
  | Kind_finalizer_reference 
  | Kind_phantom_reference 

type heap_graph_type = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable id : int64;
  mutable location_id : int64;
  mutable class_name : string;
  mutable object_size : int64;
  mutable superclass_id : int64;
  mutable reference_field_id : int64 list;
  mutable kind : heap_graph_type_kind;
  mutable classloader_id : int64;
}

type heap_graph_object_heap_type =
  | Heap_type_unknown 
  | Heap_type_app 
  | Heap_type_zygote 
  | Heap_type_boot_image 

type heap_graph_object_identifier =
  | Id of int64
  | Id_delta of int64

and heap_graph_object = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable identifier : heap_graph_object_identifier option;
  mutable type_id : int64;
  mutable self_size : int64;
  mutable reference_field_id_base : int64;
  mutable reference_field_id : int64 list;
  mutable reference_object_id : int64 list;
  mutable native_allocation_registry_size_field : int64;
  mutable heap_type_delta : heap_graph_object_heap_type;
  mutable runtime_internal_object_id : int64 list;
}

type heap_graph = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable pid : int32;
  mutable objects : heap_graph_object list;
  mutable roots : heap_graph_root list;
  mutable types : heap_graph_type list;
  mutable field_names : interned_string list;
  mutable location_names : interned_string list;
  mutable continued : bool;
  mutable index : int64;
}

type profile_packet_heap_sample = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable callstack_id : int64;
  mutable self_allocated : int64;
  mutable self_freed : int64;
  mutable self_max : int64;
  mutable self_max_count : int64;
  mutable timestamp : int64;
  mutable alloc_count : int64;
  mutable free_count : int64;
}

type profile_packet_histogram_bucket = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable upper_limit : int64;
  mutable max_bucket : bool;
  mutable count : int64;
}

type profile_packet_histogram = private {
  mutable buckets : profile_packet_histogram_bucket list;
}

type profile_packet_process_stats = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable unwinding_errors : int64;
  mutable heap_samples : int64;
  mutable map_reparses : int64;
  mutable unwinding_time_us : profile_packet_histogram option;
  mutable total_unwinding_time_us : int64;
  mutable client_spinlock_blocked_us : int64;
}

type profile_packet_process_heap_samples_client_error =
  | Client_error_none 
  | Client_error_hit_timeout 
  | Client_error_invalid_stack_bounds 

type profile_packet_process_heap_samples = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 12 fields *)
  mutable pid : int64;
  mutable from_startup : bool;
  mutable rejected_concurrent : bool;
  mutable disconnected : bool;
  mutable buffer_overran : bool;
  mutable client_error : profile_packet_process_heap_samples_client_error;
  mutable buffer_corrupted : bool;
  mutable hit_guardrail : bool;
  mutable heap_name : string;
  mutable sampling_interval_bytes : int64;
  mutable orig_sampling_interval_bytes : int64;
  mutable timestamp : int64;
  mutable stats : profile_packet_process_stats option;
  mutable samples : profile_packet_heap_sample list;
}

type profile_packet = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable strings : interned_string list;
  mutable mappings : mapping list;
  mutable frames : frame list;
  mutable callstacks : callstack list;
  mutable process_dumps : profile_packet_process_heap_samples list;
  mutable continued : bool;
  mutable index : int64;
}

type streaming_allocation = private {
  mutable address : int64 list;
  mutable size : int64 list;
  mutable sample_size : int64 list;
  mutable clock_monotonic_coarse_timestamp : int64 list;
  mutable heap_id : int32 list;
  mutable sequence_number : int64 list;
}

type streaming_free = private {
  mutable address : int64 list;
  mutable heap_id : int32 list;
  mutable sequence_number : int64 list;
}

type streaming_profile_packet = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable callstack_iid : int64 list;
  mutable timestamp_delta_us : int64 list;
  mutable process_priority : int32;
}

type profiling_cpu_mode =
  | Mode_unknown 
  | Mode_kernel 
  | Mode_user 
  | Mode_hypervisor 
  | Mode_guest_kernel 
  | Mode_guest_user 

type profiling_stack_unwind_error =
  | Unwind_error_unknown 
  | Unwind_error_none 
  | Unwind_error_memory_invalid 
  | Unwind_error_unwind_info 
  | Unwind_error_unsupported 
  | Unwind_error_invalid_map 
  | Unwind_error_max_frames_exceeded 
  | Unwind_error_repeated_frame 
  | Unwind_error_invalid_elf 
  | Unwind_error_system_call 
  | Unwind_error_thread_timeout 
  | Unwind_error_thread_does_not_exist 
  | Unwind_error_bad_arch 
  | Unwind_error_maps_parse 
  | Unwind_error_invalid_parameter 
  | Unwind_error_ptrace_call 

type profiling = unit

type perf_sample_sample_skip_reason =
  | Profiler_skip_unknown 
  | Profiler_skip_read_stage 
  | Profiler_skip_unwind_stage 
  | Profiler_skip_unwind_enqueue 
  | Profiler_skip_not_in_scope 

type perf_sample_producer_event_data_source_stop_reason =
  | Profiler_stop_unknown 
  | Profiler_stop_guardrail 

type perf_sample_producer_event =
  | Source_stop_reason of perf_sample_producer_event_data_source_stop_reason

type perf_sample_optional_unwind_error =
  | Unwind_error of profiling_stack_unwind_error

and perf_sample_optional_sample_skipped_reason =
  | Sample_skipped_reason of perf_sample_sample_skip_reason

and perf_sample = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable cpu : int32;
  mutable pid : int32;
  mutable tid : int32;
  mutable cpu_mode : profiling_cpu_mode;
  mutable timebase_count : int64;
  mutable follower_counts : int64 list;
  mutable callstack_iid : int64;
  mutable optional_unwind_error : perf_sample_optional_unwind_error option;
  mutable kernel_records_lost : int64;
  mutable optional_sample_skipped_reason : perf_sample_optional_sample_skipped_reason option;
  mutable producer_event : perf_sample_producer_event option;
}

type smaps_entry = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 15 fields *)
  mutable path : string;
  mutable size_kb : int64;
  mutable private_dirty_kb : int64;
  mutable swap_kb : int64;
  mutable file_name : string;
  mutable start_address : int64;
  mutable module_timestamp : int64;
  mutable module_debugid : string;
  mutable module_debug_path : string;
  mutable protection_flags : int32;
  mutable private_clean_resident_kb : int64;
  mutable shared_dirty_resident_kb : int64;
  mutable shared_clean_resident_kb : int64;
  mutable locked_kb : int64;
  mutable proportional_resident_kb : int64;
}

type smaps_packet = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable pid : int32;
  mutable entries : smaps_entry list;
}

type process_stats_thread = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable tid : int32;
}

type process_stats_fdinfo = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable fd : int64;
  mutable path : string;
}

type process_stats_process = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 22 fields *)
  mutable pid : int32;
  mutable threads : process_stats_thread list;
  mutable vm_size_kb : int64;
  mutable vm_rss_kb : int64;
  mutable rss_anon_kb : int64;
  mutable rss_file_kb : int64;
  mutable rss_shmem_kb : int64;
  mutable vm_swap_kb : int64;
  mutable vm_locked_kb : int64;
  mutable vm_hwm_kb : int64;
  mutable oom_score_adj : int64;
  mutable is_peak_rss_resettable : bool;
  mutable chrome_private_footprint_kb : int32;
  mutable chrome_peak_resident_set_kb : int32;
  mutable fds : process_stats_fdinfo list;
  mutable smr_rss_kb : int64;
  mutable smr_pss_kb : int64;
  mutable smr_pss_anon_kb : int64;
  mutable smr_pss_file_kb : int64;
  mutable smr_pss_shmem_kb : int64;
  mutable smr_swap_pss_kb : int64;
  mutable runtime_user_mode : int64;
  mutable runtime_kernel_mode : int64;
  mutable dmabuf_rss_kb : int64;
}

type process_stats = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable processes : process_stats_process list;
  mutable collection_end_timestamp : int64;
}

type process_tree_thread = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable tid : int32;
  mutable tgid : int32;
  mutable name : string;
  mutable nstid : int32 list;
}

type process_tree_process = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable pid : int32;
  mutable ppid : int32;
  mutable cmdline : string list;
  mutable cmdline_is_comm : bool;
  mutable uid : int32;
  mutable nspid : int32 list;
  mutable process_start_from_boot : int64;
  mutable is_kthread : bool;
}

type process_tree = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable processes : process_tree_process list;
  mutable threads : process_tree_thread list;
  mutable collection_end_timestamp : int64;
}

type remote_clock_sync_synced_clocks = private {
  mutable client_clocks : clock_snapshot option;
  mutable host_clocks : clock_snapshot option;
}

type remote_clock_sync = private {
  mutable synced_clocks : remote_clock_sync_synced_clocks list;
}

type atom = unit

type statsd_atom = private {
  mutable atom : unit list;
  mutable timestamp_nanos : int64 list;
}

type sys_stats_meminfo_value = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable key : meminfo_counters;
  mutable value : int64;
}

type sys_stats_vmstat_value = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable key : vmstat_counters;
  mutable value : int64;
}

type sys_stats_cpu_times = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 9 fields *)
  mutable cpu_id : int32;
  mutable user_ns : int64;
  mutable user_nice_ns : int64;
  mutable system_mode_ns : int64;
  mutable idle_ns : int64;
  mutable io_wait_ns : int64;
  mutable irq_ns : int64;
  mutable softirq_ns : int64;
  mutable steal_ns : int64;
}

type sys_stats_interrupt_count = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable irq : int32;
  mutable count : int64;
}

type sys_stats_devfreq_value = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable key : string;
  mutable value : int64;
}

type sys_stats_buddy_info = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable node : string;
  mutable zone : string;
  mutable order_pages : int32 list;
}

type sys_stats_disk_stat = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 9 fields *)
  mutable device_name : string;
  mutable read_sectors : int64;
  mutable read_time_ms : int64;
  mutable write_sectors : int64;
  mutable write_time_ms : int64;
  mutable discard_sectors : int64;
  mutable discard_time_ms : int64;
  mutable flush_count : int64;
  mutable flush_time_ms : int64;
}

type sys_stats_psi_sample_psi_resource =
  | Psi_resource_unspecified 
  | Psi_resource_cpu_some 
  | Psi_resource_cpu_full 
  | Psi_resource_io_some 
  | Psi_resource_io_full 
  | Psi_resource_memory_some 
  | Psi_resource_memory_full 

type sys_stats_psi_sample = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable resource : sys_stats_psi_sample_psi_resource;
  mutable total_ns : int64;
}

type sys_stats_thermal_zone = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable name : string;
  mutable temp : int64;
  mutable type_ : string;
}

type sys_stats_cpu_idle_state_entry = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable state : string;
  mutable duration_us : int64;
}

type sys_stats_cpu_idle_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable cpu_id : int32;
  mutable cpuidle_state_entry : sys_stats_cpu_idle_state_entry list;
}

type sys_stats = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable meminfo : sys_stats_meminfo_value list;
  mutable vmstat : sys_stats_vmstat_value list;
  mutable cpu_stat : sys_stats_cpu_times list;
  mutable num_forks : int64;
  mutable num_irq_total : int64;
  mutable num_irq : sys_stats_interrupt_count list;
  mutable num_softirq_total : int64;
  mutable num_softirq : sys_stats_interrupt_count list;
  mutable collection_end_timestamp : int64;
  mutable devfreq : sys_stats_devfreq_value list;
  mutable cpufreq_khz : int32 list;
  mutable buddy_info : sys_stats_buddy_info list;
  mutable disk_stat : sys_stats_disk_stat list;
  mutable psi : sys_stats_psi_sample list;
  mutable thermal_zone : sys_stats_thermal_zone list;
  mutable cpuidle_state : sys_stats_cpu_idle_state list;
  mutable gpufreq_mhz : int64 list;
}

type cpu_info_arm_cpu_identifier = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable implementer : int32;
  mutable architecture : int32;
  mutable variant : int32;
  mutable part : int32;
  mutable revision : int32;
}

type cpu_info_cpu_identifier =
  | Arm_identifier of cpu_info_arm_cpu_identifier

and cpu_info_cpu = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable processor : string;
  mutable frequencies : int32 list;
  mutable capacity : int32;
  mutable identifier : cpu_info_cpu_identifier option;
  mutable features : int64;
}

type cpu_info = private {
  mutable cpus : cpu_info_cpu list;
}

type test_event_test_payload = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable str : string list;
  mutable nested : test_event_test_payload list;
  mutable single_string : string;
  mutable single_int : int32;
  mutable repeated_ints : int32 list;
  mutable remaining_nesting_depth : int32;
  mutable debug_annotations : debug_annotation list;
}

type test_event = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable str : string;
  mutable seq_value : int32;
  mutable counter : int64;
  mutable is_last : bool;
  mutable payload : test_event_test_payload option;
}

type trace_packet_defaults = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable timestamp_clock_id : int32;
  mutable track_event_defaults : track_event_defaults option;
  mutable v8_code_defaults : v8_code_defaults option;
}

type trace_uuid = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable msb : int64;
  mutable lsb : int64;
}

type process_descriptor_chrome_process_type =
  | Process_unspecified 
  | Process_browser 
  | Process_renderer 
  | Process_utility 
  | Process_zygote 
  | Process_sandbox_helper 
  | Process_gpu 
  | Process_ppapi_plugin 
  | Process_ppapi_broker 

type process_descriptor = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable pid : int32;
  mutable cmdline : string list;
  mutable process_name : string;
  mutable process_priority : int32;
  mutable start_timestamp_ns : int64;
  mutable chrome_process_type : process_descriptor_chrome_process_type;
  mutable legacy_sort_index : int32;
  mutable process_labels : string list;
}

type track_event_range_of_interest = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 1 fields *)
  mutable start_us : int64;
}

type thread_descriptor_chrome_thread_type =
  | Chrome_thread_unspecified 
  | Chrome_thread_main 
  | Chrome_thread_io 
  | Chrome_thread_pool_bg_worker 
  | Chrome_thread_pool_fg_worker 
  | Chrome_thread_pool_fb_blocking 
  | Chrome_thread_pool_bg_blocking 
  | Chrome_thread_pool_service 
  | Chrome_thread_compositor 
  | Chrome_thread_viz_compositor 
  | Chrome_thread_compositor_worker 
  | Chrome_thread_service_worker 
  | Chrome_thread_memory_infra 
  | Chrome_thread_sampling_profiler 

type thread_descriptor = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable pid : int32;
  mutable tid : int32;
  mutable thread_name : string;
  mutable chrome_thread_type : thread_descriptor_chrome_thread_type;
  mutable reference_timestamp_us : int64;
  mutable reference_thread_time_us : int64;
  mutable reference_thread_instruction_count : int64;
  mutable legacy_sort_index : int32;
}

type chrome_process_descriptor = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 5 fields *)
  mutable process_type : int32;
  mutable process_priority : int32;
  mutable legacy_sort_index : int32;
  mutable host_app_package_name : string;
  mutable crash_trace_id : int64;
}

type chrome_thread_descriptor = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 3 fields *)
  mutable thread_type : int32;
  mutable legacy_sort_index : int32;
  mutable is_sandboxed_tid : bool;
}

type counter_descriptor_builtin_counter_type =
  | Counter_unspecified 
  | Counter_thread_time_ns 
  | Counter_thread_instruction_count 

type counter_descriptor_unit =
  | Unit_unspecified 
  | Unit_time_ns 
  | Unit_count 
  | Unit_size_bytes 

type counter_descriptor = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 6 fields *)
  mutable type_ : counter_descriptor_builtin_counter_type;
  mutable categories : string list;
  mutable unit_ : counter_descriptor_unit;
  mutable unit_name : string;
  mutable unit_multiplier : int64;
  mutable is_incremental : bool;
  mutable y_axis_share_key : string;
}

type track_descriptor_child_tracks_ordering =
  | Unknown 
  | Lexicographic 
  | Chronological 
  | Explicit 

type track_descriptor_sibling_merge_behavior =
  | Sibling_merge_behavior_unspecified 
  | Sibling_merge_behavior_by_track_name 
  | Sibling_merge_behavior_none 
  | Sibling_merge_behavior_by_sibling_merge_key 

type track_descriptor_static_or_dynamic_name =
  | Name of string
  | Static_name of string
  | Atrace_name of string

and track_descriptor_sibling_merge_key_field =
  | Sibling_merge_key of string
  | Sibling_merge_key_int of int64

and track_descriptor = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 7 fields *)
  mutable uuid : int64;
  mutable parent_uuid : int64;
  mutable static_or_dynamic_name : track_descriptor_static_or_dynamic_name option;
  mutable description : string;
  mutable process : process_descriptor option;
  mutable chrome_process : chrome_process_descriptor option;
  mutable thread : thread_descriptor option;
  mutable chrome_thread : chrome_thread_descriptor option;
  mutable counter : counter_descriptor option;
  mutable disallow_merging_with_system_tracks : bool;
  mutable child_ordering : track_descriptor_child_tracks_ordering;
  mutable sibling_order_rank : int32;
  mutable sibling_merge_behavior : track_descriptor_sibling_merge_behavior;
  mutable sibling_merge_key_field : track_descriptor_sibling_merge_key_field option;
}

type chrome_historgram_translation_table = private {
  mutable hash_to_name : (int64 * string) list;
}

type chrome_user_event_translation_table = private {
  mutable action_hash_to_name : (int64 * string) list;
}

type chrome_performance_mark_translation_table = private {
  mutable site_hash_to_name : (int32 * string) list;
  mutable mark_hash_to_name : (int32 * string) list;
}

type slice_name_translation_table = private {
  mutable raw_to_deobfuscated_name : (string * string) list;
}

type process_track_name_translation_table = private {
  mutable raw_to_deobfuscated_name : (string * string) list;
}

type chrome_study_translation_table = private {
  mutable hash_to_name : (int64 * string) list;
}

type translation_table =
  | Chrome_histogram of chrome_historgram_translation_table
  | Chrome_user_event of chrome_user_event_translation_table
  | Chrome_performance_mark of chrome_performance_mark_translation_table
  | Slice_name of slice_name_translation_table
  | Process_track_name of process_track_name_translation_table
  | Chrome_study of chrome_study_translation_table

type trigger = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 4 fields *)
  mutable trigger_name : string;
  mutable producer_name : string;
  mutable trusted_producer_uid : int32;
  mutable stop_delay_ms : int64;
}

type ui_state_highlight_process =
  | Pid of int32
  | Cmdline of string

type ui_state = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 2 fields *)
  mutable timeline_start_ts : int64;
  mutable timeline_end_ts : int64;
  mutable highlight_process : ui_state_highlight_process option;
}

type trace_packet_sequence_flags =
  | Seq_unspecified 
  | Seq_incremental_state_cleared 
  | Seq_needs_incremental_state 

type trace_packet_data =
  | Process_tree of process_tree
  | Process_stats of process_stats
  | Inode_file_map of inode_file_map
  | Chrome_events of chrome_event_bundle
  | Clock_snapshot of clock_snapshot
  | Sys_stats of sys_stats
  | Track_event of track_event
  | Trace_uuid of trace_uuid
  | Trace_config of trace_config
  | Trace_stats of trace_stats
  | Profile_packet of profile_packet
  | Streaming_allocation of streaming_allocation
  | Streaming_free of streaming_free
  | Battery of battery_counters
  | Power_rails of power_rails
  | System_info of system_info
  | Trigger of trigger
  | Chrome_trigger of chrome_trigger
  | Chrome_benchmark_metadata of chrome_benchmark_metadata
  | Perfetto_metatrace of perfetto_metatrace
  | Chrome_metadata of chrome_metadata_packet
  | Gpu_counter_event of gpu_counter_event
  | Gpu_render_stage_event of gpu_render_stage_event
  | Streaming_profile_packet of streaming_profile_packet
  | Heap_graph of heap_graph
  | Vulkan_memory_event of vulkan_memory_event
  | Gpu_log of gpu_log
  | Vulkan_api_event of vulkan_api_event
  | Perf_sample of perf_sample
  | Cpu_info of cpu_info
  | Smaps_packet of smaps_packet
  | Service_event of tracing_service_event
  | Memory_tracker_snapshot of memory_tracker_snapshot
  | Android_energy_estimation_breakdown of android_energy_estimation_breakdown
  | Ui_state of ui_state
  | Translation_table of translation_table
  | Statsd_atom of statsd_atom
  | Entity_state_residency of entity_state_residency
  | Module_symbols of module_symbols
  | Deobfuscation_mapping of deobfuscation_mapping
  | Track_descriptor of track_descriptor
  | Process_descriptor of process_descriptor
  | Thread_descriptor of thread_descriptor
  | Synchronization_marker of bytes
  | Compressed_packets of bytes
  | Extension_descriptor of extension_descriptor
  | Track_event_range_of_interest of track_event_range_of_interest
  | Surfaceflinger_layers_snapshot of layers_snapshot_proto
  | Surfaceflinger_transactions of transaction_trace_entry
  | Shell_transition of shell_transition
  | Shell_handler_mappings of shell_handler_mappings
  | Protolog_message of proto_log_message
  | Protolog_viewer_config of proto_log_viewer_config
  | Winscope_extensions
  | Etw_events of etw_trace_event_bundle
  | V8_js_code of v8_js_code
  | V8_internal_code of v8_internal_code
  | V8_wasm_code of v8_wasm_code
  | V8_reg_exp_code of v8_reg_exp_code
  | V8_code_move of v8_code_move
  | Remote_clock_sync of remote_clock_sync
  | Clone_snapshot_trigger of trigger
  | Generic_kernel_task_state_event of generic_kernel_task_state_event
  | Generic_kernel_cpu_freq_event of generic_kernel_cpu_frequency_event
  | Generic_kernel_task_rename_event of generic_kernel_task_rename_event
  | Generic_kernel_process_tree of generic_kernel_process_tree
  | Evdev_event of evdev_event
  | For_testing of test_event

and trace_packet_optional_trusted_uid =
  | Trusted_uid of int32

and trace_packet_optional_trusted_packet_sequence_id =
  | Trusted_packet_sequence_id of int32

and trace_packet = private {
  mutable _presence: Pbrt.Bitfield.t; (** presence for 8 fields *)
  mutable timestamp : int64;
  mutable timestamp_clock_id : int32;
  mutable data : trace_packet_data option;
  mutable optional_trusted_uid : trace_packet_optional_trusted_uid option;
  mutable optional_trusted_packet_sequence_id : trace_packet_optional_trusted_packet_sequence_id option;
  mutable trusted_pid : int32;
  mutable interned_data : interned_data option;
  mutable sequence_flags : int32;
  mutable incremental_state_cleared : bool;
  mutable trace_packet_defaults : trace_packet_defaults option;
  mutable previous_packet_dropped : bool;
  mutable first_packet_on_sequence : bool;
  mutable machine_id : int32;
}

type trace = private {
  mutable packet : trace_packet list;
}


(** {2 Basic values} *)

val default_ftrace_descriptor_atrace_category : unit -> ftrace_descriptor_atrace_category 
(** [default_ftrace_descriptor_atrace_category ()] is a new empty value for type [ftrace_descriptor_atrace_category] *)

val default_ftrace_descriptor : unit -> ftrace_descriptor 
(** [default_ftrace_descriptor ()] is a new empty value for type [ftrace_descriptor] *)

val default_gpu_counter_descriptor_gpu_counter_group : unit -> gpu_counter_descriptor_gpu_counter_group
(** [default_gpu_counter_descriptor_gpu_counter_group ()] is a new empty value for type [gpu_counter_descriptor_gpu_counter_group] *)

val default_gpu_counter_descriptor_measure_unit : unit -> gpu_counter_descriptor_measure_unit
(** [default_gpu_counter_descriptor_measure_unit ()] is a new empty value for type [gpu_counter_descriptor_measure_unit] *)

val default_gpu_counter_descriptor_gpu_counter_spec_peak_value : unit -> gpu_counter_descriptor_gpu_counter_spec_peak_value
(** [default_gpu_counter_descriptor_gpu_counter_spec_peak_value ()] is a new empty value for type [gpu_counter_descriptor_gpu_counter_spec_peak_value] *)

val default_gpu_counter_descriptor_gpu_counter_spec : unit -> gpu_counter_descriptor_gpu_counter_spec 
(** [default_gpu_counter_descriptor_gpu_counter_spec ()] is a new empty value for type [gpu_counter_descriptor_gpu_counter_spec] *)

val default_gpu_counter_descriptor_gpu_counter_block : unit -> gpu_counter_descriptor_gpu_counter_block 
(** [default_gpu_counter_descriptor_gpu_counter_block ()] is a new empty value for type [gpu_counter_descriptor_gpu_counter_block] *)

val default_gpu_counter_descriptor : unit -> gpu_counter_descriptor 
(** [default_gpu_counter_descriptor ()] is a new empty value for type [gpu_counter_descriptor] *)

val default_track_event_category : unit -> track_event_category 
(** [default_track_event_category ()] is a new empty value for type [track_event_category] *)

val default_track_event_descriptor : unit -> track_event_descriptor 
(** [default_track_event_descriptor ()] is a new empty value for type [track_event_descriptor] *)

val default_data_source_descriptor : unit -> data_source_descriptor 
(** [default_data_source_descriptor ()] is a new empty value for type [data_source_descriptor] *)

val default_tracing_service_state_producer : unit -> tracing_service_state_producer 
(** [default_tracing_service_state_producer ()] is a new empty value for type [tracing_service_state_producer] *)

val default_tracing_service_state_data_source : unit -> tracing_service_state_data_source 
(** [default_tracing_service_state_data_source ()] is a new empty value for type [tracing_service_state_data_source] *)

val default_tracing_service_state_tracing_session : unit -> tracing_service_state_tracing_session 
(** [default_tracing_service_state_tracing_session ()] is a new empty value for type [tracing_service_state_tracing_session] *)

val default_tracing_service_state : unit -> tracing_service_state 
(** [default_tracing_service_state ()] is a new empty value for type [tracing_service_state] *)

val default_builtin_clock : unit -> builtin_clock
(** [default_builtin_clock ()] is a new empty value for type [builtin_clock] *)

val default_android_game_intervention_list_config : unit -> android_game_intervention_list_config 
(** [default_android_game_intervention_list_config ()] is a new empty value for type [android_game_intervention_list_config] *)

val default_proto_log_level : unit -> proto_log_level
(** [default_proto_log_level ()] is a new empty value for type [proto_log_level] *)

val default_proto_log_config_tracing_mode : unit -> proto_log_config_tracing_mode
(** [default_proto_log_config_tracing_mode ()] is a new empty value for type [proto_log_config_tracing_mode] *)

val default_proto_log_group : unit -> proto_log_group 
(** [default_proto_log_group ()] is a new empty value for type [proto_log_group] *)

val default_proto_log_config : unit -> proto_log_config 
(** [default_proto_log_config ()] is a new empty value for type [proto_log_config] *)

val default_surface_flinger_layers_config_mode : unit -> surface_flinger_layers_config_mode
(** [default_surface_flinger_layers_config_mode ()] is a new empty value for type [surface_flinger_layers_config_mode] *)

val default_surface_flinger_layers_config_trace_flag : unit -> surface_flinger_layers_config_trace_flag
(** [default_surface_flinger_layers_config_trace_flag ()] is a new empty value for type [surface_flinger_layers_config_trace_flag] *)

val default_surface_flinger_layers_config : unit -> surface_flinger_layers_config 
(** [default_surface_flinger_layers_config ()] is a new empty value for type [surface_flinger_layers_config] *)

val default_surface_flinger_transactions_config_mode : unit -> surface_flinger_transactions_config_mode
(** [default_surface_flinger_transactions_config_mode ()] is a new empty value for type [surface_flinger_transactions_config_mode] *)

val default_surface_flinger_transactions_config : unit -> surface_flinger_transactions_config 
(** [default_surface_flinger_transactions_config ()] is a new empty value for type [surface_flinger_transactions_config] *)

val default_window_manager_config_log_frequency : unit -> window_manager_config_log_frequency
(** [default_window_manager_config_log_frequency ()] is a new empty value for type [window_manager_config_log_frequency] *)

val default_window_manager_config_log_level : unit -> window_manager_config_log_level
(** [default_window_manager_config_log_level ()] is a new empty value for type [window_manager_config_log_level] *)

val default_window_manager_config : unit -> window_manager_config 
(** [default_window_manager_config ()] is a new empty value for type [window_manager_config] *)

val default_chrome_config_client_priority : unit -> chrome_config_client_priority
(** [default_chrome_config_client_priority ()] is a new empty value for type [chrome_config_client_priority] *)

val default_chrome_config : unit -> chrome_config 
(** [default_chrome_config ()] is a new empty value for type [chrome_config] *)

val default_chromium_histogram_samples_config_histogram_sample : unit -> chromium_histogram_samples_config_histogram_sample 
(** [default_chromium_histogram_samples_config_histogram_sample ()] is a new empty value for type [chromium_histogram_samples_config_histogram_sample] *)

val default_chromium_histogram_samples_config : unit -> chromium_histogram_samples_config 
(** [default_chromium_histogram_samples_config ()] is a new empty value for type [chromium_histogram_samples_config] *)

val default_chromium_system_metrics_config : unit -> chromium_system_metrics_config 
(** [default_chromium_system_metrics_config ()] is a new empty value for type [chromium_system_metrics_config] *)

val default_v8_config : unit -> v8_config 
(** [default_v8_config ()] is a new empty value for type [v8_config] *)

val default_etw_config_kernel_flag : unit -> etw_config_kernel_flag
(** [default_etw_config_kernel_flag ()] is a new empty value for type [etw_config_kernel_flag] *)

val default_etw_config : unit -> etw_config 
(** [default_etw_config ()] is a new empty value for type [etw_config] *)

val default_frozen_ftrace_config : unit -> frozen_ftrace_config 
(** [default_frozen_ftrace_config ()] is a new empty value for type [frozen_ftrace_config] *)

val default_inode_file_config_mount_point_mapping_entry : unit -> inode_file_config_mount_point_mapping_entry 
(** [default_inode_file_config_mount_point_mapping_entry ()] is a new empty value for type [inode_file_config_mount_point_mapping_entry] *)

val default_inode_file_config : unit -> inode_file_config 
(** [default_inode_file_config ()] is a new empty value for type [inode_file_config] *)

val default_console_config_output : unit -> console_config_output
(** [default_console_config_output ()] is a new empty value for type [console_config_output] *)

val default_console_config : unit -> console_config 
(** [default_console_config ()] is a new empty value for type [console_config] *)

val default_interceptor_config : unit -> interceptor_config 
(** [default_interceptor_config ()] is a new empty value for type [interceptor_config] *)

val default_android_power_config_battery_counters : unit -> android_power_config_battery_counters
(** [default_android_power_config_battery_counters ()] is a new empty value for type [android_power_config_battery_counters] *)

val default_android_power_config : unit -> android_power_config 
(** [default_android_power_config ()] is a new empty value for type [android_power_config] *)

val default_priority_boost_config_boost_policy : unit -> priority_boost_config_boost_policy
(** [default_priority_boost_config_boost_policy ()] is a new empty value for type [priority_boost_config_boost_policy] *)

val default_priority_boost_config : unit -> priority_boost_config 
(** [default_priority_boost_config ()] is a new empty value for type [priority_boost_config] *)

val default_process_stats_config_quirks : unit -> process_stats_config_quirks
(** [default_process_stats_config_quirks ()] is a new empty value for type [process_stats_config_quirks] *)

val default_process_stats_config : unit -> process_stats_config 
(** [default_process_stats_config ()] is a new empty value for type [process_stats_config] *)

val default_heapprofd_config_continuous_dump_config : unit -> heapprofd_config_continuous_dump_config 
(** [default_heapprofd_config_continuous_dump_config ()] is a new empty value for type [heapprofd_config_continuous_dump_config] *)

val default_heapprofd_config : unit -> heapprofd_config 
(** [default_heapprofd_config ()] is a new empty value for type [heapprofd_config] *)

val default_meminfo_counters : unit -> meminfo_counters
(** [default_meminfo_counters ()] is a new empty value for type [meminfo_counters] *)

val default_vmstat_counters : unit -> vmstat_counters
(** [default_vmstat_counters ()] is a new empty value for type [vmstat_counters] *)

val default_sys_stats_config_stat_counters : unit -> sys_stats_config_stat_counters
(** [default_sys_stats_config_stat_counters ()] is a new empty value for type [sys_stats_config_stat_counters] *)

val default_sys_stats_config : unit -> sys_stats_config 
(** [default_sys_stats_config ()] is a new empty value for type [sys_stats_config] *)

val default_system_info_config : unit
(** [default_system_info_config] is the default value for type [system_info_config] *)

val default_test_config_dummy_fields : unit -> test_config_dummy_fields 
(** [default_test_config_dummy_fields ()] is a new empty value for type [test_config_dummy_fields] *)

val default_test_config : unit -> test_config 
(** [default_test_config ()] is a new empty value for type [test_config] *)

val default_track_event_config : unit -> track_event_config 
(** [default_track_event_config ()] is a new empty value for type [track_event_config] *)

val default_data_source_config_session_initiator : unit -> data_source_config_session_initiator
(** [default_data_source_config_session_initiator ()] is a new empty value for type [data_source_config_session_initiator] *)

val default_data_source_config_buffer_exhausted_policy : unit -> data_source_config_buffer_exhausted_policy
(** [default_data_source_config_buffer_exhausted_policy ()] is a new empty value for type [data_source_config_buffer_exhausted_policy] *)

val default_data_source_config : unit -> data_source_config 
(** [default_data_source_config ()] is a new empty value for type [data_source_config] *)

val default_trace_config_buffer_config_fill_policy : unit -> trace_config_buffer_config_fill_policy
(** [default_trace_config_buffer_config_fill_policy ()] is a new empty value for type [trace_config_buffer_config_fill_policy] *)

val default_trace_config_buffer_config : unit -> trace_config_buffer_config 
(** [default_trace_config_buffer_config ()] is a new empty value for type [trace_config_buffer_config] *)

val default_trace_config_data_source : unit -> trace_config_data_source 
(** [default_trace_config_data_source ()] is a new empty value for type [trace_config_data_source] *)

val default_trace_config_builtin_data_source : unit -> trace_config_builtin_data_source 
(** [default_trace_config_builtin_data_source ()] is a new empty value for type [trace_config_builtin_data_source] *)

val default_trace_config_lockdown_mode_operation : unit -> trace_config_lockdown_mode_operation
(** [default_trace_config_lockdown_mode_operation ()] is a new empty value for type [trace_config_lockdown_mode_operation] *)

val default_trace_config_producer_config : unit -> trace_config_producer_config 
(** [default_trace_config_producer_config ()] is a new empty value for type [trace_config_producer_config] *)

val default_trace_config_statsd_metadata : unit -> trace_config_statsd_metadata 
(** [default_trace_config_statsd_metadata ()] is a new empty value for type [trace_config_statsd_metadata] *)

val default_trace_config_guardrail_overrides : unit -> trace_config_guardrail_overrides 
(** [default_trace_config_guardrail_overrides ()] is a new empty value for type [trace_config_guardrail_overrides] *)

val default_trace_config_trigger_config_trigger_mode : unit -> trace_config_trigger_config_trigger_mode
(** [default_trace_config_trigger_config_trigger_mode ()] is a new empty value for type [trace_config_trigger_config_trigger_mode] *)

val default_trace_config_trigger_config_trigger : unit -> trace_config_trigger_config_trigger 
(** [default_trace_config_trigger_config_trigger ()] is a new empty value for type [trace_config_trigger_config_trigger] *)

val default_trace_config_trigger_config : unit -> trace_config_trigger_config 
(** [default_trace_config_trigger_config ()] is a new empty value for type [trace_config_trigger_config] *)

val default_trace_config_incremental_state_config : unit -> trace_config_incremental_state_config 
(** [default_trace_config_incremental_state_config ()] is a new empty value for type [trace_config_incremental_state_config] *)

val default_trace_config_compression_type : unit -> trace_config_compression_type
(** [default_trace_config_compression_type ()] is a new empty value for type [trace_config_compression_type] *)

val default_trace_config_incident_report_config : unit -> trace_config_incident_report_config 
(** [default_trace_config_incident_report_config ()] is a new empty value for type [trace_config_incident_report_config] *)

val default_trace_config_statsd_logging : unit -> trace_config_statsd_logging
(** [default_trace_config_statsd_logging ()] is a new empty value for type [trace_config_statsd_logging] *)

val default_trace_config_trace_filter_string_filter_policy : unit -> trace_config_trace_filter_string_filter_policy
(** [default_trace_config_trace_filter_string_filter_policy ()] is a new empty value for type [trace_config_trace_filter_string_filter_policy] *)

val default_trace_config_trace_filter_string_filter_rule : unit -> trace_config_trace_filter_string_filter_rule 
(** [default_trace_config_trace_filter_string_filter_rule ()] is a new empty value for type [trace_config_trace_filter_string_filter_rule] *)

val default_trace_config_trace_filter_string_filter_chain : unit -> trace_config_trace_filter_string_filter_chain 
(** [default_trace_config_trace_filter_string_filter_chain ()] is a new empty value for type [trace_config_trace_filter_string_filter_chain] *)

val default_trace_config_trace_filter : unit -> trace_config_trace_filter 
(** [default_trace_config_trace_filter ()] is a new empty value for type [trace_config_trace_filter] *)

val default_trace_config_android_report_config : unit -> trace_config_android_report_config 
(** [default_trace_config_android_report_config ()] is a new empty value for type [trace_config_android_report_config] *)

val default_trace_config_cmd_trace_start_delay : unit -> trace_config_cmd_trace_start_delay 
(** [default_trace_config_cmd_trace_start_delay ()] is a new empty value for type [trace_config_cmd_trace_start_delay] *)

val default_trace_config_session_semaphore : unit -> trace_config_session_semaphore 
(** [default_trace_config_session_semaphore ()] is a new empty value for type [trace_config_session_semaphore] *)

val default_trace_config : unit -> trace_config 
(** [default_trace_config ()] is a new empty value for type [trace_config] *)

val default_utsname : unit -> utsname 
(** [default_utsname ()] is a new empty value for type [utsname] *)

val default_system_info : unit -> system_info 
(** [default_system_info ()] is a new empty value for type [system_info] *)

val default_trace_stats_buffer_stats : unit -> trace_stats_buffer_stats 
(** [default_trace_stats_buffer_stats ()] is a new empty value for type [trace_stats_buffer_stats] *)

val default_trace_stats_writer_stats : unit -> trace_stats_writer_stats 
(** [default_trace_stats_writer_stats ()] is a new empty value for type [trace_stats_writer_stats] *)

val default_trace_stats_filter_stats : unit -> trace_stats_filter_stats 
(** [default_trace_stats_filter_stats ()] is a new empty value for type [trace_stats_filter_stats] *)

val default_trace_stats_final_flush_outcome : unit -> trace_stats_final_flush_outcome
(** [default_trace_stats_final_flush_outcome ()] is a new empty value for type [trace_stats_final_flush_outcome] *)

val default_trace_stats : unit -> trace_stats 
(** [default_trace_stats ()] is a new empty value for type [trace_stats] *)

val default_proto_log_message : unit -> proto_log_message 
(** [default_proto_log_message ()] is a new empty value for type [proto_log_message] *)

val default_proto_log_viewer_config_message_data : unit -> proto_log_viewer_config_message_data 
(** [default_proto_log_viewer_config_message_data ()] is a new empty value for type [proto_log_viewer_config_message_data] *)

val default_proto_log_viewer_config_group : unit -> proto_log_viewer_config_group 
(** [default_proto_log_viewer_config_group ()] is a new empty value for type [proto_log_viewer_config_group] *)

val default_proto_log_viewer_config : unit -> proto_log_viewer_config 
(** [default_proto_log_viewer_config ()] is a new empty value for type [proto_log_viewer_config] *)

val default_shell_transition_target : unit -> shell_transition_target 
(** [default_shell_transition_target ()] is a new empty value for type [shell_transition_target] *)

val default_shell_transition : unit -> shell_transition 
(** [default_shell_transition ()] is a new empty value for type [shell_transition] *)

val default_shell_handler_mapping : unit -> shell_handler_mapping 
(** [default_shell_handler_mapping ()] is a new empty value for type [shell_handler_mapping] *)

val default_shell_handler_mappings : unit -> shell_handler_mappings 
(** [default_shell_handler_mappings ()] is a new empty value for type [shell_handler_mappings] *)

val default_rect_proto : unit -> rect_proto 
(** [default_rect_proto ()] is a new empty value for type [rect_proto] *)

val default_region_proto : unit -> region_proto 
(** [default_region_proto ()] is a new empty value for type [region_proto] *)

val default_size_proto : unit -> size_proto 
(** [default_size_proto ()] is a new empty value for type [size_proto] *)

val default_transform_proto : unit -> transform_proto 
(** [default_transform_proto ()] is a new empty value for type [transform_proto] *)

val default_color_proto : unit -> color_proto 
(** [default_color_proto ()] is a new empty value for type [color_proto] *)

val default_input_window_info_proto : unit -> input_window_info_proto 
(** [default_input_window_info_proto ()] is a new empty value for type [input_window_info_proto] *)

val default_blur_region : unit -> blur_region 
(** [default_blur_region ()] is a new empty value for type [blur_region] *)

val default_color_transform_proto : unit -> color_transform_proto 
(** [default_color_transform_proto ()] is a new empty value for type [color_transform_proto] *)

val default_trusted_overlay : unit -> trusted_overlay
(** [default_trusted_overlay ()] is a new empty value for type [trusted_overlay] *)

val default_box_shadow_settings_box_shadow_params : unit -> box_shadow_settings_box_shadow_params 
(** [default_box_shadow_settings_box_shadow_params ()] is a new empty value for type [box_shadow_settings_box_shadow_params] *)

val default_box_shadow_settings : unit -> box_shadow_settings 
(** [default_box_shadow_settings ()] is a new empty value for type [box_shadow_settings] *)

val default_border_settings : unit -> border_settings 
(** [default_border_settings ()] is a new empty value for type [border_settings] *)

val default_layers_trace_file_proto_magic_number : unit -> layers_trace_file_proto_magic_number
(** [default_layers_trace_file_proto_magic_number ()] is a new empty value for type [layers_trace_file_proto_magic_number] *)

val default_position_proto : unit -> position_proto 
(** [default_position_proto ()] is a new empty value for type [position_proto] *)

val default_active_buffer_proto : unit -> active_buffer_proto 
(** [default_active_buffer_proto ()] is a new empty value for type [active_buffer_proto] *)

val default_float_rect_proto : unit -> float_rect_proto 
(** [default_float_rect_proto ()] is a new empty value for type [float_rect_proto] *)

val default_hwc_composition_type : unit -> hwc_composition_type
(** [default_hwc_composition_type ()] is a new empty value for type [hwc_composition_type] *)

val default_barrier_layer_proto : unit -> barrier_layer_proto 
(** [default_barrier_layer_proto ()] is a new empty value for type [barrier_layer_proto] *)

val default_corner_radii_proto : unit -> corner_radii_proto 
(** [default_corner_radii_proto ()] is a new empty value for type [corner_radii_proto] *)

val default_layer_proto : unit -> layer_proto 
(** [default_layer_proto ()] is a new empty value for type [layer_proto] *)

val default_layers_proto : unit -> layers_proto 
(** [default_layers_proto ()] is a new empty value for type [layers_proto] *)

val default_display_proto : unit -> display_proto 
(** [default_display_proto ()] is a new empty value for type [display_proto] *)

val default_layers_snapshot_proto : unit -> layers_snapshot_proto 
(** [default_layers_snapshot_proto ()] is a new empty value for type [layers_snapshot_proto] *)

val default_layers_trace_file_proto : unit -> layers_trace_file_proto 
(** [default_layers_trace_file_proto ()] is a new empty value for type [layers_trace_file_proto] *)

val default_transaction_trace_file_magic_number : unit -> transaction_trace_file_magic_number
(** [default_transaction_trace_file_magic_number ()] is a new empty value for type [transaction_trace_file_magic_number] *)

val default_layer_state_matrix22 : unit -> layer_state_matrix22 
(** [default_layer_state_matrix22 ()] is a new empty value for type [layer_state_matrix22] *)

val default_layer_state_color3 : unit -> layer_state_color3 
(** [default_layer_state_color3 ()] is a new empty value for type [layer_state_color3] *)

val default_layer_state_buffer_data_pixel_format : unit -> layer_state_buffer_data_pixel_format
(** [default_layer_state_buffer_data_pixel_format ()] is a new empty value for type [layer_state_buffer_data_pixel_format] *)

val default_layer_state_buffer_data : unit -> layer_state_buffer_data 
(** [default_layer_state_buffer_data ()] is a new empty value for type [layer_state_buffer_data] *)

val default_transform : unit -> transform 
(** [default_transform ()] is a new empty value for type [transform] *)

val default_layer_state_window_info : unit -> layer_state_window_info 
(** [default_layer_state_window_info ()] is a new empty value for type [layer_state_window_info] *)

val default_layer_state_drop_input_mode : unit -> layer_state_drop_input_mode
(** [default_layer_state_drop_input_mode ()] is a new empty value for type [layer_state_drop_input_mode] *)

val default_layer_state_corner_radii : unit -> layer_state_corner_radii 
(** [default_layer_state_corner_radii ()] is a new empty value for type [layer_state_corner_radii] *)

val default_layer_state : unit -> layer_state 
(** [default_layer_state ()] is a new empty value for type [layer_state] *)

val default_display_state : unit -> display_state 
(** [default_display_state ()] is a new empty value for type [display_state] *)

val default_transaction_barrier : unit -> transaction_barrier 
(** [default_transaction_barrier ()] is a new empty value for type [transaction_barrier] *)

val default_transaction_state : unit -> transaction_state 
(** [default_transaction_state ()] is a new empty value for type [transaction_state] *)

val default_layer_creation_args : unit -> layer_creation_args 
(** [default_layer_creation_args ()] is a new empty value for type [layer_creation_args] *)

val default_display_info : unit -> display_info 
(** [default_display_info ()] is a new empty value for type [display_info] *)

val default_transaction_trace_entry : unit -> transaction_trace_entry 
(** [default_transaction_trace_entry ()] is a new empty value for type [transaction_trace_entry] *)

val default_transaction_trace_file : unit -> transaction_trace_file 
(** [default_transaction_trace_file ()] is a new empty value for type [transaction_trace_file] *)

val default_layer_state_changes_lsb : unit -> layer_state_changes_lsb
(** [default_layer_state_changes_lsb ()] is a new empty value for type [layer_state_changes_lsb] *)

val default_layer_state_changes_msb : unit -> layer_state_changes_msb
(** [default_layer_state_changes_msb ()] is a new empty value for type [layer_state_changes_msb] *)

val default_layer_state_flags : unit -> layer_state_flags
(** [default_layer_state_flags ()] is a new empty value for type [layer_state_flags] *)

val default_layer_state_buffer_data_buffer_data_change : unit -> layer_state_buffer_data_buffer_data_change
(** [default_layer_state_buffer_data_buffer_data_change ()] is a new empty value for type [layer_state_buffer_data_buffer_data_change] *)

val default_display_state_changes : unit -> display_state_changes
(** [default_display_state_changes ()] is a new empty value for type [display_state_changes] *)

val default_winscope_extensions : unit
(** [default_winscope_extensions] is the default value for type [winscope_extensions] *)

val default_chrome_benchmark_metadata : unit -> chrome_benchmark_metadata 
(** [default_chrome_benchmark_metadata ()] is a new empty value for type [chrome_benchmark_metadata] *)

val default_chrome_metadata_packet_finch_hash : unit -> chrome_metadata_packet_finch_hash 
(** [default_chrome_metadata_packet_finch_hash ()] is a new empty value for type [chrome_metadata_packet_finch_hash] *)

val default_background_tracing_metadata_trigger_rule_trigger_type : unit -> background_tracing_metadata_trigger_rule_trigger_type
(** [default_background_tracing_metadata_trigger_rule_trigger_type ()] is a new empty value for type [background_tracing_metadata_trigger_rule_trigger_type] *)

val default_background_tracing_metadata_trigger_rule_histogram_rule : unit -> background_tracing_metadata_trigger_rule_histogram_rule 
(** [default_background_tracing_metadata_trigger_rule_histogram_rule ()] is a new empty value for type [background_tracing_metadata_trigger_rule_histogram_rule] *)

val default_background_tracing_metadata_trigger_rule_named_rule_event_type : unit -> background_tracing_metadata_trigger_rule_named_rule_event_type
(** [default_background_tracing_metadata_trigger_rule_named_rule_event_type ()] is a new empty value for type [background_tracing_metadata_trigger_rule_named_rule_event_type] *)

val default_background_tracing_metadata_trigger_rule_named_rule : unit -> background_tracing_metadata_trigger_rule_named_rule 
(** [default_background_tracing_metadata_trigger_rule_named_rule ()] is a new empty value for type [background_tracing_metadata_trigger_rule_named_rule] *)

val default_background_tracing_metadata_trigger_rule : unit -> background_tracing_metadata_trigger_rule 
(** [default_background_tracing_metadata_trigger_rule ()] is a new empty value for type [background_tracing_metadata_trigger_rule] *)

val default_background_tracing_metadata : unit -> background_tracing_metadata 
(** [default_background_tracing_metadata ()] is a new empty value for type [background_tracing_metadata] *)

val default_chrome_metadata_packet : unit -> chrome_metadata_packet 
(** [default_chrome_metadata_packet ()] is a new empty value for type [chrome_metadata_packet] *)

val default_chrome_traced_value_nested_type : unit -> chrome_traced_value_nested_type
(** [default_chrome_traced_value_nested_type ()] is a new empty value for type [chrome_traced_value_nested_type] *)

val default_chrome_traced_value : unit -> chrome_traced_value 
(** [default_chrome_traced_value ()] is a new empty value for type [chrome_traced_value] *)

val default_chrome_string_table_entry : unit -> chrome_string_table_entry 
(** [default_chrome_string_table_entry ()] is a new empty value for type [chrome_string_table_entry] *)

val default_chrome_trace_event_arg_value : unit -> chrome_trace_event_arg_value
(** [default_chrome_trace_event_arg_value ()] is a new empty value for type [chrome_trace_event_arg_value] *)

val default_chrome_trace_event_arg : unit -> chrome_trace_event_arg 
(** [default_chrome_trace_event_arg ()] is a new empty value for type [chrome_trace_event_arg] *)

val default_chrome_trace_event : unit -> chrome_trace_event 
(** [default_chrome_trace_event ()] is a new empty value for type [chrome_trace_event] *)

val default_chrome_metadata_value : unit -> chrome_metadata_value
(** [default_chrome_metadata_value ()] is a new empty value for type [chrome_metadata_value] *)

val default_chrome_metadata : unit -> chrome_metadata 
(** [default_chrome_metadata ()] is a new empty value for type [chrome_metadata] *)

val default_chrome_legacy_json_trace_trace_type : unit -> chrome_legacy_json_trace_trace_type
(** [default_chrome_legacy_json_trace_trace_type ()] is a new empty value for type [chrome_legacy_json_trace_trace_type] *)

val default_chrome_legacy_json_trace : unit -> chrome_legacy_json_trace 
(** [default_chrome_legacy_json_trace ()] is a new empty value for type [chrome_legacy_json_trace] *)

val default_chrome_event_bundle : unit -> chrome_event_bundle 
(** [default_chrome_event_bundle ()] is a new empty value for type [chrome_event_bundle] *)

val default_chrome_trigger : unit -> chrome_trigger 
(** [default_chrome_trigger ()] is a new empty value for type [chrome_trigger] *)

val default_v8_string : unit -> v8_string
(** [default_v8_string ()] is a new empty value for type [v8_string] *)

val default_interned_v8_string_encoded_string : unit -> interned_v8_string_encoded_string
(** [default_interned_v8_string_encoded_string ()] is a new empty value for type [interned_v8_string_encoded_string] *)

val default_interned_v8_string : unit -> interned_v8_string 
(** [default_interned_v8_string ()] is a new empty value for type [interned_v8_string] *)

val default_interned_v8_js_script_type : unit -> interned_v8_js_script_type
(** [default_interned_v8_js_script_type ()] is a new empty value for type [interned_v8_js_script_type] *)

val default_interned_v8_js_script : unit -> interned_v8_js_script 
(** [default_interned_v8_js_script ()] is a new empty value for type [interned_v8_js_script] *)

val default_interned_v8_wasm_script : unit -> interned_v8_wasm_script 
(** [default_interned_v8_wasm_script ()] is a new empty value for type [interned_v8_wasm_script] *)

val default_interned_v8_js_function_kind : unit -> interned_v8_js_function_kind
(** [default_interned_v8_js_function_kind ()] is a new empty value for type [interned_v8_js_function_kind] *)

val default_interned_v8_js_function : unit -> interned_v8_js_function 
(** [default_interned_v8_js_function ()] is a new empty value for type [interned_v8_js_function] *)

val default_interned_v8_isolate_code_range : unit -> interned_v8_isolate_code_range 
(** [default_interned_v8_isolate_code_range ()] is a new empty value for type [interned_v8_isolate_code_range] *)

val default_interned_v8_isolate : unit -> interned_v8_isolate 
(** [default_interned_v8_isolate ()] is a new empty value for type [interned_v8_isolate] *)

val default_v8_js_code_tier : unit -> v8_js_code_tier
(** [default_v8_js_code_tier ()] is a new empty value for type [v8_js_code_tier] *)

val default_v8_js_code_instructions : unit -> v8_js_code_instructions
(** [default_v8_js_code_instructions ()] is a new empty value for type [v8_js_code_instructions] *)

val default_v8_js_code : unit -> v8_js_code 
(** [default_v8_js_code ()] is a new empty value for type [v8_js_code] *)

val default_v8_internal_code_type : unit -> v8_internal_code_type
(** [default_v8_internal_code_type ()] is a new empty value for type [v8_internal_code_type] *)

val default_v8_internal_code : unit -> v8_internal_code 
(** [default_v8_internal_code ()] is a new empty value for type [v8_internal_code] *)

val default_v8_wasm_code_tier : unit -> v8_wasm_code_tier
(** [default_v8_wasm_code_tier ()] is a new empty value for type [v8_wasm_code_tier] *)

val default_v8_wasm_code : unit -> v8_wasm_code 
(** [default_v8_wasm_code ()] is a new empty value for type [v8_wasm_code] *)

val default_v8_reg_exp_code : unit -> v8_reg_exp_code 
(** [default_v8_reg_exp_code ()] is a new empty value for type [v8_reg_exp_code] *)

val default_v8_code_move_to_instructions : unit -> v8_code_move_to_instructions
(** [default_v8_code_move_to_instructions ()] is a new empty value for type [v8_code_move_to_instructions] *)

val default_v8_code_move : unit -> v8_code_move 
(** [default_v8_code_move ()] is a new empty value for type [v8_code_move] *)

val default_v8_code_defaults : unit -> v8_code_defaults 
(** [default_v8_code_defaults ()] is a new empty value for type [v8_code_defaults] *)

val default_clock_snapshot_clock_builtin_clocks : unit -> clock_snapshot_clock_builtin_clocks
(** [default_clock_snapshot_clock_builtin_clocks ()] is a new empty value for type [clock_snapshot_clock_builtin_clocks] *)

val default_clock_snapshot_clock : unit -> clock_snapshot_clock 
(** [default_clock_snapshot_clock ()] is a new empty value for type [clock_snapshot_clock] *)

val default_clock_snapshot : unit -> clock_snapshot 
(** [default_clock_snapshot ()] is a new empty value for type [clock_snapshot] *)

val default_cswitch_etw_event_old_thread_wait_reason : unit -> cswitch_etw_event_old_thread_wait_reason
(** [default_cswitch_etw_event_old_thread_wait_reason ()] is a new empty value for type [cswitch_etw_event_old_thread_wait_reason] *)

val default_cswitch_etw_event_old_thread_wait_mode : unit -> cswitch_etw_event_old_thread_wait_mode
(** [default_cswitch_etw_event_old_thread_wait_mode ()] is a new empty value for type [cswitch_etw_event_old_thread_wait_mode] *)

val default_cswitch_etw_event_old_thread_state : unit -> cswitch_etw_event_old_thread_state
(** [default_cswitch_etw_event_old_thread_state ()] is a new empty value for type [cswitch_etw_event_old_thread_state] *)

val default_cswitch_etw_event_old_thread_wait_reason_enum_or_int : unit -> cswitch_etw_event_old_thread_wait_reason_enum_or_int
(** [default_cswitch_etw_event_old_thread_wait_reason_enum_or_int ()] is a new empty value for type [cswitch_etw_event_old_thread_wait_reason_enum_or_int] *)

val default_cswitch_etw_event_old_thread_wait_mode_enum_or_int : unit -> cswitch_etw_event_old_thread_wait_mode_enum_or_int
(** [default_cswitch_etw_event_old_thread_wait_mode_enum_or_int ()] is a new empty value for type [cswitch_etw_event_old_thread_wait_mode_enum_or_int] *)

val default_cswitch_etw_event_old_thread_state_enum_or_int : unit -> cswitch_etw_event_old_thread_state_enum_or_int
(** [default_cswitch_etw_event_old_thread_state_enum_or_int ()] is a new empty value for type [cswitch_etw_event_old_thread_state_enum_or_int] *)

val default_cswitch_etw_event : unit -> cswitch_etw_event 
(** [default_cswitch_etw_event ()] is a new empty value for type [cswitch_etw_event] *)

val default_ready_thread_etw_event_adjust_reason : unit -> ready_thread_etw_event_adjust_reason
(** [default_ready_thread_etw_event_adjust_reason ()] is a new empty value for type [ready_thread_etw_event_adjust_reason] *)

val default_ready_thread_etw_event_trace_flag : unit -> ready_thread_etw_event_trace_flag
(** [default_ready_thread_etw_event_trace_flag ()] is a new empty value for type [ready_thread_etw_event_trace_flag] *)

val default_ready_thread_etw_event_adjust_reason_enum_or_int : unit -> ready_thread_etw_event_adjust_reason_enum_or_int
(** [default_ready_thread_etw_event_adjust_reason_enum_or_int ()] is a new empty value for type [ready_thread_etw_event_adjust_reason_enum_or_int] *)

val default_ready_thread_etw_event_flag_enum_or_int : unit -> ready_thread_etw_event_flag_enum_or_int
(** [default_ready_thread_etw_event_flag_enum_or_int ()] is a new empty value for type [ready_thread_etw_event_flag_enum_or_int] *)

val default_ready_thread_etw_event : unit -> ready_thread_etw_event 
(** [default_ready_thread_etw_event ()] is a new empty value for type [ready_thread_etw_event] *)

val default_mem_info_etw_event : unit -> mem_info_etw_event 
(** [default_mem_info_etw_event ()] is a new empty value for type [mem_info_etw_event] *)

val default_file_io_create_etw_event : unit -> file_io_create_etw_event 
(** [default_file_io_create_etw_event ()] is a new empty value for type [file_io_create_etw_event] *)

val default_file_io_dir_enum_etw_event : unit -> file_io_dir_enum_etw_event 
(** [default_file_io_dir_enum_etw_event ()] is a new empty value for type [file_io_dir_enum_etw_event] *)

val default_file_io_info_etw_event : unit -> file_io_info_etw_event 
(** [default_file_io_info_etw_event ()] is a new empty value for type [file_io_info_etw_event] *)

val default_file_io_read_write_etw_event : unit -> file_io_read_write_etw_event 
(** [default_file_io_read_write_etw_event ()] is a new empty value for type [file_io_read_write_etw_event] *)

val default_file_io_simple_op_etw_event : unit -> file_io_simple_op_etw_event 
(** [default_file_io_simple_op_etw_event ()] is a new empty value for type [file_io_simple_op_etw_event] *)

val default_file_io_op_end_etw_event : unit -> file_io_op_end_etw_event 
(** [default_file_io_op_end_etw_event ()] is a new empty value for type [file_io_op_end_etw_event] *)

val default_etw_trace_event_event : unit -> etw_trace_event_event
(** [default_etw_trace_event_event ()] is a new empty value for type [etw_trace_event_event] *)

val default_etw_trace_event : unit -> etw_trace_event 
(** [default_etw_trace_event ()] is a new empty value for type [etw_trace_event] *)

val default_etw_trace_event_bundle : unit -> etw_trace_event_bundle 
(** [default_etw_trace_event_bundle ()] is a new empty value for type [etw_trace_event_bundle] *)

val default_evdev_event_input_event : unit -> evdev_event_input_event 
(** [default_evdev_event_input_event ()] is a new empty value for type [evdev_event_input_event] *)

val default_evdev_event_event : unit -> evdev_event_event
(** [default_evdev_event_event ()] is a new empty value for type [evdev_event_event] *)

val default_evdev_event : unit -> evdev_event 
(** [default_evdev_event ()] is a new empty value for type [evdev_event] *)

val default_field_descriptor_proto_label : unit -> field_descriptor_proto_label
(** [default_field_descriptor_proto_label ()] is a new empty value for type [field_descriptor_proto_label] *)

val default_field_descriptor_proto_type : unit -> field_descriptor_proto_type
(** [default_field_descriptor_proto_type ()] is a new empty value for type [field_descriptor_proto_type] *)

val default_uninterpreted_option_name_part : unit -> uninterpreted_option_name_part 
(** [default_uninterpreted_option_name_part ()] is a new empty value for type [uninterpreted_option_name_part] *)

val default_uninterpreted_option : unit -> uninterpreted_option 
(** [default_uninterpreted_option ()] is a new empty value for type [uninterpreted_option] *)

val default_field_options : unit -> field_options 
(** [default_field_options ()] is a new empty value for type [field_options] *)

val default_field_descriptor_proto : unit -> field_descriptor_proto 
(** [default_field_descriptor_proto ()] is a new empty value for type [field_descriptor_proto] *)

val default_enum_value_descriptor_proto : unit -> enum_value_descriptor_proto 
(** [default_enum_value_descriptor_proto ()] is a new empty value for type [enum_value_descriptor_proto] *)

val default_enum_descriptor_proto : unit -> enum_descriptor_proto 
(** [default_enum_descriptor_proto ()] is a new empty value for type [enum_descriptor_proto] *)

val default_oneof_options : unit
(** [default_oneof_options] is the default value for type [oneof_options] *)

val default_oneof_descriptor_proto : unit -> oneof_descriptor_proto 
(** [default_oneof_descriptor_proto ()] is a new empty value for type [oneof_descriptor_proto] *)

val default_descriptor_proto_reserved_range : unit -> descriptor_proto_reserved_range 
(** [default_descriptor_proto_reserved_range ()] is a new empty value for type [descriptor_proto_reserved_range] *)

val default_descriptor_proto : unit -> descriptor_proto 
(** [default_descriptor_proto ()] is a new empty value for type [descriptor_proto] *)

val default_file_descriptor_proto : unit -> file_descriptor_proto 
(** [default_file_descriptor_proto ()] is a new empty value for type [file_descriptor_proto] *)

val default_file_descriptor_set : unit -> file_descriptor_set 
(** [default_file_descriptor_set ()] is a new empty value for type [file_descriptor_set] *)

val default_extension_descriptor : unit -> extension_descriptor 
(** [default_extension_descriptor ()] is a new empty value for type [extension_descriptor] *)

val default_inode_file_map_entry_type : unit -> inode_file_map_entry_type
(** [default_inode_file_map_entry_type ()] is a new empty value for type [inode_file_map_entry_type] *)

val default_inode_file_map_entry : unit -> inode_file_map_entry 
(** [default_inode_file_map_entry ()] is a new empty value for type [inode_file_map_entry] *)

val default_inode_file_map : unit -> inode_file_map 
(** [default_inode_file_map ()] is a new empty value for type [inode_file_map] *)

val default_generic_kernel_cpu_frequency_event : unit -> generic_kernel_cpu_frequency_event 
(** [default_generic_kernel_cpu_frequency_event ()] is a new empty value for type [generic_kernel_cpu_frequency_event] *)

val default_generic_kernel_task_state_event_task_state_enum : unit -> generic_kernel_task_state_event_task_state_enum
(** [default_generic_kernel_task_state_event_task_state_enum ()] is a new empty value for type [generic_kernel_task_state_event_task_state_enum] *)

val default_generic_kernel_task_state_event : unit -> generic_kernel_task_state_event 
(** [default_generic_kernel_task_state_event ()] is a new empty value for type [generic_kernel_task_state_event] *)

val default_generic_kernel_task_rename_event : unit -> generic_kernel_task_rename_event 
(** [default_generic_kernel_task_rename_event ()] is a new empty value for type [generic_kernel_task_rename_event] *)

val default_generic_kernel_process_tree_thread : unit -> generic_kernel_process_tree_thread 
(** [default_generic_kernel_process_tree_thread ()] is a new empty value for type [generic_kernel_process_tree_thread] *)

val default_generic_kernel_process_tree_process : unit -> generic_kernel_process_tree_process 
(** [default_generic_kernel_process_tree_process ()] is a new empty value for type [generic_kernel_process_tree_process] *)

val default_generic_kernel_process_tree : unit -> generic_kernel_process_tree 
(** [default_generic_kernel_process_tree ()] is a new empty value for type [generic_kernel_process_tree] *)

val default_gpu_counter_event_gpu_counter_value : unit -> gpu_counter_event_gpu_counter_value
(** [default_gpu_counter_event_gpu_counter_value ()] is a new empty value for type [gpu_counter_event_gpu_counter_value] *)

val default_gpu_counter_event_gpu_counter : unit -> gpu_counter_event_gpu_counter 
(** [default_gpu_counter_event_gpu_counter ()] is a new empty value for type [gpu_counter_event_gpu_counter] *)

val default_gpu_counter_event : unit -> gpu_counter_event 
(** [default_gpu_counter_event ()] is a new empty value for type [gpu_counter_event] *)

val default_gpu_log_severity : unit -> gpu_log_severity
(** [default_gpu_log_severity ()] is a new empty value for type [gpu_log_severity] *)

val default_gpu_log : unit -> gpu_log 
(** [default_gpu_log ()] is a new empty value for type [gpu_log] *)

val default_gpu_render_stage_event_extra_data : unit -> gpu_render_stage_event_extra_data 
(** [default_gpu_render_stage_event_extra_data ()] is a new empty value for type [gpu_render_stage_event_extra_data] *)

val default_gpu_render_stage_event_specifications_context_spec : unit -> gpu_render_stage_event_specifications_context_spec 
(** [default_gpu_render_stage_event_specifications_context_spec ()] is a new empty value for type [gpu_render_stage_event_specifications_context_spec] *)

val default_gpu_render_stage_event_specifications_description : unit -> gpu_render_stage_event_specifications_description 
(** [default_gpu_render_stage_event_specifications_description ()] is a new empty value for type [gpu_render_stage_event_specifications_description] *)

val default_gpu_render_stage_event_specifications : unit -> gpu_render_stage_event_specifications 
(** [default_gpu_render_stage_event_specifications ()] is a new empty value for type [gpu_render_stage_event_specifications] *)

val default_gpu_render_stage_event : unit -> gpu_render_stage_event 
(** [default_gpu_render_stage_event ()] is a new empty value for type [gpu_render_stage_event] *)

val default_interned_graphics_context_api : unit -> interned_graphics_context_api
(** [default_interned_graphics_context_api ()] is a new empty value for type [interned_graphics_context_api] *)

val default_interned_graphics_context : unit -> interned_graphics_context 
(** [default_interned_graphics_context ()] is a new empty value for type [interned_graphics_context] *)

val default_interned_gpu_render_stage_specification_render_stage_category : unit -> interned_gpu_render_stage_specification_render_stage_category
(** [default_interned_gpu_render_stage_specification_render_stage_category ()] is a new empty value for type [interned_gpu_render_stage_specification_render_stage_category] *)

val default_interned_gpu_render_stage_specification : unit -> interned_gpu_render_stage_specification 
(** [default_interned_gpu_render_stage_specification ()] is a new empty value for type [interned_gpu_render_stage_specification] *)

val default_vulkan_api_event_vk_debug_utils_object_name : unit -> vulkan_api_event_vk_debug_utils_object_name 
(** [default_vulkan_api_event_vk_debug_utils_object_name ()] is a new empty value for type [vulkan_api_event_vk_debug_utils_object_name] *)

val default_vulkan_api_event_vk_queue_submit : unit -> vulkan_api_event_vk_queue_submit 
(** [default_vulkan_api_event_vk_queue_submit ()] is a new empty value for type [vulkan_api_event_vk_queue_submit] *)

val default_vulkan_api_event : unit -> vulkan_api_event
(** [default_vulkan_api_event ()] is a new empty value for type [vulkan_api_event] *)

val default_vulkan_memory_event_annotation_value : unit -> vulkan_memory_event_annotation_value
(** [default_vulkan_memory_event_annotation_value ()] is a new empty value for type [vulkan_memory_event_annotation_value] *)

val default_vulkan_memory_event_annotation : unit -> vulkan_memory_event_annotation 
(** [default_vulkan_memory_event_annotation ()] is a new empty value for type [vulkan_memory_event_annotation] *)

val default_vulkan_memory_event_source : unit -> vulkan_memory_event_source
(** [default_vulkan_memory_event_source ()] is a new empty value for type [vulkan_memory_event_source] *)

val default_vulkan_memory_event_operation : unit -> vulkan_memory_event_operation
(** [default_vulkan_memory_event_operation ()] is a new empty value for type [vulkan_memory_event_operation] *)

val default_vulkan_memory_event_allocation_scope : unit -> vulkan_memory_event_allocation_scope
(** [default_vulkan_memory_event_allocation_scope ()] is a new empty value for type [vulkan_memory_event_allocation_scope] *)

val default_vulkan_memory_event : unit -> vulkan_memory_event 
(** [default_vulkan_memory_event ()] is a new empty value for type [vulkan_memory_event] *)

val default_interned_string : unit -> interned_string 
(** [default_interned_string ()] is a new empty value for type [interned_string] *)

val default_line : unit -> line 
(** [default_line ()] is a new empty value for type [line] *)

val default_address_symbols : unit -> address_symbols 
(** [default_address_symbols ()] is a new empty value for type [address_symbols] *)

val default_module_symbols : unit -> module_symbols 
(** [default_module_symbols ()] is a new empty value for type [module_symbols] *)

val default_mapping : unit -> mapping 
(** [default_mapping ()] is a new empty value for type [mapping] *)

val default_frame : unit -> frame 
(** [default_frame ()] is a new empty value for type [frame] *)

val default_callstack : unit -> callstack 
(** [default_callstack ()] is a new empty value for type [callstack] *)

val default_histogram_name : unit -> histogram_name 
(** [default_histogram_name ()] is a new empty value for type [histogram_name] *)

val default_chrome_histogram_sample : unit -> chrome_histogram_sample 
(** [default_chrome_histogram_sample ()] is a new empty value for type [chrome_histogram_sample] *)

val default_debug_annotation_nested_value_nested_type : unit -> debug_annotation_nested_value_nested_type
(** [default_debug_annotation_nested_value_nested_type ()] is a new empty value for type [debug_annotation_nested_value_nested_type] *)

val default_debug_annotation_nested_value : unit -> debug_annotation_nested_value 
(** [default_debug_annotation_nested_value ()] is a new empty value for type [debug_annotation_nested_value] *)

val default_debug_annotation_name_field : unit -> debug_annotation_name_field
(** [default_debug_annotation_name_field ()] is a new empty value for type [debug_annotation_name_field] *)

val default_debug_annotation_value : unit -> debug_annotation_value
(** [default_debug_annotation_value ()] is a new empty value for type [debug_annotation_value] *)

val default_debug_annotation_proto_type_descriptor : unit -> debug_annotation_proto_type_descriptor
(** [default_debug_annotation_proto_type_descriptor ()] is a new empty value for type [debug_annotation_proto_type_descriptor] *)

val default_debug_annotation : unit -> debug_annotation 
(** [default_debug_annotation ()] is a new empty value for type [debug_annotation] *)

val default_debug_annotation_name : unit -> debug_annotation_name 
(** [default_debug_annotation_name ()] is a new empty value for type [debug_annotation_name] *)

val default_debug_annotation_value_type_name : unit -> debug_annotation_value_type_name 
(** [default_debug_annotation_value_type_name ()] is a new empty value for type [debug_annotation_value_type_name] *)

val default_log_message_priority : unit -> log_message_priority
(** [default_log_message_priority ()] is a new empty value for type [log_message_priority] *)

val default_log_message : unit -> log_message 
(** [default_log_message ()] is a new empty value for type [log_message] *)

val default_log_message_body : unit -> log_message_body 
(** [default_log_message_body ()] is a new empty value for type [log_message_body] *)

val default_unsymbolized_source_location : unit -> unsymbolized_source_location 
(** [default_unsymbolized_source_location ()] is a new empty value for type [unsymbolized_source_location] *)

val default_source_location : unit -> source_location 
(** [default_source_location ()] is a new empty value for type [source_location] *)

val default_chrome_active_processes : unit -> chrome_active_processes 
(** [default_chrome_active_processes ()] is a new empty value for type [chrome_active_processes] *)

val default_chrome_application_state_info_chrome_application_state : unit -> chrome_application_state_info_chrome_application_state
(** [default_chrome_application_state_info_chrome_application_state ()] is a new empty value for type [chrome_application_state_info_chrome_application_state] *)

val default_chrome_application_state_info : unit -> chrome_application_state_info 
(** [default_chrome_application_state_info ()] is a new empty value for type [chrome_application_state_info] *)

val default_chrome_compositor_scheduler_action : unit -> chrome_compositor_scheduler_action
(** [default_chrome_compositor_scheduler_action ()] is a new empty value for type [chrome_compositor_scheduler_action] *)

val default_chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode : unit -> chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode
(** [default_chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode ()] is a new empty value for type [chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode] *)

val default_chrome_compositor_state_machine_major_state_begin_impl_frame_state : unit -> chrome_compositor_state_machine_major_state_begin_impl_frame_state
(** [default_chrome_compositor_state_machine_major_state_begin_impl_frame_state ()] is a new empty value for type [chrome_compositor_state_machine_major_state_begin_impl_frame_state] *)

val default_chrome_compositor_state_machine_major_state_begin_main_frame_state : unit -> chrome_compositor_state_machine_major_state_begin_main_frame_state
(** [default_chrome_compositor_state_machine_major_state_begin_main_frame_state ()] is a new empty value for type [chrome_compositor_state_machine_major_state_begin_main_frame_state] *)

val default_chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state : unit -> chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state
(** [default_chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state ()] is a new empty value for type [chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state] *)

val default_chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state : unit -> chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state
(** [default_chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state ()] is a new empty value for type [chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state] *)

val default_chrome_compositor_state_machine_major_state : unit -> chrome_compositor_state_machine_major_state 
(** [default_chrome_compositor_state_machine_major_state ()] is a new empty value for type [chrome_compositor_state_machine_major_state] *)

val default_chrome_compositor_state_machine_minor_state_tree_priority : unit -> chrome_compositor_state_machine_minor_state_tree_priority
(** [default_chrome_compositor_state_machine_minor_state_tree_priority ()] is a new empty value for type [chrome_compositor_state_machine_minor_state_tree_priority] *)

val default_chrome_compositor_state_machine_minor_state_scroll_handler_state : unit -> chrome_compositor_state_machine_minor_state_scroll_handler_state
(** [default_chrome_compositor_state_machine_minor_state_scroll_handler_state ()] is a new empty value for type [chrome_compositor_state_machine_minor_state_scroll_handler_state] *)

val default_chrome_compositor_state_machine_minor_state : unit -> chrome_compositor_state_machine_minor_state 
(** [default_chrome_compositor_state_machine_minor_state ()] is a new empty value for type [chrome_compositor_state_machine_minor_state] *)

val default_chrome_compositor_state_machine : unit -> chrome_compositor_state_machine 
(** [default_chrome_compositor_state_machine ()] is a new empty value for type [chrome_compositor_state_machine] *)

val default_begin_impl_frame_args_state : unit -> begin_impl_frame_args_state
(** [default_begin_impl_frame_args_state ()] is a new empty value for type [begin_impl_frame_args_state] *)

val default_begin_frame_args_begin_frame_args_type : unit -> begin_frame_args_begin_frame_args_type
(** [default_begin_frame_args_begin_frame_args_type ()] is a new empty value for type [begin_frame_args_begin_frame_args_type] *)

val default_begin_frame_args_created_from : unit -> begin_frame_args_created_from
(** [default_begin_frame_args_created_from ()] is a new empty value for type [begin_frame_args_created_from] *)

val default_begin_frame_args : unit -> begin_frame_args 
(** [default_begin_frame_args ()] is a new empty value for type [begin_frame_args] *)

val default_begin_impl_frame_args_timestamps_in_us : unit -> begin_impl_frame_args_timestamps_in_us 
(** [default_begin_impl_frame_args_timestamps_in_us ()] is a new empty value for type [begin_impl_frame_args_timestamps_in_us] *)

val default_begin_impl_frame_args_args : unit -> begin_impl_frame_args_args
(** [default_begin_impl_frame_args_args ()] is a new empty value for type [begin_impl_frame_args_args] *)

val default_begin_impl_frame_args : unit -> begin_impl_frame_args 
(** [default_begin_impl_frame_args ()] is a new empty value for type [begin_impl_frame_args] *)

val default_begin_frame_observer_state : unit -> begin_frame_observer_state 
(** [default_begin_frame_observer_state ()] is a new empty value for type [begin_frame_observer_state] *)

val default_begin_frame_source_state : unit -> begin_frame_source_state 
(** [default_begin_frame_source_state ()] is a new empty value for type [begin_frame_source_state] *)

val default_compositor_timing_history : unit -> compositor_timing_history 
(** [default_compositor_timing_history ()] is a new empty value for type [compositor_timing_history] *)

val default_chrome_compositor_scheduler_state : unit -> chrome_compositor_scheduler_state 
(** [default_chrome_compositor_scheduler_state ()] is a new empty value for type [chrome_compositor_scheduler_state] *)

val default_chrome_content_settings_event_info : unit -> chrome_content_settings_event_info 
(** [default_chrome_content_settings_event_info ()] is a new empty value for type [chrome_content_settings_event_info] *)

val default_chrome_frame_reporter_state : unit -> chrome_frame_reporter_state
(** [default_chrome_frame_reporter_state ()] is a new empty value for type [chrome_frame_reporter_state] *)

val default_chrome_frame_reporter_frame_drop_reason : unit -> chrome_frame_reporter_frame_drop_reason
(** [default_chrome_frame_reporter_frame_drop_reason ()] is a new empty value for type [chrome_frame_reporter_frame_drop_reason] *)

val default_chrome_frame_reporter_scroll_state : unit -> chrome_frame_reporter_scroll_state
(** [default_chrome_frame_reporter_scroll_state ()] is a new empty value for type [chrome_frame_reporter_scroll_state] *)

val default_chrome_frame_reporter_frame_type : unit -> chrome_frame_reporter_frame_type
(** [default_chrome_frame_reporter_frame_type ()] is a new empty value for type [chrome_frame_reporter_frame_type] *)

val default_chrome_frame_reporter : unit -> chrome_frame_reporter 
(** [default_chrome_frame_reporter ()] is a new empty value for type [chrome_frame_reporter] *)

val default_chrome_keyed_service : unit -> chrome_keyed_service 
(** [default_chrome_keyed_service ()] is a new empty value for type [chrome_keyed_service] *)

val default_chrome_latency_info_step : unit -> chrome_latency_info_step
(** [default_chrome_latency_info_step ()] is a new empty value for type [chrome_latency_info_step] *)

val default_chrome_latency_info_latency_component_type : unit -> chrome_latency_info_latency_component_type
(** [default_chrome_latency_info_latency_component_type ()] is a new empty value for type [chrome_latency_info_latency_component_type] *)

val default_chrome_latency_info_component_info : unit -> chrome_latency_info_component_info 
(** [default_chrome_latency_info_component_info ()] is a new empty value for type [chrome_latency_info_component_info] *)

val default_chrome_latency_info_input_type : unit -> chrome_latency_info_input_type
(** [default_chrome_latency_info_input_type ()] is a new empty value for type [chrome_latency_info_input_type] *)

val default_chrome_latency_info : unit -> chrome_latency_info 
(** [default_chrome_latency_info ()] is a new empty value for type [chrome_latency_info] *)

val default_chrome_legacy_ipc_message_class : unit -> chrome_legacy_ipc_message_class
(** [default_chrome_legacy_ipc_message_class ()] is a new empty value for type [chrome_legacy_ipc_message_class] *)

val default_chrome_legacy_ipc : unit -> chrome_legacy_ipc 
(** [default_chrome_legacy_ipc ()] is a new empty value for type [chrome_legacy_ipc] *)

val default_chrome_message_pump : unit -> chrome_message_pump 
(** [default_chrome_message_pump ()] is a new empty value for type [chrome_message_pump] *)

val default_chrome_mojo_event_info : unit -> chrome_mojo_event_info 
(** [default_chrome_mojo_event_info ()] is a new empty value for type [chrome_mojo_event_info] *)

val default_chrome_railmode : unit -> chrome_railmode
(** [default_chrome_railmode ()] is a new empty value for type [chrome_railmode] *)

val default_chrome_renderer_scheduler_state : unit -> chrome_renderer_scheduler_state 
(** [default_chrome_renderer_scheduler_state ()] is a new empty value for type [chrome_renderer_scheduler_state] *)

val default_chrome_user_event : unit -> chrome_user_event 
(** [default_chrome_user_event ()] is a new empty value for type [chrome_user_event] *)

val default_chrome_window_handle_event_info : unit -> chrome_window_handle_event_info 
(** [default_chrome_window_handle_event_info ()] is a new empty value for type [chrome_window_handle_event_info] *)

val default_screenshot : unit -> screenshot 
(** [default_screenshot ()] is a new empty value for type [screenshot] *)

val default_task_execution : unit -> task_execution 
(** [default_task_execution ()] is a new empty value for type [task_execution] *)

val default_track_event_type : unit -> track_event_type
(** [default_track_event_type ()] is a new empty value for type [track_event_type] *)

val default_track_event_callstack_frame : unit -> track_event_callstack_frame 
(** [default_track_event_callstack_frame ()] is a new empty value for type [track_event_callstack_frame] *)

val default_track_event_callstack : unit -> track_event_callstack 
(** [default_track_event_callstack ()] is a new empty value for type [track_event_callstack] *)

val default_track_event_legacy_event_flow_direction : unit -> track_event_legacy_event_flow_direction
(** [default_track_event_legacy_event_flow_direction ()] is a new empty value for type [track_event_legacy_event_flow_direction] *)

val default_track_event_legacy_event_instant_event_scope : unit -> track_event_legacy_event_instant_event_scope
(** [default_track_event_legacy_event_instant_event_scope ()] is a new empty value for type [track_event_legacy_event_instant_event_scope] *)

val default_track_event_legacy_event_id : unit -> track_event_legacy_event_id
(** [default_track_event_legacy_event_id ()] is a new empty value for type [track_event_legacy_event_id] *)

val default_track_event_legacy_event : unit -> track_event_legacy_event 
(** [default_track_event_legacy_event ()] is a new empty value for type [track_event_legacy_event] *)

val default_track_event_name_field : unit -> track_event_name_field
(** [default_track_event_name_field ()] is a new empty value for type [track_event_name_field] *)

val default_track_event_counter_value_field : unit -> track_event_counter_value_field
(** [default_track_event_counter_value_field ()] is a new empty value for type [track_event_counter_value_field] *)

val default_track_event_correlation_id_field : unit -> track_event_correlation_id_field
(** [default_track_event_correlation_id_field ()] is a new empty value for type [track_event_correlation_id_field] *)

val default_track_event_callstack_field : unit -> track_event_callstack_field
(** [default_track_event_callstack_field ()] is a new empty value for type [track_event_callstack_field] *)

val default_track_event_source_location_field : unit -> track_event_source_location_field
(** [default_track_event_source_location_field ()] is a new empty value for type [track_event_source_location_field] *)

val default_track_event_timestamp : unit -> track_event_timestamp
(** [default_track_event_timestamp ()] is a new empty value for type [track_event_timestamp] *)

val default_track_event_thread_time : unit -> track_event_thread_time
(** [default_track_event_thread_time ()] is a new empty value for type [track_event_thread_time] *)

val default_track_event_thread_instruction_count : unit -> track_event_thread_instruction_count
(** [default_track_event_thread_instruction_count ()] is a new empty value for type [track_event_thread_instruction_count] *)

val default_track_event : unit -> track_event 
(** [default_track_event ()] is a new empty value for type [track_event] *)

val default_track_event_defaults : unit -> track_event_defaults 
(** [default_track_event_defaults ()] is a new empty value for type [track_event_defaults] *)

val default_event_category : unit -> event_category 
(** [default_event_category ()] is a new empty value for type [event_category] *)

val default_event_name : unit -> event_name 
(** [default_event_name ()] is a new empty value for type [event_name] *)

val default_interned_data : unit -> interned_data 
(** [default_interned_data ()] is a new empty value for type [interned_data] *)

val default_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units : unit -> memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units
(** [default_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units ()] is a new empty value for type [memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units] *)

val default_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry : unit -> memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry 
(** [default_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry ()] is a new empty value for type [memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry] *)

val default_memory_tracker_snapshot_process_snapshot_memory_node : unit -> memory_tracker_snapshot_process_snapshot_memory_node 
(** [default_memory_tracker_snapshot_process_snapshot_memory_node ()] is a new empty value for type [memory_tracker_snapshot_process_snapshot_memory_node] *)

val default_memory_tracker_snapshot_process_snapshot_memory_edge : unit -> memory_tracker_snapshot_process_snapshot_memory_edge 
(** [default_memory_tracker_snapshot_process_snapshot_memory_edge ()] is a new empty value for type [memory_tracker_snapshot_process_snapshot_memory_edge] *)

val default_memory_tracker_snapshot_process_snapshot : unit -> memory_tracker_snapshot_process_snapshot 
(** [default_memory_tracker_snapshot_process_snapshot ()] is a new empty value for type [memory_tracker_snapshot_process_snapshot] *)

val default_memory_tracker_snapshot_level_of_detail : unit -> memory_tracker_snapshot_level_of_detail
(** [default_memory_tracker_snapshot_level_of_detail ()] is a new empty value for type [memory_tracker_snapshot_level_of_detail] *)

val default_memory_tracker_snapshot : unit -> memory_tracker_snapshot 
(** [default_memory_tracker_snapshot ()] is a new empty value for type [memory_tracker_snapshot] *)

val default_perfetto_metatrace_arg_key_or_interned_key : unit -> perfetto_metatrace_arg_key_or_interned_key
(** [default_perfetto_metatrace_arg_key_or_interned_key ()] is a new empty value for type [perfetto_metatrace_arg_key_or_interned_key] *)

val default_perfetto_metatrace_arg_value_or_interned_value : unit -> perfetto_metatrace_arg_value_or_interned_value
(** [default_perfetto_metatrace_arg_value_or_interned_value ()] is a new empty value for type [perfetto_metatrace_arg_value_or_interned_value] *)

val default_perfetto_metatrace_arg : unit -> perfetto_metatrace_arg 
(** [default_perfetto_metatrace_arg ()] is a new empty value for type [perfetto_metatrace_arg] *)

val default_perfetto_metatrace_interned_string : unit -> perfetto_metatrace_interned_string 
(** [default_perfetto_metatrace_interned_string ()] is a new empty value for type [perfetto_metatrace_interned_string] *)

val default_perfetto_metatrace_record_type : unit -> perfetto_metatrace_record_type
(** [default_perfetto_metatrace_record_type ()] is a new empty value for type [perfetto_metatrace_record_type] *)

val default_perfetto_metatrace : unit -> perfetto_metatrace 
(** [default_perfetto_metatrace ()] is a new empty value for type [perfetto_metatrace] *)

val default_tracing_service_event_data_sources_data_source : unit -> tracing_service_event_data_sources_data_source 
(** [default_tracing_service_event_data_sources_data_source ()] is a new empty value for type [tracing_service_event_data_sources_data_source] *)

val default_tracing_service_event_data_sources : unit -> tracing_service_event_data_sources 
(** [default_tracing_service_event_data_sources ()] is a new empty value for type [tracing_service_event_data_sources] *)

val default_tracing_service_event : unit -> tracing_service_event
(** [default_tracing_service_event ()] is a new empty value for type [tracing_service_event] *)

val default_android_energy_consumer : unit -> android_energy_consumer 
(** [default_android_energy_consumer ()] is a new empty value for type [android_energy_consumer] *)

val default_android_energy_consumer_descriptor : unit -> android_energy_consumer_descriptor 
(** [default_android_energy_consumer_descriptor ()] is a new empty value for type [android_energy_consumer_descriptor] *)

val default_android_energy_estimation_breakdown_energy_uid_breakdown : unit -> android_energy_estimation_breakdown_energy_uid_breakdown 
(** [default_android_energy_estimation_breakdown_energy_uid_breakdown ()] is a new empty value for type [android_energy_estimation_breakdown_energy_uid_breakdown] *)

val default_android_energy_estimation_breakdown : unit -> android_energy_estimation_breakdown 
(** [default_android_energy_estimation_breakdown ()] is a new empty value for type [android_energy_estimation_breakdown] *)

val default_entity_state_residency_power_entity_state : unit -> entity_state_residency_power_entity_state 
(** [default_entity_state_residency_power_entity_state ()] is a new empty value for type [entity_state_residency_power_entity_state] *)

val default_entity_state_residency_state_residency : unit -> entity_state_residency_state_residency 
(** [default_entity_state_residency_state_residency ()] is a new empty value for type [entity_state_residency_state_residency] *)

val default_entity_state_residency : unit -> entity_state_residency 
(** [default_entity_state_residency ()] is a new empty value for type [entity_state_residency] *)

val default_battery_counters : unit -> battery_counters 
(** [default_battery_counters ()] is a new empty value for type [battery_counters] *)

val default_power_rails_rail_descriptor : unit -> power_rails_rail_descriptor 
(** [default_power_rails_rail_descriptor ()] is a new empty value for type [power_rails_rail_descriptor] *)

val default_power_rails_energy_data : unit -> power_rails_energy_data 
(** [default_power_rails_energy_data ()] is a new empty value for type [power_rails_energy_data] *)

val default_power_rails : unit -> power_rails 
(** [default_power_rails ()] is a new empty value for type [power_rails] *)

val default_obfuscated_member : unit -> obfuscated_member 
(** [default_obfuscated_member ()] is a new empty value for type [obfuscated_member] *)

val default_obfuscated_class : unit -> obfuscated_class 
(** [default_obfuscated_class ()] is a new empty value for type [obfuscated_class] *)

val default_deobfuscation_mapping : unit -> deobfuscation_mapping 
(** [default_deobfuscation_mapping ()] is a new empty value for type [deobfuscation_mapping] *)

val default_heap_graph_root_type : unit -> heap_graph_root_type
(** [default_heap_graph_root_type ()] is a new empty value for type [heap_graph_root_type] *)

val default_heap_graph_root : unit -> heap_graph_root 
(** [default_heap_graph_root ()] is a new empty value for type [heap_graph_root] *)

val default_heap_graph_type_kind : unit -> heap_graph_type_kind
(** [default_heap_graph_type_kind ()] is a new empty value for type [heap_graph_type_kind] *)

val default_heap_graph_type : unit -> heap_graph_type 
(** [default_heap_graph_type ()] is a new empty value for type [heap_graph_type] *)

val default_heap_graph_object_heap_type : unit -> heap_graph_object_heap_type
(** [default_heap_graph_object_heap_type ()] is a new empty value for type [heap_graph_object_heap_type] *)

val default_heap_graph_object_identifier : unit -> heap_graph_object_identifier
(** [default_heap_graph_object_identifier ()] is a new empty value for type [heap_graph_object_identifier] *)

val default_heap_graph_object : unit -> heap_graph_object 
(** [default_heap_graph_object ()] is a new empty value for type [heap_graph_object] *)

val default_heap_graph : unit -> heap_graph 
(** [default_heap_graph ()] is a new empty value for type [heap_graph] *)

val default_profile_packet_heap_sample : unit -> profile_packet_heap_sample 
(** [default_profile_packet_heap_sample ()] is a new empty value for type [profile_packet_heap_sample] *)

val default_profile_packet_histogram_bucket : unit -> profile_packet_histogram_bucket 
(** [default_profile_packet_histogram_bucket ()] is a new empty value for type [profile_packet_histogram_bucket] *)

val default_profile_packet_histogram : unit -> profile_packet_histogram 
(** [default_profile_packet_histogram ()] is a new empty value for type [profile_packet_histogram] *)

val default_profile_packet_process_stats : unit -> profile_packet_process_stats 
(** [default_profile_packet_process_stats ()] is a new empty value for type [profile_packet_process_stats] *)

val default_profile_packet_process_heap_samples_client_error : unit -> profile_packet_process_heap_samples_client_error
(** [default_profile_packet_process_heap_samples_client_error ()] is a new empty value for type [profile_packet_process_heap_samples_client_error] *)

val default_profile_packet_process_heap_samples : unit -> profile_packet_process_heap_samples 
(** [default_profile_packet_process_heap_samples ()] is a new empty value for type [profile_packet_process_heap_samples] *)

val default_profile_packet : unit -> profile_packet 
(** [default_profile_packet ()] is a new empty value for type [profile_packet] *)

val default_streaming_allocation : unit -> streaming_allocation 
(** [default_streaming_allocation ()] is a new empty value for type [streaming_allocation] *)

val default_streaming_free : unit -> streaming_free 
(** [default_streaming_free ()] is a new empty value for type [streaming_free] *)

val default_streaming_profile_packet : unit -> streaming_profile_packet 
(** [default_streaming_profile_packet ()] is a new empty value for type [streaming_profile_packet] *)

val default_profiling_cpu_mode : unit -> profiling_cpu_mode
(** [default_profiling_cpu_mode ()] is a new empty value for type [profiling_cpu_mode] *)

val default_profiling_stack_unwind_error : unit -> profiling_stack_unwind_error
(** [default_profiling_stack_unwind_error ()] is a new empty value for type [profiling_stack_unwind_error] *)

val default_profiling : unit
(** [default_profiling] is the default value for type [profiling] *)

val default_perf_sample_sample_skip_reason : unit -> perf_sample_sample_skip_reason
(** [default_perf_sample_sample_skip_reason ()] is a new empty value for type [perf_sample_sample_skip_reason] *)

val default_perf_sample_producer_event_data_source_stop_reason : unit -> perf_sample_producer_event_data_source_stop_reason
(** [default_perf_sample_producer_event_data_source_stop_reason ()] is a new empty value for type [perf_sample_producer_event_data_source_stop_reason] *)

val default_perf_sample_producer_event : unit -> perf_sample_producer_event
(** [default_perf_sample_producer_event ()] is a new empty value for type [perf_sample_producer_event] *)

val default_perf_sample_optional_unwind_error : unit -> perf_sample_optional_unwind_error
(** [default_perf_sample_optional_unwind_error ()] is a new empty value for type [perf_sample_optional_unwind_error] *)

val default_perf_sample_optional_sample_skipped_reason : unit -> perf_sample_optional_sample_skipped_reason
(** [default_perf_sample_optional_sample_skipped_reason ()] is a new empty value for type [perf_sample_optional_sample_skipped_reason] *)

val default_perf_sample : unit -> perf_sample 
(** [default_perf_sample ()] is a new empty value for type [perf_sample] *)

val default_smaps_entry : unit -> smaps_entry 
(** [default_smaps_entry ()] is a new empty value for type [smaps_entry] *)

val default_smaps_packet : unit -> smaps_packet 
(** [default_smaps_packet ()] is a new empty value for type [smaps_packet] *)

val default_process_stats_thread : unit -> process_stats_thread 
(** [default_process_stats_thread ()] is a new empty value for type [process_stats_thread] *)

val default_process_stats_fdinfo : unit -> process_stats_fdinfo 
(** [default_process_stats_fdinfo ()] is a new empty value for type [process_stats_fdinfo] *)

val default_process_stats_process : unit -> process_stats_process 
(** [default_process_stats_process ()] is a new empty value for type [process_stats_process] *)

val default_process_stats : unit -> process_stats 
(** [default_process_stats ()] is a new empty value for type [process_stats] *)

val default_process_tree_thread : unit -> process_tree_thread 
(** [default_process_tree_thread ()] is a new empty value for type [process_tree_thread] *)

val default_process_tree_process : unit -> process_tree_process 
(** [default_process_tree_process ()] is a new empty value for type [process_tree_process] *)

val default_process_tree : unit -> process_tree 
(** [default_process_tree ()] is a new empty value for type [process_tree] *)

val default_remote_clock_sync_synced_clocks : unit -> remote_clock_sync_synced_clocks 
(** [default_remote_clock_sync_synced_clocks ()] is a new empty value for type [remote_clock_sync_synced_clocks] *)

val default_remote_clock_sync : unit -> remote_clock_sync 
(** [default_remote_clock_sync ()] is a new empty value for type [remote_clock_sync] *)

val default_atom : unit
(** [default_atom] is the default value for type [atom] *)

val default_statsd_atom : unit -> statsd_atom 
(** [default_statsd_atom ()] is a new empty value for type [statsd_atom] *)

val default_sys_stats_meminfo_value : unit -> sys_stats_meminfo_value 
(** [default_sys_stats_meminfo_value ()] is a new empty value for type [sys_stats_meminfo_value] *)

val default_sys_stats_vmstat_value : unit -> sys_stats_vmstat_value 
(** [default_sys_stats_vmstat_value ()] is a new empty value for type [sys_stats_vmstat_value] *)

val default_sys_stats_cpu_times : unit -> sys_stats_cpu_times 
(** [default_sys_stats_cpu_times ()] is a new empty value for type [sys_stats_cpu_times] *)

val default_sys_stats_interrupt_count : unit -> sys_stats_interrupt_count 
(** [default_sys_stats_interrupt_count ()] is a new empty value for type [sys_stats_interrupt_count] *)

val default_sys_stats_devfreq_value : unit -> sys_stats_devfreq_value 
(** [default_sys_stats_devfreq_value ()] is a new empty value for type [sys_stats_devfreq_value] *)

val default_sys_stats_buddy_info : unit -> sys_stats_buddy_info 
(** [default_sys_stats_buddy_info ()] is a new empty value for type [sys_stats_buddy_info] *)

val default_sys_stats_disk_stat : unit -> sys_stats_disk_stat 
(** [default_sys_stats_disk_stat ()] is a new empty value for type [sys_stats_disk_stat] *)

val default_sys_stats_psi_sample_psi_resource : unit -> sys_stats_psi_sample_psi_resource
(** [default_sys_stats_psi_sample_psi_resource ()] is a new empty value for type [sys_stats_psi_sample_psi_resource] *)

val default_sys_stats_psi_sample : unit -> sys_stats_psi_sample 
(** [default_sys_stats_psi_sample ()] is a new empty value for type [sys_stats_psi_sample] *)

val default_sys_stats_thermal_zone : unit -> sys_stats_thermal_zone 
(** [default_sys_stats_thermal_zone ()] is a new empty value for type [sys_stats_thermal_zone] *)

val default_sys_stats_cpu_idle_state_entry : unit -> sys_stats_cpu_idle_state_entry 
(** [default_sys_stats_cpu_idle_state_entry ()] is a new empty value for type [sys_stats_cpu_idle_state_entry] *)

val default_sys_stats_cpu_idle_state : unit -> sys_stats_cpu_idle_state 
(** [default_sys_stats_cpu_idle_state ()] is a new empty value for type [sys_stats_cpu_idle_state] *)

val default_sys_stats : unit -> sys_stats 
(** [default_sys_stats ()] is a new empty value for type [sys_stats] *)

val default_cpu_info_arm_cpu_identifier : unit -> cpu_info_arm_cpu_identifier 
(** [default_cpu_info_arm_cpu_identifier ()] is a new empty value for type [cpu_info_arm_cpu_identifier] *)

val default_cpu_info_cpu_identifier : unit -> cpu_info_cpu_identifier
(** [default_cpu_info_cpu_identifier ()] is a new empty value for type [cpu_info_cpu_identifier] *)

val default_cpu_info_cpu : unit -> cpu_info_cpu 
(** [default_cpu_info_cpu ()] is a new empty value for type [cpu_info_cpu] *)

val default_cpu_info : unit -> cpu_info 
(** [default_cpu_info ()] is a new empty value for type [cpu_info] *)

val default_test_event_test_payload : unit -> test_event_test_payload 
(** [default_test_event_test_payload ()] is a new empty value for type [test_event_test_payload] *)

val default_test_event : unit -> test_event 
(** [default_test_event ()] is a new empty value for type [test_event] *)

val default_trace_packet_defaults : unit -> trace_packet_defaults 
(** [default_trace_packet_defaults ()] is a new empty value for type [trace_packet_defaults] *)

val default_trace_uuid : unit -> trace_uuid 
(** [default_trace_uuid ()] is a new empty value for type [trace_uuid] *)

val default_process_descriptor_chrome_process_type : unit -> process_descriptor_chrome_process_type
(** [default_process_descriptor_chrome_process_type ()] is a new empty value for type [process_descriptor_chrome_process_type] *)

val default_process_descriptor : unit -> process_descriptor 
(** [default_process_descriptor ()] is a new empty value for type [process_descriptor] *)

val default_track_event_range_of_interest : unit -> track_event_range_of_interest 
(** [default_track_event_range_of_interest ()] is a new empty value for type [track_event_range_of_interest] *)

val default_thread_descriptor_chrome_thread_type : unit -> thread_descriptor_chrome_thread_type
(** [default_thread_descriptor_chrome_thread_type ()] is a new empty value for type [thread_descriptor_chrome_thread_type] *)

val default_thread_descriptor : unit -> thread_descriptor 
(** [default_thread_descriptor ()] is a new empty value for type [thread_descriptor] *)

val default_chrome_process_descriptor : unit -> chrome_process_descriptor 
(** [default_chrome_process_descriptor ()] is a new empty value for type [chrome_process_descriptor] *)

val default_chrome_thread_descriptor : unit -> chrome_thread_descriptor 
(** [default_chrome_thread_descriptor ()] is a new empty value for type [chrome_thread_descriptor] *)

val default_counter_descriptor_builtin_counter_type : unit -> counter_descriptor_builtin_counter_type
(** [default_counter_descriptor_builtin_counter_type ()] is a new empty value for type [counter_descriptor_builtin_counter_type] *)

val default_counter_descriptor_unit : unit -> counter_descriptor_unit
(** [default_counter_descriptor_unit ()] is a new empty value for type [counter_descriptor_unit] *)

val default_counter_descriptor : unit -> counter_descriptor 
(** [default_counter_descriptor ()] is a new empty value for type [counter_descriptor] *)

val default_track_descriptor_child_tracks_ordering : unit -> track_descriptor_child_tracks_ordering
(** [default_track_descriptor_child_tracks_ordering ()] is a new empty value for type [track_descriptor_child_tracks_ordering] *)

val default_track_descriptor_sibling_merge_behavior : unit -> track_descriptor_sibling_merge_behavior
(** [default_track_descriptor_sibling_merge_behavior ()] is a new empty value for type [track_descriptor_sibling_merge_behavior] *)

val default_track_descriptor_static_or_dynamic_name : unit -> track_descriptor_static_or_dynamic_name
(** [default_track_descriptor_static_or_dynamic_name ()] is a new empty value for type [track_descriptor_static_or_dynamic_name] *)

val default_track_descriptor_sibling_merge_key_field : unit -> track_descriptor_sibling_merge_key_field
(** [default_track_descriptor_sibling_merge_key_field ()] is a new empty value for type [track_descriptor_sibling_merge_key_field] *)

val default_track_descriptor : unit -> track_descriptor 
(** [default_track_descriptor ()] is a new empty value for type [track_descriptor] *)

val default_chrome_historgram_translation_table : unit -> chrome_historgram_translation_table 
(** [default_chrome_historgram_translation_table ()] is a new empty value for type [chrome_historgram_translation_table] *)

val default_chrome_user_event_translation_table : unit -> chrome_user_event_translation_table 
(** [default_chrome_user_event_translation_table ()] is a new empty value for type [chrome_user_event_translation_table] *)

val default_chrome_performance_mark_translation_table : unit -> chrome_performance_mark_translation_table 
(** [default_chrome_performance_mark_translation_table ()] is a new empty value for type [chrome_performance_mark_translation_table] *)

val default_slice_name_translation_table : unit -> slice_name_translation_table 
(** [default_slice_name_translation_table ()] is a new empty value for type [slice_name_translation_table] *)

val default_process_track_name_translation_table : unit -> process_track_name_translation_table 
(** [default_process_track_name_translation_table ()] is a new empty value for type [process_track_name_translation_table] *)

val default_chrome_study_translation_table : unit -> chrome_study_translation_table 
(** [default_chrome_study_translation_table ()] is a new empty value for type [chrome_study_translation_table] *)

val default_translation_table : unit -> translation_table
(** [default_translation_table ()] is a new empty value for type [translation_table] *)

val default_trigger : unit -> trigger 
(** [default_trigger ()] is a new empty value for type [trigger] *)

val default_ui_state_highlight_process : unit -> ui_state_highlight_process
(** [default_ui_state_highlight_process ()] is a new empty value for type [ui_state_highlight_process] *)

val default_ui_state : unit -> ui_state 
(** [default_ui_state ()] is a new empty value for type [ui_state] *)

val default_trace_packet_sequence_flags : unit -> trace_packet_sequence_flags
(** [default_trace_packet_sequence_flags ()] is a new empty value for type [trace_packet_sequence_flags] *)

val default_trace_packet_data : unit -> trace_packet_data
(** [default_trace_packet_data ()] is a new empty value for type [trace_packet_data] *)

val default_trace_packet_optional_trusted_uid : unit -> trace_packet_optional_trusted_uid
(** [default_trace_packet_optional_trusted_uid ()] is a new empty value for type [trace_packet_optional_trusted_uid] *)

val default_trace_packet_optional_trusted_packet_sequence_id : unit -> trace_packet_optional_trusted_packet_sequence_id
(** [default_trace_packet_optional_trusted_packet_sequence_id ()] is a new empty value for type [trace_packet_optional_trusted_packet_sequence_id] *)

val default_trace_packet : unit -> trace_packet 
(** [default_trace_packet ()] is a new empty value for type [trace_packet] *)

val default_trace : unit -> trace 
(** [default_trace ()] is a new empty value for type [trace] *)


(** {2 Make functions} *)

val make_ftrace_descriptor_atrace_category : 
  ?name:string ->
  ?description:string ->
  unit ->
  ftrace_descriptor_atrace_category
(** [make_ftrace_descriptor_atrace_category … ()] is a builder for type [ftrace_descriptor_atrace_category] *)

val copy_ftrace_descriptor_atrace_category : ftrace_descriptor_atrace_category -> ftrace_descriptor_atrace_category

val ftrace_descriptor_atrace_category_has_name : ftrace_descriptor_atrace_category -> bool
  (** presence of field "name" in [ftrace_descriptor_atrace_category] *)

val ftrace_descriptor_atrace_category_set_name : ftrace_descriptor_atrace_category -> string -> unit
  (** set field name in ftrace_descriptor_atrace_category *)

val ftrace_descriptor_atrace_category_has_description : ftrace_descriptor_atrace_category -> bool
  (** presence of field "description" in [ftrace_descriptor_atrace_category] *)

val ftrace_descriptor_atrace_category_set_description : ftrace_descriptor_atrace_category -> string -> unit
  (** set field description in ftrace_descriptor_atrace_category *)

val make_ftrace_descriptor : 
  ?atrace_categories:ftrace_descriptor_atrace_category list ->
  unit ->
  ftrace_descriptor
(** [make_ftrace_descriptor … ()] is a builder for type [ftrace_descriptor] *)

val copy_ftrace_descriptor : ftrace_descriptor -> ftrace_descriptor

val ftrace_descriptor_set_atrace_categories : ftrace_descriptor -> ftrace_descriptor_atrace_category list -> unit
  (** set field atrace_categories in ftrace_descriptor *)

val make_gpu_counter_descriptor_gpu_counter_spec : 
  ?counter_id:int32 ->
  ?name:string ->
  ?description:string ->
  ?peak_value:gpu_counter_descriptor_gpu_counter_spec_peak_value ->
  ?numerator_units:gpu_counter_descriptor_measure_unit list ->
  ?denominator_units:gpu_counter_descriptor_measure_unit list ->
  ?select_by_default:bool ->
  ?groups:gpu_counter_descriptor_gpu_counter_group list ->
  unit ->
  gpu_counter_descriptor_gpu_counter_spec
(** [make_gpu_counter_descriptor_gpu_counter_spec … ()] is a builder for type [gpu_counter_descriptor_gpu_counter_spec] *)

val copy_gpu_counter_descriptor_gpu_counter_spec : gpu_counter_descriptor_gpu_counter_spec -> gpu_counter_descriptor_gpu_counter_spec

val gpu_counter_descriptor_gpu_counter_spec_has_counter_id : gpu_counter_descriptor_gpu_counter_spec -> bool
  (** presence of field "counter_id" in [gpu_counter_descriptor_gpu_counter_spec] *)

val gpu_counter_descriptor_gpu_counter_spec_set_counter_id : gpu_counter_descriptor_gpu_counter_spec -> int32 -> unit
  (** set field counter_id in gpu_counter_descriptor_gpu_counter_spec *)

val gpu_counter_descriptor_gpu_counter_spec_has_name : gpu_counter_descriptor_gpu_counter_spec -> bool
  (** presence of field "name" in [gpu_counter_descriptor_gpu_counter_spec] *)

val gpu_counter_descriptor_gpu_counter_spec_set_name : gpu_counter_descriptor_gpu_counter_spec -> string -> unit
  (** set field name in gpu_counter_descriptor_gpu_counter_spec *)

val gpu_counter_descriptor_gpu_counter_spec_has_description : gpu_counter_descriptor_gpu_counter_spec -> bool
  (** presence of field "description" in [gpu_counter_descriptor_gpu_counter_spec] *)

val gpu_counter_descriptor_gpu_counter_spec_set_description : gpu_counter_descriptor_gpu_counter_spec -> string -> unit
  (** set field description in gpu_counter_descriptor_gpu_counter_spec *)

val gpu_counter_descriptor_gpu_counter_spec_set_peak_value : gpu_counter_descriptor_gpu_counter_spec -> gpu_counter_descriptor_gpu_counter_spec_peak_value -> unit
  (** set field peak_value in gpu_counter_descriptor_gpu_counter_spec *)

val gpu_counter_descriptor_gpu_counter_spec_set_numerator_units : gpu_counter_descriptor_gpu_counter_spec -> gpu_counter_descriptor_measure_unit list -> unit
  (** set field numerator_units in gpu_counter_descriptor_gpu_counter_spec *)

val gpu_counter_descriptor_gpu_counter_spec_set_denominator_units : gpu_counter_descriptor_gpu_counter_spec -> gpu_counter_descriptor_measure_unit list -> unit
  (** set field denominator_units in gpu_counter_descriptor_gpu_counter_spec *)

val gpu_counter_descriptor_gpu_counter_spec_has_select_by_default : gpu_counter_descriptor_gpu_counter_spec -> bool
  (** presence of field "select_by_default" in [gpu_counter_descriptor_gpu_counter_spec] *)

val gpu_counter_descriptor_gpu_counter_spec_set_select_by_default : gpu_counter_descriptor_gpu_counter_spec -> bool -> unit
  (** set field select_by_default in gpu_counter_descriptor_gpu_counter_spec *)

val gpu_counter_descriptor_gpu_counter_spec_set_groups : gpu_counter_descriptor_gpu_counter_spec -> gpu_counter_descriptor_gpu_counter_group list -> unit
  (** set field groups in gpu_counter_descriptor_gpu_counter_spec *)

val make_gpu_counter_descriptor_gpu_counter_block : 
  ?block_id:int32 ->
  ?block_capacity:int32 ->
  ?name:string ->
  ?description:string ->
  ?counter_ids:int32 list ->
  unit ->
  gpu_counter_descriptor_gpu_counter_block
(** [make_gpu_counter_descriptor_gpu_counter_block … ()] is a builder for type [gpu_counter_descriptor_gpu_counter_block] *)

val copy_gpu_counter_descriptor_gpu_counter_block : gpu_counter_descriptor_gpu_counter_block -> gpu_counter_descriptor_gpu_counter_block

val gpu_counter_descriptor_gpu_counter_block_has_block_id : gpu_counter_descriptor_gpu_counter_block -> bool
  (** presence of field "block_id" in [gpu_counter_descriptor_gpu_counter_block] *)

val gpu_counter_descriptor_gpu_counter_block_set_block_id : gpu_counter_descriptor_gpu_counter_block -> int32 -> unit
  (** set field block_id in gpu_counter_descriptor_gpu_counter_block *)

val gpu_counter_descriptor_gpu_counter_block_has_block_capacity : gpu_counter_descriptor_gpu_counter_block -> bool
  (** presence of field "block_capacity" in [gpu_counter_descriptor_gpu_counter_block] *)

val gpu_counter_descriptor_gpu_counter_block_set_block_capacity : gpu_counter_descriptor_gpu_counter_block -> int32 -> unit
  (** set field block_capacity in gpu_counter_descriptor_gpu_counter_block *)

val gpu_counter_descriptor_gpu_counter_block_has_name : gpu_counter_descriptor_gpu_counter_block -> bool
  (** presence of field "name" in [gpu_counter_descriptor_gpu_counter_block] *)

val gpu_counter_descriptor_gpu_counter_block_set_name : gpu_counter_descriptor_gpu_counter_block -> string -> unit
  (** set field name in gpu_counter_descriptor_gpu_counter_block *)

val gpu_counter_descriptor_gpu_counter_block_has_description : gpu_counter_descriptor_gpu_counter_block -> bool
  (** presence of field "description" in [gpu_counter_descriptor_gpu_counter_block] *)

val gpu_counter_descriptor_gpu_counter_block_set_description : gpu_counter_descriptor_gpu_counter_block -> string -> unit
  (** set field description in gpu_counter_descriptor_gpu_counter_block *)

val gpu_counter_descriptor_gpu_counter_block_set_counter_ids : gpu_counter_descriptor_gpu_counter_block -> int32 list -> unit
  (** set field counter_ids in gpu_counter_descriptor_gpu_counter_block *)

val make_gpu_counter_descriptor : 
  ?specs:gpu_counter_descriptor_gpu_counter_spec list ->
  ?blocks:gpu_counter_descriptor_gpu_counter_block list ->
  ?min_sampling_period_ns:int64 ->
  ?max_sampling_period_ns:int64 ->
  ?supports_instrumented_sampling:bool ->
  unit ->
  gpu_counter_descriptor
(** [make_gpu_counter_descriptor … ()] is a builder for type [gpu_counter_descriptor] *)

val copy_gpu_counter_descriptor : gpu_counter_descriptor -> gpu_counter_descriptor

val gpu_counter_descriptor_set_specs : gpu_counter_descriptor -> gpu_counter_descriptor_gpu_counter_spec list -> unit
  (** set field specs in gpu_counter_descriptor *)

val gpu_counter_descriptor_set_blocks : gpu_counter_descriptor -> gpu_counter_descriptor_gpu_counter_block list -> unit
  (** set field blocks in gpu_counter_descriptor *)

val gpu_counter_descriptor_has_min_sampling_period_ns : gpu_counter_descriptor -> bool
  (** presence of field "min_sampling_period_ns" in [gpu_counter_descriptor] *)

val gpu_counter_descriptor_set_min_sampling_period_ns : gpu_counter_descriptor -> int64 -> unit
  (** set field min_sampling_period_ns in gpu_counter_descriptor *)

val gpu_counter_descriptor_has_max_sampling_period_ns : gpu_counter_descriptor -> bool
  (** presence of field "max_sampling_period_ns" in [gpu_counter_descriptor] *)

val gpu_counter_descriptor_set_max_sampling_period_ns : gpu_counter_descriptor -> int64 -> unit
  (** set field max_sampling_period_ns in gpu_counter_descriptor *)

val gpu_counter_descriptor_has_supports_instrumented_sampling : gpu_counter_descriptor -> bool
  (** presence of field "supports_instrumented_sampling" in [gpu_counter_descriptor] *)

val gpu_counter_descriptor_set_supports_instrumented_sampling : gpu_counter_descriptor -> bool -> unit
  (** set field supports_instrumented_sampling in gpu_counter_descriptor *)

val make_track_event_category : 
  ?name:string ->
  ?description:string ->
  ?tags:string list ->
  unit ->
  track_event_category
(** [make_track_event_category … ()] is a builder for type [track_event_category] *)

val copy_track_event_category : track_event_category -> track_event_category

val track_event_category_has_name : track_event_category -> bool
  (** presence of field "name" in [track_event_category] *)

val track_event_category_set_name : track_event_category -> string -> unit
  (** set field name in track_event_category *)

val track_event_category_has_description : track_event_category -> bool
  (** presence of field "description" in [track_event_category] *)

val track_event_category_set_description : track_event_category -> string -> unit
  (** set field description in track_event_category *)

val track_event_category_set_tags : track_event_category -> string list -> unit
  (** set field tags in track_event_category *)

val make_track_event_descriptor : 
  ?available_categories:track_event_category list ->
  unit ->
  track_event_descriptor
(** [make_track_event_descriptor … ()] is a builder for type [track_event_descriptor] *)

val copy_track_event_descriptor : track_event_descriptor -> track_event_descriptor

val track_event_descriptor_set_available_categories : track_event_descriptor -> track_event_category list -> unit
  (** set field available_categories in track_event_descriptor *)

val make_data_source_descriptor : 
  ?name:string ->
  ?id:int64 ->
  ?will_notify_on_stop:bool ->
  ?will_notify_on_start:bool ->
  ?handles_incremental_state_clear:bool ->
  ?no_flush:bool ->
  ?gpu_counter_descriptor:gpu_counter_descriptor ->
  ?track_event_descriptor:track_event_descriptor ->
  ?ftrace_descriptor:ftrace_descriptor ->
  unit ->
  data_source_descriptor
(** [make_data_source_descriptor … ()] is a builder for type [data_source_descriptor] *)

val copy_data_source_descriptor : data_source_descriptor -> data_source_descriptor

val data_source_descriptor_has_name : data_source_descriptor -> bool
  (** presence of field "name" in [data_source_descriptor] *)

val data_source_descriptor_set_name : data_source_descriptor -> string -> unit
  (** set field name in data_source_descriptor *)

val data_source_descriptor_has_id : data_source_descriptor -> bool
  (** presence of field "id" in [data_source_descriptor] *)

val data_source_descriptor_set_id : data_source_descriptor -> int64 -> unit
  (** set field id in data_source_descriptor *)

val data_source_descriptor_has_will_notify_on_stop : data_source_descriptor -> bool
  (** presence of field "will_notify_on_stop" in [data_source_descriptor] *)

val data_source_descriptor_set_will_notify_on_stop : data_source_descriptor -> bool -> unit
  (** set field will_notify_on_stop in data_source_descriptor *)

val data_source_descriptor_has_will_notify_on_start : data_source_descriptor -> bool
  (** presence of field "will_notify_on_start" in [data_source_descriptor] *)

val data_source_descriptor_set_will_notify_on_start : data_source_descriptor -> bool -> unit
  (** set field will_notify_on_start in data_source_descriptor *)

val data_source_descriptor_has_handles_incremental_state_clear : data_source_descriptor -> bool
  (** presence of field "handles_incremental_state_clear" in [data_source_descriptor] *)

val data_source_descriptor_set_handles_incremental_state_clear : data_source_descriptor -> bool -> unit
  (** set field handles_incremental_state_clear in data_source_descriptor *)

val data_source_descriptor_has_no_flush : data_source_descriptor -> bool
  (** presence of field "no_flush" in [data_source_descriptor] *)

val data_source_descriptor_set_no_flush : data_source_descriptor -> bool -> unit
  (** set field no_flush in data_source_descriptor *)

val data_source_descriptor_set_gpu_counter_descriptor : data_source_descriptor -> gpu_counter_descriptor -> unit
  (** set field gpu_counter_descriptor in data_source_descriptor *)

val data_source_descriptor_set_track_event_descriptor : data_source_descriptor -> track_event_descriptor -> unit
  (** set field track_event_descriptor in data_source_descriptor *)

val data_source_descriptor_set_ftrace_descriptor : data_source_descriptor -> ftrace_descriptor -> unit
  (** set field ftrace_descriptor in data_source_descriptor *)

val make_tracing_service_state_producer : 
  ?id:int32 ->
  ?name:string ->
  ?pid:int32 ->
  ?uid:int32 ->
  ?sdk_version:string ->
  ?frozen:bool ->
  unit ->
  tracing_service_state_producer
(** [make_tracing_service_state_producer … ()] is a builder for type [tracing_service_state_producer] *)

val copy_tracing_service_state_producer : tracing_service_state_producer -> tracing_service_state_producer

val tracing_service_state_producer_has_id : tracing_service_state_producer -> bool
  (** presence of field "id" in [tracing_service_state_producer] *)

val tracing_service_state_producer_set_id : tracing_service_state_producer -> int32 -> unit
  (** set field id in tracing_service_state_producer *)

val tracing_service_state_producer_has_name : tracing_service_state_producer -> bool
  (** presence of field "name" in [tracing_service_state_producer] *)

val tracing_service_state_producer_set_name : tracing_service_state_producer -> string -> unit
  (** set field name in tracing_service_state_producer *)

val tracing_service_state_producer_has_pid : tracing_service_state_producer -> bool
  (** presence of field "pid" in [tracing_service_state_producer] *)

val tracing_service_state_producer_set_pid : tracing_service_state_producer -> int32 -> unit
  (** set field pid in tracing_service_state_producer *)

val tracing_service_state_producer_has_uid : tracing_service_state_producer -> bool
  (** presence of field "uid" in [tracing_service_state_producer] *)

val tracing_service_state_producer_set_uid : tracing_service_state_producer -> int32 -> unit
  (** set field uid in tracing_service_state_producer *)

val tracing_service_state_producer_has_sdk_version : tracing_service_state_producer -> bool
  (** presence of field "sdk_version" in [tracing_service_state_producer] *)

val tracing_service_state_producer_set_sdk_version : tracing_service_state_producer -> string -> unit
  (** set field sdk_version in tracing_service_state_producer *)

val tracing_service_state_producer_has_frozen : tracing_service_state_producer -> bool
  (** presence of field "frozen" in [tracing_service_state_producer] *)

val tracing_service_state_producer_set_frozen : tracing_service_state_producer -> bool -> unit
  (** set field frozen in tracing_service_state_producer *)

val make_tracing_service_state_data_source : 
  ?ds_descriptor:data_source_descriptor ->
  ?producer_id:int32 ->
  unit ->
  tracing_service_state_data_source
(** [make_tracing_service_state_data_source … ()] is a builder for type [tracing_service_state_data_source] *)

val copy_tracing_service_state_data_source : tracing_service_state_data_source -> tracing_service_state_data_source

val tracing_service_state_data_source_set_ds_descriptor : tracing_service_state_data_source -> data_source_descriptor -> unit
  (** set field ds_descriptor in tracing_service_state_data_source *)

val tracing_service_state_data_source_has_producer_id : tracing_service_state_data_source -> bool
  (** presence of field "producer_id" in [tracing_service_state_data_source] *)

val tracing_service_state_data_source_set_producer_id : tracing_service_state_data_source -> int32 -> unit
  (** set field producer_id in tracing_service_state_data_source *)

val make_tracing_service_state_tracing_session : 
  ?id:int64 ->
  ?consumer_uid:int32 ->
  ?state:string ->
  ?unique_session_name:string ->
  ?buffer_size_kb:int32 list ->
  ?duration_ms:int32 ->
  ?num_data_sources:int32 ->
  ?start_realtime_ns:int64 ->
  ?bugreport_score:int32 ->
  ?bugreport_filename:string ->
  ?is_started:bool ->
  unit ->
  tracing_service_state_tracing_session
(** [make_tracing_service_state_tracing_session … ()] is a builder for type [tracing_service_state_tracing_session] *)

val copy_tracing_service_state_tracing_session : tracing_service_state_tracing_session -> tracing_service_state_tracing_session

val tracing_service_state_tracing_session_has_id : tracing_service_state_tracing_session -> bool
  (** presence of field "id" in [tracing_service_state_tracing_session] *)

val tracing_service_state_tracing_session_set_id : tracing_service_state_tracing_session -> int64 -> unit
  (** set field id in tracing_service_state_tracing_session *)

val tracing_service_state_tracing_session_has_consumer_uid : tracing_service_state_tracing_session -> bool
  (** presence of field "consumer_uid" in [tracing_service_state_tracing_session] *)

val tracing_service_state_tracing_session_set_consumer_uid : tracing_service_state_tracing_session -> int32 -> unit
  (** set field consumer_uid in tracing_service_state_tracing_session *)

val tracing_service_state_tracing_session_has_state : tracing_service_state_tracing_session -> bool
  (** presence of field "state" in [tracing_service_state_tracing_session] *)

val tracing_service_state_tracing_session_set_state : tracing_service_state_tracing_session -> string -> unit
  (** set field state in tracing_service_state_tracing_session *)

val tracing_service_state_tracing_session_has_unique_session_name : tracing_service_state_tracing_session -> bool
  (** presence of field "unique_session_name" in [tracing_service_state_tracing_session] *)

val tracing_service_state_tracing_session_set_unique_session_name : tracing_service_state_tracing_session -> string -> unit
  (** set field unique_session_name in tracing_service_state_tracing_session *)

val tracing_service_state_tracing_session_set_buffer_size_kb : tracing_service_state_tracing_session -> int32 list -> unit
  (** set field buffer_size_kb in tracing_service_state_tracing_session *)

val tracing_service_state_tracing_session_has_duration_ms : tracing_service_state_tracing_session -> bool
  (** presence of field "duration_ms" in [tracing_service_state_tracing_session] *)

val tracing_service_state_tracing_session_set_duration_ms : tracing_service_state_tracing_session -> int32 -> unit
  (** set field duration_ms in tracing_service_state_tracing_session *)

val tracing_service_state_tracing_session_has_num_data_sources : tracing_service_state_tracing_session -> bool
  (** presence of field "num_data_sources" in [tracing_service_state_tracing_session] *)

val tracing_service_state_tracing_session_set_num_data_sources : tracing_service_state_tracing_session -> int32 -> unit
  (** set field num_data_sources in tracing_service_state_tracing_session *)

val tracing_service_state_tracing_session_has_start_realtime_ns : tracing_service_state_tracing_session -> bool
  (** presence of field "start_realtime_ns" in [tracing_service_state_tracing_session] *)

val tracing_service_state_tracing_session_set_start_realtime_ns : tracing_service_state_tracing_session -> int64 -> unit
  (** set field start_realtime_ns in tracing_service_state_tracing_session *)

val tracing_service_state_tracing_session_has_bugreport_score : tracing_service_state_tracing_session -> bool
  (** presence of field "bugreport_score" in [tracing_service_state_tracing_session] *)

val tracing_service_state_tracing_session_set_bugreport_score : tracing_service_state_tracing_session -> int32 -> unit
  (** set field bugreport_score in tracing_service_state_tracing_session *)

val tracing_service_state_tracing_session_has_bugreport_filename : tracing_service_state_tracing_session -> bool
  (** presence of field "bugreport_filename" in [tracing_service_state_tracing_session] *)

val tracing_service_state_tracing_session_set_bugreport_filename : tracing_service_state_tracing_session -> string -> unit
  (** set field bugreport_filename in tracing_service_state_tracing_session *)

val tracing_service_state_tracing_session_has_is_started : tracing_service_state_tracing_session -> bool
  (** presence of field "is_started" in [tracing_service_state_tracing_session] *)

val tracing_service_state_tracing_session_set_is_started : tracing_service_state_tracing_session -> bool -> unit
  (** set field is_started in tracing_service_state_tracing_session *)

val make_tracing_service_state : 
  ?producers:tracing_service_state_producer list ->
  ?data_sources:tracing_service_state_data_source list ->
  ?tracing_sessions:tracing_service_state_tracing_session list ->
  ?supports_tracing_sessions:bool ->
  ?num_sessions:int32 ->
  ?num_sessions_started:int32 ->
  ?tracing_service_version:string ->
  unit ->
  tracing_service_state
(** [make_tracing_service_state … ()] is a builder for type [tracing_service_state] *)

val copy_tracing_service_state : tracing_service_state -> tracing_service_state

val tracing_service_state_set_producers : tracing_service_state -> tracing_service_state_producer list -> unit
  (** set field producers in tracing_service_state *)

val tracing_service_state_set_data_sources : tracing_service_state -> tracing_service_state_data_source list -> unit
  (** set field data_sources in tracing_service_state *)

val tracing_service_state_set_tracing_sessions : tracing_service_state -> tracing_service_state_tracing_session list -> unit
  (** set field tracing_sessions in tracing_service_state *)

val tracing_service_state_has_supports_tracing_sessions : tracing_service_state -> bool
  (** presence of field "supports_tracing_sessions" in [tracing_service_state] *)

val tracing_service_state_set_supports_tracing_sessions : tracing_service_state -> bool -> unit
  (** set field supports_tracing_sessions in tracing_service_state *)

val tracing_service_state_has_num_sessions : tracing_service_state -> bool
  (** presence of field "num_sessions" in [tracing_service_state] *)

val tracing_service_state_set_num_sessions : tracing_service_state -> int32 -> unit
  (** set field num_sessions in tracing_service_state *)

val tracing_service_state_has_num_sessions_started : tracing_service_state -> bool
  (** presence of field "num_sessions_started" in [tracing_service_state] *)

val tracing_service_state_set_num_sessions_started : tracing_service_state -> int32 -> unit
  (** set field num_sessions_started in tracing_service_state *)

val tracing_service_state_has_tracing_service_version : tracing_service_state -> bool
  (** presence of field "tracing_service_version" in [tracing_service_state] *)

val tracing_service_state_set_tracing_service_version : tracing_service_state -> string -> unit
  (** set field tracing_service_version in tracing_service_state *)

val make_android_game_intervention_list_config : 
  ?package_name_filter:string list ->
  unit ->
  android_game_intervention_list_config
(** [make_android_game_intervention_list_config … ()] is a builder for type [android_game_intervention_list_config] *)

val copy_android_game_intervention_list_config : android_game_intervention_list_config -> android_game_intervention_list_config

val android_game_intervention_list_config_set_package_name_filter : android_game_intervention_list_config -> string list -> unit
  (** set field package_name_filter in android_game_intervention_list_config *)

val make_proto_log_group : 
  ?group_name:string ->
  ?log_from:proto_log_level ->
  ?collect_stacktrace:bool ->
  unit ->
  proto_log_group
(** [make_proto_log_group … ()] is a builder for type [proto_log_group] *)

val copy_proto_log_group : proto_log_group -> proto_log_group

val proto_log_group_has_group_name : proto_log_group -> bool
  (** presence of field "group_name" in [proto_log_group] *)

val proto_log_group_set_group_name : proto_log_group -> string -> unit
  (** set field group_name in proto_log_group *)

val proto_log_group_has_log_from : proto_log_group -> bool
  (** presence of field "log_from" in [proto_log_group] *)

val proto_log_group_set_log_from : proto_log_group -> proto_log_level -> unit
  (** set field log_from in proto_log_group *)

val proto_log_group_has_collect_stacktrace : proto_log_group -> bool
  (** presence of field "collect_stacktrace" in [proto_log_group] *)

val proto_log_group_set_collect_stacktrace : proto_log_group -> bool -> unit
  (** set field collect_stacktrace in proto_log_group *)

val make_proto_log_config : 
  ?group_overrides:proto_log_group list ->
  ?tracing_mode:proto_log_config_tracing_mode ->
  ?default_log_from_level:proto_log_level ->
  unit ->
  proto_log_config
(** [make_proto_log_config … ()] is a builder for type [proto_log_config] *)

val copy_proto_log_config : proto_log_config -> proto_log_config

val proto_log_config_set_group_overrides : proto_log_config -> proto_log_group list -> unit
  (** set field group_overrides in proto_log_config *)

val proto_log_config_has_tracing_mode : proto_log_config -> bool
  (** presence of field "tracing_mode" in [proto_log_config] *)

val proto_log_config_set_tracing_mode : proto_log_config -> proto_log_config_tracing_mode -> unit
  (** set field tracing_mode in proto_log_config *)

val proto_log_config_has_default_log_from_level : proto_log_config -> bool
  (** presence of field "default_log_from_level" in [proto_log_config] *)

val proto_log_config_set_default_log_from_level : proto_log_config -> proto_log_level -> unit
  (** set field default_log_from_level in proto_log_config *)

val make_surface_flinger_layers_config : 
  ?mode:surface_flinger_layers_config_mode ->
  ?trace_flags:surface_flinger_layers_config_trace_flag list ->
  unit ->
  surface_flinger_layers_config
(** [make_surface_flinger_layers_config … ()] is a builder for type [surface_flinger_layers_config] *)

val copy_surface_flinger_layers_config : surface_flinger_layers_config -> surface_flinger_layers_config

val surface_flinger_layers_config_has_mode : surface_flinger_layers_config -> bool
  (** presence of field "mode" in [surface_flinger_layers_config] *)

val surface_flinger_layers_config_set_mode : surface_flinger_layers_config -> surface_flinger_layers_config_mode -> unit
  (** set field mode in surface_flinger_layers_config *)

val surface_flinger_layers_config_set_trace_flags : surface_flinger_layers_config -> surface_flinger_layers_config_trace_flag list -> unit
  (** set field trace_flags in surface_flinger_layers_config *)

val make_surface_flinger_transactions_config : 
  ?mode:surface_flinger_transactions_config_mode ->
  unit ->
  surface_flinger_transactions_config
(** [make_surface_flinger_transactions_config … ()] is a builder for type [surface_flinger_transactions_config] *)

val copy_surface_flinger_transactions_config : surface_flinger_transactions_config -> surface_flinger_transactions_config

val surface_flinger_transactions_config_has_mode : surface_flinger_transactions_config -> bool
  (** presence of field "mode" in [surface_flinger_transactions_config] *)

val surface_flinger_transactions_config_set_mode : surface_flinger_transactions_config -> surface_flinger_transactions_config_mode -> unit
  (** set field mode in surface_flinger_transactions_config *)

val make_window_manager_config : 
  ?log_frequency:window_manager_config_log_frequency ->
  ?log_level:window_manager_config_log_level ->
  unit ->
  window_manager_config
(** [make_window_manager_config … ()] is a builder for type [window_manager_config] *)

val copy_window_manager_config : window_manager_config -> window_manager_config

val window_manager_config_has_log_frequency : window_manager_config -> bool
  (** presence of field "log_frequency" in [window_manager_config] *)

val window_manager_config_set_log_frequency : window_manager_config -> window_manager_config_log_frequency -> unit
  (** set field log_frequency in window_manager_config *)

val window_manager_config_has_log_level : window_manager_config -> bool
  (** presence of field "log_level" in [window_manager_config] *)

val window_manager_config_set_log_level : window_manager_config -> window_manager_config_log_level -> unit
  (** set field log_level in window_manager_config *)

val make_chrome_config : 
  ?trace_config:string ->
  ?privacy_filtering_enabled:bool ->
  ?convert_to_legacy_json:bool ->
  ?client_priority:chrome_config_client_priority ->
  ?json_agent_label_filter:string ->
  ?event_package_name_filter_enabled:bool ->
  unit ->
  chrome_config
(** [make_chrome_config … ()] is a builder for type [chrome_config] *)

val copy_chrome_config : chrome_config -> chrome_config

val chrome_config_has_trace_config : chrome_config -> bool
  (** presence of field "trace_config" in [chrome_config] *)

val chrome_config_set_trace_config : chrome_config -> string -> unit
  (** set field trace_config in chrome_config *)

val chrome_config_has_privacy_filtering_enabled : chrome_config -> bool
  (** presence of field "privacy_filtering_enabled" in [chrome_config] *)

val chrome_config_set_privacy_filtering_enabled : chrome_config -> bool -> unit
  (** set field privacy_filtering_enabled in chrome_config *)

val chrome_config_has_convert_to_legacy_json : chrome_config -> bool
  (** presence of field "convert_to_legacy_json" in [chrome_config] *)

val chrome_config_set_convert_to_legacy_json : chrome_config -> bool -> unit
  (** set field convert_to_legacy_json in chrome_config *)

val chrome_config_has_client_priority : chrome_config -> bool
  (** presence of field "client_priority" in [chrome_config] *)

val chrome_config_set_client_priority : chrome_config -> chrome_config_client_priority -> unit
  (** set field client_priority in chrome_config *)

val chrome_config_has_json_agent_label_filter : chrome_config -> bool
  (** presence of field "json_agent_label_filter" in [chrome_config] *)

val chrome_config_set_json_agent_label_filter : chrome_config -> string -> unit
  (** set field json_agent_label_filter in chrome_config *)

val chrome_config_has_event_package_name_filter_enabled : chrome_config -> bool
  (** presence of field "event_package_name_filter_enabled" in [chrome_config] *)

val chrome_config_set_event_package_name_filter_enabled : chrome_config -> bool -> unit
  (** set field event_package_name_filter_enabled in chrome_config *)

val make_chromium_histogram_samples_config_histogram_sample : 
  ?histogram_name:string ->
  ?min_value:int64 ->
  ?max_value:int64 ->
  unit ->
  chromium_histogram_samples_config_histogram_sample
(** [make_chromium_histogram_samples_config_histogram_sample … ()] is a builder for type [chromium_histogram_samples_config_histogram_sample] *)

val copy_chromium_histogram_samples_config_histogram_sample : chromium_histogram_samples_config_histogram_sample -> chromium_histogram_samples_config_histogram_sample

val chromium_histogram_samples_config_histogram_sample_has_histogram_name : chromium_histogram_samples_config_histogram_sample -> bool
  (** presence of field "histogram_name" in [chromium_histogram_samples_config_histogram_sample] *)

val chromium_histogram_samples_config_histogram_sample_set_histogram_name : chromium_histogram_samples_config_histogram_sample -> string -> unit
  (** set field histogram_name in chromium_histogram_samples_config_histogram_sample *)

val chromium_histogram_samples_config_histogram_sample_has_min_value : chromium_histogram_samples_config_histogram_sample -> bool
  (** presence of field "min_value" in [chromium_histogram_samples_config_histogram_sample] *)

val chromium_histogram_samples_config_histogram_sample_set_min_value : chromium_histogram_samples_config_histogram_sample -> int64 -> unit
  (** set field min_value in chromium_histogram_samples_config_histogram_sample *)

val chromium_histogram_samples_config_histogram_sample_has_max_value : chromium_histogram_samples_config_histogram_sample -> bool
  (** presence of field "max_value" in [chromium_histogram_samples_config_histogram_sample] *)

val chromium_histogram_samples_config_histogram_sample_set_max_value : chromium_histogram_samples_config_histogram_sample -> int64 -> unit
  (** set field max_value in chromium_histogram_samples_config_histogram_sample *)

val make_chromium_histogram_samples_config : 
  ?histograms:chromium_histogram_samples_config_histogram_sample list ->
  ?filter_histogram_names:bool ->
  unit ->
  chromium_histogram_samples_config
(** [make_chromium_histogram_samples_config … ()] is a builder for type [chromium_histogram_samples_config] *)

val copy_chromium_histogram_samples_config : chromium_histogram_samples_config -> chromium_histogram_samples_config

val chromium_histogram_samples_config_set_histograms : chromium_histogram_samples_config -> chromium_histogram_samples_config_histogram_sample list -> unit
  (** set field histograms in chromium_histogram_samples_config *)

val chromium_histogram_samples_config_has_filter_histogram_names : chromium_histogram_samples_config -> bool
  (** presence of field "filter_histogram_names" in [chromium_histogram_samples_config] *)

val chromium_histogram_samples_config_set_filter_histogram_names : chromium_histogram_samples_config -> bool -> unit
  (** set field filter_histogram_names in chromium_histogram_samples_config *)

val make_chromium_system_metrics_config : 
  ?sampling_interval_ms:int32 ->
  unit ->
  chromium_system_metrics_config
(** [make_chromium_system_metrics_config … ()] is a builder for type [chromium_system_metrics_config] *)

val copy_chromium_system_metrics_config : chromium_system_metrics_config -> chromium_system_metrics_config

val chromium_system_metrics_config_has_sampling_interval_ms : chromium_system_metrics_config -> bool
  (** presence of field "sampling_interval_ms" in [chromium_system_metrics_config] *)

val chromium_system_metrics_config_set_sampling_interval_ms : chromium_system_metrics_config -> int32 -> unit
  (** set field sampling_interval_ms in chromium_system_metrics_config *)

val make_v8_config : 
  ?log_script_sources:bool ->
  ?log_instructions:bool ->
  unit ->
  v8_config
(** [make_v8_config … ()] is a builder for type [v8_config] *)

val copy_v8_config : v8_config -> v8_config

val v8_config_has_log_script_sources : v8_config -> bool
  (** presence of field "log_script_sources" in [v8_config] *)

val v8_config_set_log_script_sources : v8_config -> bool -> unit
  (** set field log_script_sources in v8_config *)

val v8_config_has_log_instructions : v8_config -> bool
  (** presence of field "log_instructions" in [v8_config] *)

val v8_config_set_log_instructions : v8_config -> bool -> unit
  (** set field log_instructions in v8_config *)

val make_etw_config : 
  ?kernel_flags:etw_config_kernel_flag list ->
  ?scheduler_provider_events:string list ->
  ?memory_provider_events:string list ->
  ?file_provider_events:string list ->
  unit ->
  etw_config
(** [make_etw_config … ()] is a builder for type [etw_config] *)

val copy_etw_config : etw_config -> etw_config

val etw_config_set_kernel_flags : etw_config -> etw_config_kernel_flag list -> unit
  (** set field kernel_flags in etw_config *)

val etw_config_set_scheduler_provider_events : etw_config -> string list -> unit
  (** set field scheduler_provider_events in etw_config *)

val etw_config_set_memory_provider_events : etw_config -> string list -> unit
  (** set field memory_provider_events in etw_config *)

val etw_config_set_file_provider_events : etw_config -> string list -> unit
  (** set field file_provider_events in etw_config *)

val make_frozen_ftrace_config : 
  ?instance_name:string ->
  unit ->
  frozen_ftrace_config
(** [make_frozen_ftrace_config … ()] is a builder for type [frozen_ftrace_config] *)

val copy_frozen_ftrace_config : frozen_ftrace_config -> frozen_ftrace_config

val frozen_ftrace_config_has_instance_name : frozen_ftrace_config -> bool
  (** presence of field "instance_name" in [frozen_ftrace_config] *)

val frozen_ftrace_config_set_instance_name : frozen_ftrace_config -> string -> unit
  (** set field instance_name in frozen_ftrace_config *)

val make_inode_file_config_mount_point_mapping_entry : 
  ?mountpoint:string ->
  ?scan_roots:string list ->
  unit ->
  inode_file_config_mount_point_mapping_entry
(** [make_inode_file_config_mount_point_mapping_entry … ()] is a builder for type [inode_file_config_mount_point_mapping_entry] *)

val copy_inode_file_config_mount_point_mapping_entry : inode_file_config_mount_point_mapping_entry -> inode_file_config_mount_point_mapping_entry

val inode_file_config_mount_point_mapping_entry_has_mountpoint : inode_file_config_mount_point_mapping_entry -> bool
  (** presence of field "mountpoint" in [inode_file_config_mount_point_mapping_entry] *)

val inode_file_config_mount_point_mapping_entry_set_mountpoint : inode_file_config_mount_point_mapping_entry -> string -> unit
  (** set field mountpoint in inode_file_config_mount_point_mapping_entry *)

val inode_file_config_mount_point_mapping_entry_set_scan_roots : inode_file_config_mount_point_mapping_entry -> string list -> unit
  (** set field scan_roots in inode_file_config_mount_point_mapping_entry *)

val make_inode_file_config : 
  ?scan_interval_ms:int32 ->
  ?scan_delay_ms:int32 ->
  ?scan_batch_size:int32 ->
  ?do_not_scan:bool ->
  ?scan_mount_points:string list ->
  ?mount_point_mapping:inode_file_config_mount_point_mapping_entry list ->
  unit ->
  inode_file_config
(** [make_inode_file_config … ()] is a builder for type [inode_file_config] *)

val copy_inode_file_config : inode_file_config -> inode_file_config

val inode_file_config_has_scan_interval_ms : inode_file_config -> bool
  (** presence of field "scan_interval_ms" in [inode_file_config] *)

val inode_file_config_set_scan_interval_ms : inode_file_config -> int32 -> unit
  (** set field scan_interval_ms in inode_file_config *)

val inode_file_config_has_scan_delay_ms : inode_file_config -> bool
  (** presence of field "scan_delay_ms" in [inode_file_config] *)

val inode_file_config_set_scan_delay_ms : inode_file_config -> int32 -> unit
  (** set field scan_delay_ms in inode_file_config *)

val inode_file_config_has_scan_batch_size : inode_file_config -> bool
  (** presence of field "scan_batch_size" in [inode_file_config] *)

val inode_file_config_set_scan_batch_size : inode_file_config -> int32 -> unit
  (** set field scan_batch_size in inode_file_config *)

val inode_file_config_has_do_not_scan : inode_file_config -> bool
  (** presence of field "do_not_scan" in [inode_file_config] *)

val inode_file_config_set_do_not_scan : inode_file_config -> bool -> unit
  (** set field do_not_scan in inode_file_config *)

val inode_file_config_set_scan_mount_points : inode_file_config -> string list -> unit
  (** set field scan_mount_points in inode_file_config *)

val inode_file_config_set_mount_point_mapping : inode_file_config -> inode_file_config_mount_point_mapping_entry list -> unit
  (** set field mount_point_mapping in inode_file_config *)

val make_console_config : 
  ?output:console_config_output ->
  ?enable_colors:bool ->
  unit ->
  console_config
(** [make_console_config … ()] is a builder for type [console_config] *)

val copy_console_config : console_config -> console_config

val console_config_has_output : console_config -> bool
  (** presence of field "output" in [console_config] *)

val console_config_set_output : console_config -> console_config_output -> unit
  (** set field output in console_config *)

val console_config_has_enable_colors : console_config -> bool
  (** presence of field "enable_colors" in [console_config] *)

val console_config_set_enable_colors : console_config -> bool -> unit
  (** set field enable_colors in console_config *)

val make_interceptor_config : 
  ?name:string ->
  ?console_config:console_config ->
  unit ->
  interceptor_config
(** [make_interceptor_config … ()] is a builder for type [interceptor_config] *)

val copy_interceptor_config : interceptor_config -> interceptor_config

val interceptor_config_has_name : interceptor_config -> bool
  (** presence of field "name" in [interceptor_config] *)

val interceptor_config_set_name : interceptor_config -> string -> unit
  (** set field name in interceptor_config *)

val interceptor_config_set_console_config : interceptor_config -> console_config -> unit
  (** set field console_config in interceptor_config *)

val make_android_power_config : 
  ?battery_poll_ms:int32 ->
  ?battery_counters:android_power_config_battery_counters list ->
  ?collect_power_rails:bool ->
  ?collect_energy_estimation_breakdown:bool ->
  ?collect_entity_state_residency:bool ->
  unit ->
  android_power_config
(** [make_android_power_config … ()] is a builder for type [android_power_config] *)

val copy_android_power_config : android_power_config -> android_power_config

val android_power_config_has_battery_poll_ms : android_power_config -> bool
  (** presence of field "battery_poll_ms" in [android_power_config] *)

val android_power_config_set_battery_poll_ms : android_power_config -> int32 -> unit
  (** set field battery_poll_ms in android_power_config *)

val android_power_config_set_battery_counters : android_power_config -> android_power_config_battery_counters list -> unit
  (** set field battery_counters in android_power_config *)

val android_power_config_has_collect_power_rails : android_power_config -> bool
  (** presence of field "collect_power_rails" in [android_power_config] *)

val android_power_config_set_collect_power_rails : android_power_config -> bool -> unit
  (** set field collect_power_rails in android_power_config *)

val android_power_config_has_collect_energy_estimation_breakdown : android_power_config -> bool
  (** presence of field "collect_energy_estimation_breakdown" in [android_power_config] *)

val android_power_config_set_collect_energy_estimation_breakdown : android_power_config -> bool -> unit
  (** set field collect_energy_estimation_breakdown in android_power_config *)

val android_power_config_has_collect_entity_state_residency : android_power_config -> bool
  (** presence of field "collect_entity_state_residency" in [android_power_config] *)

val android_power_config_set_collect_entity_state_residency : android_power_config -> bool -> unit
  (** set field collect_entity_state_residency in android_power_config *)

val make_priority_boost_config : 
  ?policy:priority_boost_config_boost_policy ->
  ?priority:int32 ->
  unit ->
  priority_boost_config
(** [make_priority_boost_config … ()] is a builder for type [priority_boost_config] *)

val copy_priority_boost_config : priority_boost_config -> priority_boost_config

val priority_boost_config_has_policy : priority_boost_config -> bool
  (** presence of field "policy" in [priority_boost_config] *)

val priority_boost_config_set_policy : priority_boost_config -> priority_boost_config_boost_policy -> unit
  (** set field policy in priority_boost_config *)

val priority_boost_config_has_priority : priority_boost_config -> bool
  (** presence of field "priority" in [priority_boost_config] *)

val priority_boost_config_set_priority : priority_boost_config -> int32 -> unit
  (** set field priority in priority_boost_config *)

val make_process_stats_config : 
  ?quirks:process_stats_config_quirks list ->
  ?scan_all_processes_on_start:bool ->
  ?record_thread_names:bool ->
  ?proc_stats_poll_ms:int32 ->
  ?proc_stats_cache_ttl_ms:int32 ->
  ?scan_smaps_rollup:bool ->
  ?record_process_age:bool ->
  ?record_process_runtime:bool ->
  ?record_process_dmabuf_rss:bool ->
  ?resolve_process_fds:bool ->
  unit ->
  process_stats_config
(** [make_process_stats_config … ()] is a builder for type [process_stats_config] *)

val copy_process_stats_config : process_stats_config -> process_stats_config

val process_stats_config_set_quirks : process_stats_config -> process_stats_config_quirks list -> unit
  (** set field quirks in process_stats_config *)

val process_stats_config_has_scan_all_processes_on_start : process_stats_config -> bool
  (** presence of field "scan_all_processes_on_start" in [process_stats_config] *)

val process_stats_config_set_scan_all_processes_on_start : process_stats_config -> bool -> unit
  (** set field scan_all_processes_on_start in process_stats_config *)

val process_stats_config_has_record_thread_names : process_stats_config -> bool
  (** presence of field "record_thread_names" in [process_stats_config] *)

val process_stats_config_set_record_thread_names : process_stats_config -> bool -> unit
  (** set field record_thread_names in process_stats_config *)

val process_stats_config_has_proc_stats_poll_ms : process_stats_config -> bool
  (** presence of field "proc_stats_poll_ms" in [process_stats_config] *)

val process_stats_config_set_proc_stats_poll_ms : process_stats_config -> int32 -> unit
  (** set field proc_stats_poll_ms in process_stats_config *)

val process_stats_config_has_proc_stats_cache_ttl_ms : process_stats_config -> bool
  (** presence of field "proc_stats_cache_ttl_ms" in [process_stats_config] *)

val process_stats_config_set_proc_stats_cache_ttl_ms : process_stats_config -> int32 -> unit
  (** set field proc_stats_cache_ttl_ms in process_stats_config *)

val process_stats_config_has_scan_smaps_rollup : process_stats_config -> bool
  (** presence of field "scan_smaps_rollup" in [process_stats_config] *)

val process_stats_config_set_scan_smaps_rollup : process_stats_config -> bool -> unit
  (** set field scan_smaps_rollup in process_stats_config *)

val process_stats_config_has_record_process_age : process_stats_config -> bool
  (** presence of field "record_process_age" in [process_stats_config] *)

val process_stats_config_set_record_process_age : process_stats_config -> bool -> unit
  (** set field record_process_age in process_stats_config *)

val process_stats_config_has_record_process_runtime : process_stats_config -> bool
  (** presence of field "record_process_runtime" in [process_stats_config] *)

val process_stats_config_set_record_process_runtime : process_stats_config -> bool -> unit
  (** set field record_process_runtime in process_stats_config *)

val process_stats_config_has_record_process_dmabuf_rss : process_stats_config -> bool
  (** presence of field "record_process_dmabuf_rss" in [process_stats_config] *)

val process_stats_config_set_record_process_dmabuf_rss : process_stats_config -> bool -> unit
  (** set field record_process_dmabuf_rss in process_stats_config *)

val process_stats_config_has_resolve_process_fds : process_stats_config -> bool
  (** presence of field "resolve_process_fds" in [process_stats_config] *)

val process_stats_config_set_resolve_process_fds : process_stats_config -> bool -> unit
  (** set field resolve_process_fds in process_stats_config *)

val make_heapprofd_config_continuous_dump_config : 
  ?dump_phase_ms:int32 ->
  ?dump_interval_ms:int32 ->
  unit ->
  heapprofd_config_continuous_dump_config
(** [make_heapprofd_config_continuous_dump_config … ()] is a builder for type [heapprofd_config_continuous_dump_config] *)

val copy_heapprofd_config_continuous_dump_config : heapprofd_config_continuous_dump_config -> heapprofd_config_continuous_dump_config

val heapprofd_config_continuous_dump_config_has_dump_phase_ms : heapprofd_config_continuous_dump_config -> bool
  (** presence of field "dump_phase_ms" in [heapprofd_config_continuous_dump_config] *)

val heapprofd_config_continuous_dump_config_set_dump_phase_ms : heapprofd_config_continuous_dump_config -> int32 -> unit
  (** set field dump_phase_ms in heapprofd_config_continuous_dump_config *)

val heapprofd_config_continuous_dump_config_has_dump_interval_ms : heapprofd_config_continuous_dump_config -> bool
  (** presence of field "dump_interval_ms" in [heapprofd_config_continuous_dump_config] *)

val heapprofd_config_continuous_dump_config_set_dump_interval_ms : heapprofd_config_continuous_dump_config -> int32 -> unit
  (** set field dump_interval_ms in heapprofd_config_continuous_dump_config *)

val make_heapprofd_config : 
  ?sampling_interval_bytes:int64 ->
  ?adaptive_sampling_shmem_threshold:int64 ->
  ?adaptive_sampling_max_sampling_interval_bytes:int64 ->
  ?process_cmdline:string list ->
  ?pid:int64 list ->
  ?target_installed_by:string list ->
  ?heaps:string list ->
  ?exclude_heaps:string list ->
  ?stream_allocations:bool ->
  ?heap_sampling_intervals:int64 list ->
  ?all_heaps:bool ->
  ?all:bool ->
  ?min_anonymous_memory_kb:int32 ->
  ?max_heapprofd_memory_kb:int32 ->
  ?max_heapprofd_cpu_secs:int64 ->
  ?skip_symbol_prefix:string list ->
  ?continuous_dump_config:heapprofd_config_continuous_dump_config ->
  ?shmem_size_bytes:int64 ->
  ?block_client:bool ->
  ?block_client_timeout_us:int32 ->
  ?no_startup:bool ->
  ?no_running:bool ->
  ?dump_at_max:bool ->
  ?disable_fork_teardown:bool ->
  ?disable_vfork_detection:bool ->
  unit ->
  heapprofd_config
(** [make_heapprofd_config … ()] is a builder for type [heapprofd_config] *)

val copy_heapprofd_config : heapprofd_config -> heapprofd_config

val heapprofd_config_has_sampling_interval_bytes : heapprofd_config -> bool
  (** presence of field "sampling_interval_bytes" in [heapprofd_config] *)

val heapprofd_config_set_sampling_interval_bytes : heapprofd_config -> int64 -> unit
  (** set field sampling_interval_bytes in heapprofd_config *)

val heapprofd_config_has_adaptive_sampling_shmem_threshold : heapprofd_config -> bool
  (** presence of field "adaptive_sampling_shmem_threshold" in [heapprofd_config] *)

val heapprofd_config_set_adaptive_sampling_shmem_threshold : heapprofd_config -> int64 -> unit
  (** set field adaptive_sampling_shmem_threshold in heapprofd_config *)

val heapprofd_config_has_adaptive_sampling_max_sampling_interval_bytes : heapprofd_config -> bool
  (** presence of field "adaptive_sampling_max_sampling_interval_bytes" in [heapprofd_config] *)

val heapprofd_config_set_adaptive_sampling_max_sampling_interval_bytes : heapprofd_config -> int64 -> unit
  (** set field adaptive_sampling_max_sampling_interval_bytes in heapprofd_config *)

val heapprofd_config_set_process_cmdline : heapprofd_config -> string list -> unit
  (** set field process_cmdline in heapprofd_config *)

val heapprofd_config_set_pid : heapprofd_config -> int64 list -> unit
  (** set field pid in heapprofd_config *)

val heapprofd_config_set_target_installed_by : heapprofd_config -> string list -> unit
  (** set field target_installed_by in heapprofd_config *)

val heapprofd_config_set_heaps : heapprofd_config -> string list -> unit
  (** set field heaps in heapprofd_config *)

val heapprofd_config_set_exclude_heaps : heapprofd_config -> string list -> unit
  (** set field exclude_heaps in heapprofd_config *)

val heapprofd_config_has_stream_allocations : heapprofd_config -> bool
  (** presence of field "stream_allocations" in [heapprofd_config] *)

val heapprofd_config_set_stream_allocations : heapprofd_config -> bool -> unit
  (** set field stream_allocations in heapprofd_config *)

val heapprofd_config_set_heap_sampling_intervals : heapprofd_config -> int64 list -> unit
  (** set field heap_sampling_intervals in heapprofd_config *)

val heapprofd_config_has_all_heaps : heapprofd_config -> bool
  (** presence of field "all_heaps" in [heapprofd_config] *)

val heapprofd_config_set_all_heaps : heapprofd_config -> bool -> unit
  (** set field all_heaps in heapprofd_config *)

val heapprofd_config_has_all : heapprofd_config -> bool
  (** presence of field "all" in [heapprofd_config] *)

val heapprofd_config_set_all : heapprofd_config -> bool -> unit
  (** set field all in heapprofd_config *)

val heapprofd_config_has_min_anonymous_memory_kb : heapprofd_config -> bool
  (** presence of field "min_anonymous_memory_kb" in [heapprofd_config] *)

val heapprofd_config_set_min_anonymous_memory_kb : heapprofd_config -> int32 -> unit
  (** set field min_anonymous_memory_kb in heapprofd_config *)

val heapprofd_config_has_max_heapprofd_memory_kb : heapprofd_config -> bool
  (** presence of field "max_heapprofd_memory_kb" in [heapprofd_config] *)

val heapprofd_config_set_max_heapprofd_memory_kb : heapprofd_config -> int32 -> unit
  (** set field max_heapprofd_memory_kb in heapprofd_config *)

val heapprofd_config_has_max_heapprofd_cpu_secs : heapprofd_config -> bool
  (** presence of field "max_heapprofd_cpu_secs" in [heapprofd_config] *)

val heapprofd_config_set_max_heapprofd_cpu_secs : heapprofd_config -> int64 -> unit
  (** set field max_heapprofd_cpu_secs in heapprofd_config *)

val heapprofd_config_set_skip_symbol_prefix : heapprofd_config -> string list -> unit
  (** set field skip_symbol_prefix in heapprofd_config *)

val heapprofd_config_set_continuous_dump_config : heapprofd_config -> heapprofd_config_continuous_dump_config -> unit
  (** set field continuous_dump_config in heapprofd_config *)

val heapprofd_config_has_shmem_size_bytes : heapprofd_config -> bool
  (** presence of field "shmem_size_bytes" in [heapprofd_config] *)

val heapprofd_config_set_shmem_size_bytes : heapprofd_config -> int64 -> unit
  (** set field shmem_size_bytes in heapprofd_config *)

val heapprofd_config_has_block_client : heapprofd_config -> bool
  (** presence of field "block_client" in [heapprofd_config] *)

val heapprofd_config_set_block_client : heapprofd_config -> bool -> unit
  (** set field block_client in heapprofd_config *)

val heapprofd_config_has_block_client_timeout_us : heapprofd_config -> bool
  (** presence of field "block_client_timeout_us" in [heapprofd_config] *)

val heapprofd_config_set_block_client_timeout_us : heapprofd_config -> int32 -> unit
  (** set field block_client_timeout_us in heapprofd_config *)

val heapprofd_config_has_no_startup : heapprofd_config -> bool
  (** presence of field "no_startup" in [heapprofd_config] *)

val heapprofd_config_set_no_startup : heapprofd_config -> bool -> unit
  (** set field no_startup in heapprofd_config *)

val heapprofd_config_has_no_running : heapprofd_config -> bool
  (** presence of field "no_running" in [heapprofd_config] *)

val heapprofd_config_set_no_running : heapprofd_config -> bool -> unit
  (** set field no_running in heapprofd_config *)

val heapprofd_config_has_dump_at_max : heapprofd_config -> bool
  (** presence of field "dump_at_max" in [heapprofd_config] *)

val heapprofd_config_set_dump_at_max : heapprofd_config -> bool -> unit
  (** set field dump_at_max in heapprofd_config *)

val heapprofd_config_has_disable_fork_teardown : heapprofd_config -> bool
  (** presence of field "disable_fork_teardown" in [heapprofd_config] *)

val heapprofd_config_set_disable_fork_teardown : heapprofd_config -> bool -> unit
  (** set field disable_fork_teardown in heapprofd_config *)

val heapprofd_config_has_disable_vfork_detection : heapprofd_config -> bool
  (** presence of field "disable_vfork_detection" in [heapprofd_config] *)

val heapprofd_config_set_disable_vfork_detection : heapprofd_config -> bool -> unit
  (** set field disable_vfork_detection in heapprofd_config *)

val make_sys_stats_config : 
  ?meminfo_period_ms:int32 ->
  ?meminfo_counters:meminfo_counters list ->
  ?vmstat_period_ms:int32 ->
  ?vmstat_counters:vmstat_counters list ->
  ?stat_period_ms:int32 ->
  ?stat_counters:sys_stats_config_stat_counters list ->
  ?devfreq_period_ms:int32 ->
  ?cpufreq_period_ms:int32 ->
  ?buddyinfo_period_ms:int32 ->
  ?diskstat_period_ms:int32 ->
  ?psi_period_ms:int32 ->
  ?thermal_period_ms:int32 ->
  ?cpuidle_period_ms:int32 ->
  ?gpufreq_period_ms:int32 ->
  unit ->
  sys_stats_config
(** [make_sys_stats_config … ()] is a builder for type [sys_stats_config] *)

val copy_sys_stats_config : sys_stats_config -> sys_stats_config

val sys_stats_config_has_meminfo_period_ms : sys_stats_config -> bool
  (** presence of field "meminfo_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_meminfo_period_ms : sys_stats_config -> int32 -> unit
  (** set field meminfo_period_ms in sys_stats_config *)

val sys_stats_config_set_meminfo_counters : sys_stats_config -> meminfo_counters list -> unit
  (** set field meminfo_counters in sys_stats_config *)

val sys_stats_config_has_vmstat_period_ms : sys_stats_config -> bool
  (** presence of field "vmstat_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_vmstat_period_ms : sys_stats_config -> int32 -> unit
  (** set field vmstat_period_ms in sys_stats_config *)

val sys_stats_config_set_vmstat_counters : sys_stats_config -> vmstat_counters list -> unit
  (** set field vmstat_counters in sys_stats_config *)

val sys_stats_config_has_stat_period_ms : sys_stats_config -> bool
  (** presence of field "stat_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_stat_period_ms : sys_stats_config -> int32 -> unit
  (** set field stat_period_ms in sys_stats_config *)

val sys_stats_config_set_stat_counters : sys_stats_config -> sys_stats_config_stat_counters list -> unit
  (** set field stat_counters in sys_stats_config *)

val sys_stats_config_has_devfreq_period_ms : sys_stats_config -> bool
  (** presence of field "devfreq_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_devfreq_period_ms : sys_stats_config -> int32 -> unit
  (** set field devfreq_period_ms in sys_stats_config *)

val sys_stats_config_has_cpufreq_period_ms : sys_stats_config -> bool
  (** presence of field "cpufreq_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_cpufreq_period_ms : sys_stats_config -> int32 -> unit
  (** set field cpufreq_period_ms in sys_stats_config *)

val sys_stats_config_has_buddyinfo_period_ms : sys_stats_config -> bool
  (** presence of field "buddyinfo_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_buddyinfo_period_ms : sys_stats_config -> int32 -> unit
  (** set field buddyinfo_period_ms in sys_stats_config *)

val sys_stats_config_has_diskstat_period_ms : sys_stats_config -> bool
  (** presence of field "diskstat_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_diskstat_period_ms : sys_stats_config -> int32 -> unit
  (** set field diskstat_period_ms in sys_stats_config *)

val sys_stats_config_has_psi_period_ms : sys_stats_config -> bool
  (** presence of field "psi_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_psi_period_ms : sys_stats_config -> int32 -> unit
  (** set field psi_period_ms in sys_stats_config *)

val sys_stats_config_has_thermal_period_ms : sys_stats_config -> bool
  (** presence of field "thermal_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_thermal_period_ms : sys_stats_config -> int32 -> unit
  (** set field thermal_period_ms in sys_stats_config *)

val sys_stats_config_has_cpuidle_period_ms : sys_stats_config -> bool
  (** presence of field "cpuidle_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_cpuidle_period_ms : sys_stats_config -> int32 -> unit
  (** set field cpuidle_period_ms in sys_stats_config *)

val sys_stats_config_has_gpufreq_period_ms : sys_stats_config -> bool
  (** presence of field "gpufreq_period_ms" in [sys_stats_config] *)

val sys_stats_config_set_gpufreq_period_ms : sys_stats_config -> int32 -> unit
  (** set field gpufreq_period_ms in sys_stats_config *)

val make_test_config_dummy_fields : 
  ?field_uint32:int32 ->
  ?field_int32:int32 ->
  ?field_uint64:int64 ->
  ?field_int64:int64 ->
  ?field_fixed64:int64 ->
  ?field_sfixed64:int64 ->
  ?field_fixed32:int32 ->
  ?field_sfixed32:int32 ->
  ?field_double:float ->
  ?field_float:float ->
  ?field_sint64:int64 ->
  ?field_sint32:int32 ->
  ?field_string:string ->
  ?field_bytes:bytes ->
  unit ->
  test_config_dummy_fields
(** [make_test_config_dummy_fields … ()] is a builder for type [test_config_dummy_fields] *)

val copy_test_config_dummy_fields : test_config_dummy_fields -> test_config_dummy_fields

val test_config_dummy_fields_has_field_uint32 : test_config_dummy_fields -> bool
  (** presence of field "field_uint32" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_uint32 : test_config_dummy_fields -> int32 -> unit
  (** set field field_uint32 in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_int32 : test_config_dummy_fields -> bool
  (** presence of field "field_int32" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_int32 : test_config_dummy_fields -> int32 -> unit
  (** set field field_int32 in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_uint64 : test_config_dummy_fields -> bool
  (** presence of field "field_uint64" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_uint64 : test_config_dummy_fields -> int64 -> unit
  (** set field field_uint64 in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_int64 : test_config_dummy_fields -> bool
  (** presence of field "field_int64" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_int64 : test_config_dummy_fields -> int64 -> unit
  (** set field field_int64 in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_fixed64 : test_config_dummy_fields -> bool
  (** presence of field "field_fixed64" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_fixed64 : test_config_dummy_fields -> int64 -> unit
  (** set field field_fixed64 in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_sfixed64 : test_config_dummy_fields -> bool
  (** presence of field "field_sfixed64" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_sfixed64 : test_config_dummy_fields -> int64 -> unit
  (** set field field_sfixed64 in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_fixed32 : test_config_dummy_fields -> bool
  (** presence of field "field_fixed32" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_fixed32 : test_config_dummy_fields -> int32 -> unit
  (** set field field_fixed32 in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_sfixed32 : test_config_dummy_fields -> bool
  (** presence of field "field_sfixed32" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_sfixed32 : test_config_dummy_fields -> int32 -> unit
  (** set field field_sfixed32 in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_double : test_config_dummy_fields -> bool
  (** presence of field "field_double" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_double : test_config_dummy_fields -> float -> unit
  (** set field field_double in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_float : test_config_dummy_fields -> bool
  (** presence of field "field_float" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_float : test_config_dummy_fields -> float -> unit
  (** set field field_float in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_sint64 : test_config_dummy_fields -> bool
  (** presence of field "field_sint64" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_sint64 : test_config_dummy_fields -> int64 -> unit
  (** set field field_sint64 in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_sint32 : test_config_dummy_fields -> bool
  (** presence of field "field_sint32" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_sint32 : test_config_dummy_fields -> int32 -> unit
  (** set field field_sint32 in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_string : test_config_dummy_fields -> bool
  (** presence of field "field_string" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_string : test_config_dummy_fields -> string -> unit
  (** set field field_string in test_config_dummy_fields *)

val test_config_dummy_fields_has_field_bytes : test_config_dummy_fields -> bool
  (** presence of field "field_bytes" in [test_config_dummy_fields] *)

val test_config_dummy_fields_set_field_bytes : test_config_dummy_fields -> bytes -> unit
  (** set field field_bytes in test_config_dummy_fields *)

val make_test_config : 
  ?message_count:int32 ->
  ?max_messages_per_second:int32 ->
  ?seed:int32 ->
  ?message_size:int32 ->
  ?send_batch_on_register:bool ->
  ?dummy_fields:test_config_dummy_fields ->
  unit ->
  test_config
(** [make_test_config … ()] is a builder for type [test_config] *)

val copy_test_config : test_config -> test_config

val test_config_has_message_count : test_config -> bool
  (** presence of field "message_count" in [test_config] *)

val test_config_set_message_count : test_config -> int32 -> unit
  (** set field message_count in test_config *)

val test_config_has_max_messages_per_second : test_config -> bool
  (** presence of field "max_messages_per_second" in [test_config] *)

val test_config_set_max_messages_per_second : test_config -> int32 -> unit
  (** set field max_messages_per_second in test_config *)

val test_config_has_seed : test_config -> bool
  (** presence of field "seed" in [test_config] *)

val test_config_set_seed : test_config -> int32 -> unit
  (** set field seed in test_config *)

val test_config_has_message_size : test_config -> bool
  (** presence of field "message_size" in [test_config] *)

val test_config_set_message_size : test_config -> int32 -> unit
  (** set field message_size in test_config *)

val test_config_has_send_batch_on_register : test_config -> bool
  (** presence of field "send_batch_on_register" in [test_config] *)

val test_config_set_send_batch_on_register : test_config -> bool -> unit
  (** set field send_batch_on_register in test_config *)

val test_config_set_dummy_fields : test_config -> test_config_dummy_fields -> unit
  (** set field dummy_fields in test_config *)

val make_track_event_config : 
  ?disabled_categories:string list ->
  ?enabled_categories:string list ->
  ?disabled_tags:string list ->
  ?enabled_tags:string list ->
  ?disable_incremental_timestamps:bool ->
  ?timestamp_unit_multiplier:int64 ->
  ?filter_debug_annotations:bool ->
  ?enable_thread_time_sampling:bool ->
  ?thread_time_subsampling_ns:int64 ->
  ?filter_dynamic_event_names:bool ->
  unit ->
  track_event_config
(** [make_track_event_config … ()] is a builder for type [track_event_config] *)

val copy_track_event_config : track_event_config -> track_event_config

val track_event_config_set_disabled_categories : track_event_config -> string list -> unit
  (** set field disabled_categories in track_event_config *)

val track_event_config_set_enabled_categories : track_event_config -> string list -> unit
  (** set field enabled_categories in track_event_config *)

val track_event_config_set_disabled_tags : track_event_config -> string list -> unit
  (** set field disabled_tags in track_event_config *)

val track_event_config_set_enabled_tags : track_event_config -> string list -> unit
  (** set field enabled_tags in track_event_config *)

val track_event_config_has_disable_incremental_timestamps : track_event_config -> bool
  (** presence of field "disable_incremental_timestamps" in [track_event_config] *)

val track_event_config_set_disable_incremental_timestamps : track_event_config -> bool -> unit
  (** set field disable_incremental_timestamps in track_event_config *)

val track_event_config_has_timestamp_unit_multiplier : track_event_config -> bool
  (** presence of field "timestamp_unit_multiplier" in [track_event_config] *)

val track_event_config_set_timestamp_unit_multiplier : track_event_config -> int64 -> unit
  (** set field timestamp_unit_multiplier in track_event_config *)

val track_event_config_has_filter_debug_annotations : track_event_config -> bool
  (** presence of field "filter_debug_annotations" in [track_event_config] *)

val track_event_config_set_filter_debug_annotations : track_event_config -> bool -> unit
  (** set field filter_debug_annotations in track_event_config *)

val track_event_config_has_enable_thread_time_sampling : track_event_config -> bool
  (** presence of field "enable_thread_time_sampling" in [track_event_config] *)

val track_event_config_set_enable_thread_time_sampling : track_event_config -> bool -> unit
  (** set field enable_thread_time_sampling in track_event_config *)

val track_event_config_has_thread_time_subsampling_ns : track_event_config -> bool
  (** presence of field "thread_time_subsampling_ns" in [track_event_config] *)

val track_event_config_set_thread_time_subsampling_ns : track_event_config -> int64 -> unit
  (** set field thread_time_subsampling_ns in track_event_config *)

val track_event_config_has_filter_dynamic_event_names : track_event_config -> bool
  (** presence of field "filter_dynamic_event_names" in [track_event_config] *)

val track_event_config_set_filter_dynamic_event_names : track_event_config -> bool -> unit
  (** set field filter_dynamic_event_names in track_event_config *)

val make_data_source_config : 
  ?name:string ->
  ?target_buffer:int32 ->
  ?trace_duration_ms:int32 ->
  ?prefer_suspend_clock_for_duration:bool ->
  ?stop_timeout_ms:int32 ->
  ?enable_extra_guardrails:bool ->
  ?session_initiator:data_source_config_session_initiator ->
  ?tracing_session_id:int64 ->
  ?buffer_exhausted_policy:data_source_config_buffer_exhausted_policy ->
  ?priority_boost:priority_boost_config ->
  ?inode_file_config:inode_file_config ->
  ?process_stats_config:process_stats_config ->
  ?sys_stats_config:sys_stats_config ->
  ?heapprofd_config:heapprofd_config ->
  ?android_power_config:android_power_config ->
  ?android_game_intervention_list_config:android_game_intervention_list_config ->
  ?track_event_config:track_event_config ->
  ?system_info_config:unit ->
  ?chrome_config:chrome_config ->
  ?v8_config:v8_config ->
  ?interceptor_config:interceptor_config ->
  ?surfaceflinger_layers_config:surface_flinger_layers_config ->
  ?surfaceflinger_transactions_config:surface_flinger_transactions_config ->
  ?etw_config:etw_config ->
  ?protolog_config:proto_log_config ->
  ?windowmanager_config:window_manager_config ->
  ?chromium_system_metrics:chromium_system_metrics_config ->
  ?chromium_histogram_samples:chromium_histogram_samples_config ->
  ?legacy_config:string ->
  ?for_testing:test_config ->
  unit ->
  data_source_config
(** [make_data_source_config … ()] is a builder for type [data_source_config] *)

val copy_data_source_config : data_source_config -> data_source_config

val data_source_config_has_name : data_source_config -> bool
  (** presence of field "name" in [data_source_config] *)

val data_source_config_set_name : data_source_config -> string -> unit
  (** set field name in data_source_config *)

val data_source_config_has_target_buffer : data_source_config -> bool
  (** presence of field "target_buffer" in [data_source_config] *)

val data_source_config_set_target_buffer : data_source_config -> int32 -> unit
  (** set field target_buffer in data_source_config *)

val data_source_config_has_trace_duration_ms : data_source_config -> bool
  (** presence of field "trace_duration_ms" in [data_source_config] *)

val data_source_config_set_trace_duration_ms : data_source_config -> int32 -> unit
  (** set field trace_duration_ms in data_source_config *)

val data_source_config_has_prefer_suspend_clock_for_duration : data_source_config -> bool
  (** presence of field "prefer_suspend_clock_for_duration" in [data_source_config] *)

val data_source_config_set_prefer_suspend_clock_for_duration : data_source_config -> bool -> unit
  (** set field prefer_suspend_clock_for_duration in data_source_config *)

val data_source_config_has_stop_timeout_ms : data_source_config -> bool
  (** presence of field "stop_timeout_ms" in [data_source_config] *)

val data_source_config_set_stop_timeout_ms : data_source_config -> int32 -> unit
  (** set field stop_timeout_ms in data_source_config *)

val data_source_config_has_enable_extra_guardrails : data_source_config -> bool
  (** presence of field "enable_extra_guardrails" in [data_source_config] *)

val data_source_config_set_enable_extra_guardrails : data_source_config -> bool -> unit
  (** set field enable_extra_guardrails in data_source_config *)

val data_source_config_has_session_initiator : data_source_config -> bool
  (** presence of field "session_initiator" in [data_source_config] *)

val data_source_config_set_session_initiator : data_source_config -> data_source_config_session_initiator -> unit
  (** set field session_initiator in data_source_config *)

val data_source_config_has_tracing_session_id : data_source_config -> bool
  (** presence of field "tracing_session_id" in [data_source_config] *)

val data_source_config_set_tracing_session_id : data_source_config -> int64 -> unit
  (** set field tracing_session_id in data_source_config *)

val data_source_config_has_buffer_exhausted_policy : data_source_config -> bool
  (** presence of field "buffer_exhausted_policy" in [data_source_config] *)

val data_source_config_set_buffer_exhausted_policy : data_source_config -> data_source_config_buffer_exhausted_policy -> unit
  (** set field buffer_exhausted_policy in data_source_config *)

val data_source_config_set_priority_boost : data_source_config -> priority_boost_config -> unit
  (** set field priority_boost in data_source_config *)

val data_source_config_set_inode_file_config : data_source_config -> inode_file_config -> unit
  (** set field inode_file_config in data_source_config *)

val data_source_config_set_process_stats_config : data_source_config -> process_stats_config -> unit
  (** set field process_stats_config in data_source_config *)

val data_source_config_set_sys_stats_config : data_source_config -> sys_stats_config -> unit
  (** set field sys_stats_config in data_source_config *)

val data_source_config_set_heapprofd_config : data_source_config -> heapprofd_config -> unit
  (** set field heapprofd_config in data_source_config *)

val data_source_config_set_android_power_config : data_source_config -> android_power_config -> unit
  (** set field android_power_config in data_source_config *)

val data_source_config_set_android_game_intervention_list_config : data_source_config -> android_game_intervention_list_config -> unit
  (** set field android_game_intervention_list_config in data_source_config *)

val data_source_config_set_track_event_config : data_source_config -> track_event_config -> unit
  (** set field track_event_config in data_source_config *)

val data_source_config_has_system_info_config : data_source_config -> bool
  (** presence of field "system_info_config" in [data_source_config] *)

val data_source_config_set_system_info_config : data_source_config -> unit -> unit
  (** set field system_info_config in data_source_config *)

val data_source_config_set_chrome_config : data_source_config -> chrome_config -> unit
  (** set field chrome_config in data_source_config *)

val data_source_config_set_v8_config : data_source_config -> v8_config -> unit
  (** set field v8_config in data_source_config *)

val data_source_config_set_interceptor_config : data_source_config -> interceptor_config -> unit
  (** set field interceptor_config in data_source_config *)

val data_source_config_set_surfaceflinger_layers_config : data_source_config -> surface_flinger_layers_config -> unit
  (** set field surfaceflinger_layers_config in data_source_config *)

val data_source_config_set_surfaceflinger_transactions_config : data_source_config -> surface_flinger_transactions_config -> unit
  (** set field surfaceflinger_transactions_config in data_source_config *)

val data_source_config_set_etw_config : data_source_config -> etw_config -> unit
  (** set field etw_config in data_source_config *)

val data_source_config_set_protolog_config : data_source_config -> proto_log_config -> unit
  (** set field protolog_config in data_source_config *)

val data_source_config_set_windowmanager_config : data_source_config -> window_manager_config -> unit
  (** set field windowmanager_config in data_source_config *)

val data_source_config_set_chromium_system_metrics : data_source_config -> chromium_system_metrics_config -> unit
  (** set field chromium_system_metrics in data_source_config *)

val data_source_config_set_chromium_histogram_samples : data_source_config -> chromium_histogram_samples_config -> unit
  (** set field chromium_histogram_samples in data_source_config *)

val data_source_config_has_legacy_config : data_source_config -> bool
  (** presence of field "legacy_config" in [data_source_config] *)

val data_source_config_set_legacy_config : data_source_config -> string -> unit
  (** set field legacy_config in data_source_config *)

val data_source_config_set_for_testing : data_source_config -> test_config -> unit
  (** set field for_testing in data_source_config *)

val make_trace_config_buffer_config : 
  ?size_kb:int32 ->
  ?fill_policy:trace_config_buffer_config_fill_policy ->
  ?transfer_on_clone:bool ->
  ?clear_before_clone:bool ->
  unit ->
  trace_config_buffer_config
(** [make_trace_config_buffer_config … ()] is a builder for type [trace_config_buffer_config] *)

val copy_trace_config_buffer_config : trace_config_buffer_config -> trace_config_buffer_config

val trace_config_buffer_config_has_size_kb : trace_config_buffer_config -> bool
  (** presence of field "size_kb" in [trace_config_buffer_config] *)

val trace_config_buffer_config_set_size_kb : trace_config_buffer_config -> int32 -> unit
  (** set field size_kb in trace_config_buffer_config *)

val trace_config_buffer_config_has_fill_policy : trace_config_buffer_config -> bool
  (** presence of field "fill_policy" in [trace_config_buffer_config] *)

val trace_config_buffer_config_set_fill_policy : trace_config_buffer_config -> trace_config_buffer_config_fill_policy -> unit
  (** set field fill_policy in trace_config_buffer_config *)

val trace_config_buffer_config_has_transfer_on_clone : trace_config_buffer_config -> bool
  (** presence of field "transfer_on_clone" in [trace_config_buffer_config] *)

val trace_config_buffer_config_set_transfer_on_clone : trace_config_buffer_config -> bool -> unit
  (** set field transfer_on_clone in trace_config_buffer_config *)

val trace_config_buffer_config_has_clear_before_clone : trace_config_buffer_config -> bool
  (** presence of field "clear_before_clone" in [trace_config_buffer_config] *)

val trace_config_buffer_config_set_clear_before_clone : trace_config_buffer_config -> bool -> unit
  (** set field clear_before_clone in trace_config_buffer_config *)

val make_trace_config_data_source : 
  ?config:data_source_config ->
  ?producer_name_filter:string list ->
  ?producer_name_regex_filter:string list ->
  ?machine_name_filter:string list ->
  unit ->
  trace_config_data_source
(** [make_trace_config_data_source … ()] is a builder for type [trace_config_data_source] *)

val copy_trace_config_data_source : trace_config_data_source -> trace_config_data_source

val trace_config_data_source_set_config : trace_config_data_source -> data_source_config -> unit
  (** set field config in trace_config_data_source *)

val trace_config_data_source_set_producer_name_filter : trace_config_data_source -> string list -> unit
  (** set field producer_name_filter in trace_config_data_source *)

val trace_config_data_source_set_producer_name_regex_filter : trace_config_data_source -> string list -> unit
  (** set field producer_name_regex_filter in trace_config_data_source *)

val trace_config_data_source_set_machine_name_filter : trace_config_data_source -> string list -> unit
  (** set field machine_name_filter in trace_config_data_source *)

val make_trace_config_builtin_data_source : 
  ?disable_clock_snapshotting:bool ->
  ?disable_trace_config:bool ->
  ?disable_system_info:bool ->
  ?disable_service_events:bool ->
  ?primary_trace_clock:builtin_clock ->
  ?snapshot_interval_ms:int32 ->
  ?prefer_suspend_clock_for_snapshot:bool ->
  ?disable_chunk_usage_histograms:bool ->
  unit ->
  trace_config_builtin_data_source
(** [make_trace_config_builtin_data_source … ()] is a builder for type [trace_config_builtin_data_source] *)

val copy_trace_config_builtin_data_source : trace_config_builtin_data_source -> trace_config_builtin_data_source

val trace_config_builtin_data_source_has_disable_clock_snapshotting : trace_config_builtin_data_source -> bool
  (** presence of field "disable_clock_snapshotting" in [trace_config_builtin_data_source] *)

val trace_config_builtin_data_source_set_disable_clock_snapshotting : trace_config_builtin_data_source -> bool -> unit
  (** set field disable_clock_snapshotting in trace_config_builtin_data_source *)

val trace_config_builtin_data_source_has_disable_trace_config : trace_config_builtin_data_source -> bool
  (** presence of field "disable_trace_config" in [trace_config_builtin_data_source] *)

val trace_config_builtin_data_source_set_disable_trace_config : trace_config_builtin_data_source -> bool -> unit
  (** set field disable_trace_config in trace_config_builtin_data_source *)

val trace_config_builtin_data_source_has_disable_system_info : trace_config_builtin_data_source -> bool
  (** presence of field "disable_system_info" in [trace_config_builtin_data_source] *)

val trace_config_builtin_data_source_set_disable_system_info : trace_config_builtin_data_source -> bool -> unit
  (** set field disable_system_info in trace_config_builtin_data_source *)

val trace_config_builtin_data_source_has_disable_service_events : trace_config_builtin_data_source -> bool
  (** presence of field "disable_service_events" in [trace_config_builtin_data_source] *)

val trace_config_builtin_data_source_set_disable_service_events : trace_config_builtin_data_source -> bool -> unit
  (** set field disable_service_events in trace_config_builtin_data_source *)

val trace_config_builtin_data_source_has_primary_trace_clock : trace_config_builtin_data_source -> bool
  (** presence of field "primary_trace_clock" in [trace_config_builtin_data_source] *)

val trace_config_builtin_data_source_set_primary_trace_clock : trace_config_builtin_data_source -> builtin_clock -> unit
  (** set field primary_trace_clock in trace_config_builtin_data_source *)

val trace_config_builtin_data_source_has_snapshot_interval_ms : trace_config_builtin_data_source -> bool
  (** presence of field "snapshot_interval_ms" in [trace_config_builtin_data_source] *)

val trace_config_builtin_data_source_set_snapshot_interval_ms : trace_config_builtin_data_source -> int32 -> unit
  (** set field snapshot_interval_ms in trace_config_builtin_data_source *)

val trace_config_builtin_data_source_has_prefer_suspend_clock_for_snapshot : trace_config_builtin_data_source -> bool
  (** presence of field "prefer_suspend_clock_for_snapshot" in [trace_config_builtin_data_source] *)

val trace_config_builtin_data_source_set_prefer_suspend_clock_for_snapshot : trace_config_builtin_data_source -> bool -> unit
  (** set field prefer_suspend_clock_for_snapshot in trace_config_builtin_data_source *)

val trace_config_builtin_data_source_has_disable_chunk_usage_histograms : trace_config_builtin_data_source -> bool
  (** presence of field "disable_chunk_usage_histograms" in [trace_config_builtin_data_source] *)

val trace_config_builtin_data_source_set_disable_chunk_usage_histograms : trace_config_builtin_data_source -> bool -> unit
  (** set field disable_chunk_usage_histograms in trace_config_builtin_data_source *)

val make_trace_config_producer_config : 
  ?producer_name:string ->
  ?shm_size_kb:int32 ->
  ?page_size_kb:int32 ->
  unit ->
  trace_config_producer_config
(** [make_trace_config_producer_config … ()] is a builder for type [trace_config_producer_config] *)

val copy_trace_config_producer_config : trace_config_producer_config -> trace_config_producer_config

val trace_config_producer_config_has_producer_name : trace_config_producer_config -> bool
  (** presence of field "producer_name" in [trace_config_producer_config] *)

val trace_config_producer_config_set_producer_name : trace_config_producer_config -> string -> unit
  (** set field producer_name in trace_config_producer_config *)

val trace_config_producer_config_has_shm_size_kb : trace_config_producer_config -> bool
  (** presence of field "shm_size_kb" in [trace_config_producer_config] *)

val trace_config_producer_config_set_shm_size_kb : trace_config_producer_config -> int32 -> unit
  (** set field shm_size_kb in trace_config_producer_config *)

val trace_config_producer_config_has_page_size_kb : trace_config_producer_config -> bool
  (** presence of field "page_size_kb" in [trace_config_producer_config] *)

val trace_config_producer_config_set_page_size_kb : trace_config_producer_config -> int32 -> unit
  (** set field page_size_kb in trace_config_producer_config *)

val make_trace_config_statsd_metadata : 
  ?triggering_alert_id:int64 ->
  ?triggering_config_uid:int32 ->
  ?triggering_config_id:int64 ->
  ?triggering_subscription_id:int64 ->
  unit ->
  trace_config_statsd_metadata
(** [make_trace_config_statsd_metadata … ()] is a builder for type [trace_config_statsd_metadata] *)

val copy_trace_config_statsd_metadata : trace_config_statsd_metadata -> trace_config_statsd_metadata

val trace_config_statsd_metadata_has_triggering_alert_id : trace_config_statsd_metadata -> bool
  (** presence of field "triggering_alert_id" in [trace_config_statsd_metadata] *)

val trace_config_statsd_metadata_set_triggering_alert_id : trace_config_statsd_metadata -> int64 -> unit
  (** set field triggering_alert_id in trace_config_statsd_metadata *)

val trace_config_statsd_metadata_has_triggering_config_uid : trace_config_statsd_metadata -> bool
  (** presence of field "triggering_config_uid" in [trace_config_statsd_metadata] *)

val trace_config_statsd_metadata_set_triggering_config_uid : trace_config_statsd_metadata -> int32 -> unit
  (** set field triggering_config_uid in trace_config_statsd_metadata *)

val trace_config_statsd_metadata_has_triggering_config_id : trace_config_statsd_metadata -> bool
  (** presence of field "triggering_config_id" in [trace_config_statsd_metadata] *)

val trace_config_statsd_metadata_set_triggering_config_id : trace_config_statsd_metadata -> int64 -> unit
  (** set field triggering_config_id in trace_config_statsd_metadata *)

val trace_config_statsd_metadata_has_triggering_subscription_id : trace_config_statsd_metadata -> bool
  (** presence of field "triggering_subscription_id" in [trace_config_statsd_metadata] *)

val trace_config_statsd_metadata_set_triggering_subscription_id : trace_config_statsd_metadata -> int64 -> unit
  (** set field triggering_subscription_id in trace_config_statsd_metadata *)

val make_trace_config_guardrail_overrides : 
  ?max_upload_per_day_bytes:int64 ->
  ?max_tracing_buffer_size_kb:int32 ->
  unit ->
  trace_config_guardrail_overrides
(** [make_trace_config_guardrail_overrides … ()] is a builder for type [trace_config_guardrail_overrides] *)

val copy_trace_config_guardrail_overrides : trace_config_guardrail_overrides -> trace_config_guardrail_overrides

val trace_config_guardrail_overrides_has_max_upload_per_day_bytes : trace_config_guardrail_overrides -> bool
  (** presence of field "max_upload_per_day_bytes" in [trace_config_guardrail_overrides] *)

val trace_config_guardrail_overrides_set_max_upload_per_day_bytes : trace_config_guardrail_overrides -> int64 -> unit
  (** set field max_upload_per_day_bytes in trace_config_guardrail_overrides *)

val trace_config_guardrail_overrides_has_max_tracing_buffer_size_kb : trace_config_guardrail_overrides -> bool
  (** presence of field "max_tracing_buffer_size_kb" in [trace_config_guardrail_overrides] *)

val trace_config_guardrail_overrides_set_max_tracing_buffer_size_kb : trace_config_guardrail_overrides -> int32 -> unit
  (** set field max_tracing_buffer_size_kb in trace_config_guardrail_overrides *)

val make_trace_config_trigger_config_trigger : 
  ?name:string ->
  ?producer_name_regex:string ->
  ?stop_delay_ms:int32 ->
  ?max_per_24_h:int32 ->
  ?skip_probability:float ->
  unit ->
  trace_config_trigger_config_trigger
(** [make_trace_config_trigger_config_trigger … ()] is a builder for type [trace_config_trigger_config_trigger] *)

val copy_trace_config_trigger_config_trigger : trace_config_trigger_config_trigger -> trace_config_trigger_config_trigger

val trace_config_trigger_config_trigger_has_name : trace_config_trigger_config_trigger -> bool
  (** presence of field "name" in [trace_config_trigger_config_trigger] *)

val trace_config_trigger_config_trigger_set_name : trace_config_trigger_config_trigger -> string -> unit
  (** set field name in trace_config_trigger_config_trigger *)

val trace_config_trigger_config_trigger_has_producer_name_regex : trace_config_trigger_config_trigger -> bool
  (** presence of field "producer_name_regex" in [trace_config_trigger_config_trigger] *)

val trace_config_trigger_config_trigger_set_producer_name_regex : trace_config_trigger_config_trigger -> string -> unit
  (** set field producer_name_regex in trace_config_trigger_config_trigger *)

val trace_config_trigger_config_trigger_has_stop_delay_ms : trace_config_trigger_config_trigger -> bool
  (** presence of field "stop_delay_ms" in [trace_config_trigger_config_trigger] *)

val trace_config_trigger_config_trigger_set_stop_delay_ms : trace_config_trigger_config_trigger -> int32 -> unit
  (** set field stop_delay_ms in trace_config_trigger_config_trigger *)

val trace_config_trigger_config_trigger_has_max_per_24_h : trace_config_trigger_config_trigger -> bool
  (** presence of field "max_per_24_h" in [trace_config_trigger_config_trigger] *)

val trace_config_trigger_config_trigger_set_max_per_24_h : trace_config_trigger_config_trigger -> int32 -> unit
  (** set field max_per_24_h in trace_config_trigger_config_trigger *)

val trace_config_trigger_config_trigger_has_skip_probability : trace_config_trigger_config_trigger -> bool
  (** presence of field "skip_probability" in [trace_config_trigger_config_trigger] *)

val trace_config_trigger_config_trigger_set_skip_probability : trace_config_trigger_config_trigger -> float -> unit
  (** set field skip_probability in trace_config_trigger_config_trigger *)

val make_trace_config_trigger_config : 
  ?trigger_mode:trace_config_trigger_config_trigger_mode ->
  ?use_clone_snapshot_if_available:bool ->
  ?triggers:trace_config_trigger_config_trigger list ->
  ?trigger_timeout_ms:int32 ->
  unit ->
  trace_config_trigger_config
(** [make_trace_config_trigger_config … ()] is a builder for type [trace_config_trigger_config] *)

val copy_trace_config_trigger_config : trace_config_trigger_config -> trace_config_trigger_config

val trace_config_trigger_config_has_trigger_mode : trace_config_trigger_config -> bool
  (** presence of field "trigger_mode" in [trace_config_trigger_config] *)

val trace_config_trigger_config_set_trigger_mode : trace_config_trigger_config -> trace_config_trigger_config_trigger_mode -> unit
  (** set field trigger_mode in trace_config_trigger_config *)

val trace_config_trigger_config_has_use_clone_snapshot_if_available : trace_config_trigger_config -> bool
  (** presence of field "use_clone_snapshot_if_available" in [trace_config_trigger_config] *)

val trace_config_trigger_config_set_use_clone_snapshot_if_available : trace_config_trigger_config -> bool -> unit
  (** set field use_clone_snapshot_if_available in trace_config_trigger_config *)

val trace_config_trigger_config_set_triggers : trace_config_trigger_config -> trace_config_trigger_config_trigger list -> unit
  (** set field triggers in trace_config_trigger_config *)

val trace_config_trigger_config_has_trigger_timeout_ms : trace_config_trigger_config -> bool
  (** presence of field "trigger_timeout_ms" in [trace_config_trigger_config] *)

val trace_config_trigger_config_set_trigger_timeout_ms : trace_config_trigger_config -> int32 -> unit
  (** set field trigger_timeout_ms in trace_config_trigger_config *)

val make_trace_config_incremental_state_config : 
  ?clear_period_ms:int32 ->
  unit ->
  trace_config_incremental_state_config
(** [make_trace_config_incremental_state_config … ()] is a builder for type [trace_config_incremental_state_config] *)

val copy_trace_config_incremental_state_config : trace_config_incremental_state_config -> trace_config_incremental_state_config

val trace_config_incremental_state_config_has_clear_period_ms : trace_config_incremental_state_config -> bool
  (** presence of field "clear_period_ms" in [trace_config_incremental_state_config] *)

val trace_config_incremental_state_config_set_clear_period_ms : trace_config_incremental_state_config -> int32 -> unit
  (** set field clear_period_ms in trace_config_incremental_state_config *)

val make_trace_config_incident_report_config : 
  ?destination_package:string ->
  ?destination_class:string ->
  ?privacy_level:int32 ->
  ?skip_incidentd:bool ->
  ?skip_dropbox:bool ->
  unit ->
  trace_config_incident_report_config
(** [make_trace_config_incident_report_config … ()] is a builder for type [trace_config_incident_report_config] *)

val copy_trace_config_incident_report_config : trace_config_incident_report_config -> trace_config_incident_report_config

val trace_config_incident_report_config_has_destination_package : trace_config_incident_report_config -> bool
  (** presence of field "destination_package" in [trace_config_incident_report_config] *)

val trace_config_incident_report_config_set_destination_package : trace_config_incident_report_config -> string -> unit
  (** set field destination_package in trace_config_incident_report_config *)

val trace_config_incident_report_config_has_destination_class : trace_config_incident_report_config -> bool
  (** presence of field "destination_class" in [trace_config_incident_report_config] *)

val trace_config_incident_report_config_set_destination_class : trace_config_incident_report_config -> string -> unit
  (** set field destination_class in trace_config_incident_report_config *)

val trace_config_incident_report_config_has_privacy_level : trace_config_incident_report_config -> bool
  (** presence of field "privacy_level" in [trace_config_incident_report_config] *)

val trace_config_incident_report_config_set_privacy_level : trace_config_incident_report_config -> int32 -> unit
  (** set field privacy_level in trace_config_incident_report_config *)

val trace_config_incident_report_config_has_skip_incidentd : trace_config_incident_report_config -> bool
  (** presence of field "skip_incidentd" in [trace_config_incident_report_config] *)

val trace_config_incident_report_config_set_skip_incidentd : trace_config_incident_report_config -> bool -> unit
  (** set field skip_incidentd in trace_config_incident_report_config *)

val trace_config_incident_report_config_has_skip_dropbox : trace_config_incident_report_config -> bool
  (** presence of field "skip_dropbox" in [trace_config_incident_report_config] *)

val trace_config_incident_report_config_set_skip_dropbox : trace_config_incident_report_config -> bool -> unit
  (** set field skip_dropbox in trace_config_incident_report_config *)

val make_trace_config_trace_filter_string_filter_rule : 
  ?policy:trace_config_trace_filter_string_filter_policy ->
  ?regex_pattern:string ->
  ?atrace_payload_starts_with:string ->
  unit ->
  trace_config_trace_filter_string_filter_rule
(** [make_trace_config_trace_filter_string_filter_rule … ()] is a builder for type [trace_config_trace_filter_string_filter_rule] *)

val copy_trace_config_trace_filter_string_filter_rule : trace_config_trace_filter_string_filter_rule -> trace_config_trace_filter_string_filter_rule

val trace_config_trace_filter_string_filter_rule_has_policy : trace_config_trace_filter_string_filter_rule -> bool
  (** presence of field "policy" in [trace_config_trace_filter_string_filter_rule] *)

val trace_config_trace_filter_string_filter_rule_set_policy : trace_config_trace_filter_string_filter_rule -> trace_config_trace_filter_string_filter_policy -> unit
  (** set field policy in trace_config_trace_filter_string_filter_rule *)

val trace_config_trace_filter_string_filter_rule_has_regex_pattern : trace_config_trace_filter_string_filter_rule -> bool
  (** presence of field "regex_pattern" in [trace_config_trace_filter_string_filter_rule] *)

val trace_config_trace_filter_string_filter_rule_set_regex_pattern : trace_config_trace_filter_string_filter_rule -> string -> unit
  (** set field regex_pattern in trace_config_trace_filter_string_filter_rule *)

val trace_config_trace_filter_string_filter_rule_has_atrace_payload_starts_with : trace_config_trace_filter_string_filter_rule -> bool
  (** presence of field "atrace_payload_starts_with" in [trace_config_trace_filter_string_filter_rule] *)

val trace_config_trace_filter_string_filter_rule_set_atrace_payload_starts_with : trace_config_trace_filter_string_filter_rule -> string -> unit
  (** set field atrace_payload_starts_with in trace_config_trace_filter_string_filter_rule *)

val make_trace_config_trace_filter_string_filter_chain : 
  ?rules:trace_config_trace_filter_string_filter_rule list ->
  unit ->
  trace_config_trace_filter_string_filter_chain
(** [make_trace_config_trace_filter_string_filter_chain … ()] is a builder for type [trace_config_trace_filter_string_filter_chain] *)

val copy_trace_config_trace_filter_string_filter_chain : trace_config_trace_filter_string_filter_chain -> trace_config_trace_filter_string_filter_chain

val trace_config_trace_filter_string_filter_chain_set_rules : trace_config_trace_filter_string_filter_chain -> trace_config_trace_filter_string_filter_rule list -> unit
  (** set field rules in trace_config_trace_filter_string_filter_chain *)

val make_trace_config_trace_filter : 
  ?bytecode:bytes ->
  ?bytecode_v2:bytes ->
  ?string_filter_chain:trace_config_trace_filter_string_filter_chain ->
  unit ->
  trace_config_trace_filter
(** [make_trace_config_trace_filter … ()] is a builder for type [trace_config_trace_filter] *)

val copy_trace_config_trace_filter : trace_config_trace_filter -> trace_config_trace_filter

val trace_config_trace_filter_has_bytecode : trace_config_trace_filter -> bool
  (** presence of field "bytecode" in [trace_config_trace_filter] *)

val trace_config_trace_filter_set_bytecode : trace_config_trace_filter -> bytes -> unit
  (** set field bytecode in trace_config_trace_filter *)

val trace_config_trace_filter_has_bytecode_v2 : trace_config_trace_filter -> bool
  (** presence of field "bytecode_v2" in [trace_config_trace_filter] *)

val trace_config_trace_filter_set_bytecode_v2 : trace_config_trace_filter -> bytes -> unit
  (** set field bytecode_v2 in trace_config_trace_filter *)

val trace_config_trace_filter_set_string_filter_chain : trace_config_trace_filter -> trace_config_trace_filter_string_filter_chain -> unit
  (** set field string_filter_chain in trace_config_trace_filter *)

val make_trace_config_android_report_config : 
  ?reporter_service_package:string ->
  ?reporter_service_class:string ->
  ?skip_report:bool ->
  ?use_pipe_in_framework_for_testing:bool ->
  unit ->
  trace_config_android_report_config
(** [make_trace_config_android_report_config … ()] is a builder for type [trace_config_android_report_config] *)

val copy_trace_config_android_report_config : trace_config_android_report_config -> trace_config_android_report_config

val trace_config_android_report_config_has_reporter_service_package : trace_config_android_report_config -> bool
  (** presence of field "reporter_service_package" in [trace_config_android_report_config] *)

val trace_config_android_report_config_set_reporter_service_package : trace_config_android_report_config -> string -> unit
  (** set field reporter_service_package in trace_config_android_report_config *)

val trace_config_android_report_config_has_reporter_service_class : trace_config_android_report_config -> bool
  (** presence of field "reporter_service_class" in [trace_config_android_report_config] *)

val trace_config_android_report_config_set_reporter_service_class : trace_config_android_report_config -> string -> unit
  (** set field reporter_service_class in trace_config_android_report_config *)

val trace_config_android_report_config_has_skip_report : trace_config_android_report_config -> bool
  (** presence of field "skip_report" in [trace_config_android_report_config] *)

val trace_config_android_report_config_set_skip_report : trace_config_android_report_config -> bool -> unit
  (** set field skip_report in trace_config_android_report_config *)

val trace_config_android_report_config_has_use_pipe_in_framework_for_testing : trace_config_android_report_config -> bool
  (** presence of field "use_pipe_in_framework_for_testing" in [trace_config_android_report_config] *)

val trace_config_android_report_config_set_use_pipe_in_framework_for_testing : trace_config_android_report_config -> bool -> unit
  (** set field use_pipe_in_framework_for_testing in trace_config_android_report_config *)

val make_trace_config_cmd_trace_start_delay : 
  ?min_delay_ms:int32 ->
  ?max_delay_ms:int32 ->
  unit ->
  trace_config_cmd_trace_start_delay
(** [make_trace_config_cmd_trace_start_delay … ()] is a builder for type [trace_config_cmd_trace_start_delay] *)

val copy_trace_config_cmd_trace_start_delay : trace_config_cmd_trace_start_delay -> trace_config_cmd_trace_start_delay

val trace_config_cmd_trace_start_delay_has_min_delay_ms : trace_config_cmd_trace_start_delay -> bool
  (** presence of field "min_delay_ms" in [trace_config_cmd_trace_start_delay] *)

val trace_config_cmd_trace_start_delay_set_min_delay_ms : trace_config_cmd_trace_start_delay -> int32 -> unit
  (** set field min_delay_ms in trace_config_cmd_trace_start_delay *)

val trace_config_cmd_trace_start_delay_has_max_delay_ms : trace_config_cmd_trace_start_delay -> bool
  (** presence of field "max_delay_ms" in [trace_config_cmd_trace_start_delay] *)

val trace_config_cmd_trace_start_delay_set_max_delay_ms : trace_config_cmd_trace_start_delay -> int32 -> unit
  (** set field max_delay_ms in trace_config_cmd_trace_start_delay *)

val make_trace_config_session_semaphore : 
  ?name:string ->
  ?max_other_session_count:int64 ->
  unit ->
  trace_config_session_semaphore
(** [make_trace_config_session_semaphore … ()] is a builder for type [trace_config_session_semaphore] *)

val copy_trace_config_session_semaphore : trace_config_session_semaphore -> trace_config_session_semaphore

val trace_config_session_semaphore_has_name : trace_config_session_semaphore -> bool
  (** presence of field "name" in [trace_config_session_semaphore] *)

val trace_config_session_semaphore_set_name : trace_config_session_semaphore -> string -> unit
  (** set field name in trace_config_session_semaphore *)

val trace_config_session_semaphore_has_max_other_session_count : trace_config_session_semaphore -> bool
  (** presence of field "max_other_session_count" in [trace_config_session_semaphore] *)

val trace_config_session_semaphore_set_max_other_session_count : trace_config_session_semaphore -> int64 -> unit
  (** set field max_other_session_count in trace_config_session_semaphore *)

val make_trace_config : 
  ?buffers:trace_config_buffer_config list ->
  ?data_sources:trace_config_data_source list ->
  ?builtin_data_sources:trace_config_builtin_data_source ->
  ?duration_ms:int32 ->
  ?prefer_suspend_clock_for_duration:bool ->
  ?enable_extra_guardrails:bool ->
  ?lockdown_mode:trace_config_lockdown_mode_operation ->
  ?producers:trace_config_producer_config list ->
  ?statsd_metadata:trace_config_statsd_metadata ->
  ?write_into_file:bool ->
  ?output_path:string ->
  ?file_write_period_ms:int32 ->
  ?max_file_size_bytes:int64 ->
  ?guardrail_overrides:trace_config_guardrail_overrides ->
  ?deferred_start:bool ->
  ?flush_period_ms:int32 ->
  ?flush_timeout_ms:int32 ->
  ?data_source_stop_timeout_ms:int32 ->
  ?notify_traceur:bool ->
  ?bugreport_score:int32 ->
  ?bugreport_filename:string ->
  ?trigger_config:trace_config_trigger_config ->
  ?activate_triggers:string list ->
  ?incremental_state_config:trace_config_incremental_state_config ->
  ?allow_user_build_tracing:bool ->
  ?unique_session_name:string ->
  ?compression_type:trace_config_compression_type ->
  ?incident_report_config:trace_config_incident_report_config ->
  ?statsd_logging:trace_config_statsd_logging ->
  ?trace_uuid_msb:int64 ->
  ?trace_uuid_lsb:int64 ->
  ?trace_filter:trace_config_trace_filter ->
  ?android_report_config:trace_config_android_report_config ->
  ?cmd_trace_start_delay:trace_config_cmd_trace_start_delay ->
  ?session_semaphores:trace_config_session_semaphore list ->
  ?priority_boost:priority_boost_config ->
  ?exclusive_prio:int32 ->
  ?no_flush_before_write_into_file:bool ->
  unit ->
  trace_config
(** [make_trace_config … ()] is a builder for type [trace_config] *)

val copy_trace_config : trace_config -> trace_config

val trace_config_set_buffers : trace_config -> trace_config_buffer_config list -> unit
  (** set field buffers in trace_config *)

val trace_config_set_data_sources : trace_config -> trace_config_data_source list -> unit
  (** set field data_sources in trace_config *)

val trace_config_set_builtin_data_sources : trace_config -> trace_config_builtin_data_source -> unit
  (** set field builtin_data_sources in trace_config *)

val trace_config_has_duration_ms : trace_config -> bool
  (** presence of field "duration_ms" in [trace_config] *)

val trace_config_set_duration_ms : trace_config -> int32 -> unit
  (** set field duration_ms in trace_config *)

val trace_config_has_prefer_suspend_clock_for_duration : trace_config -> bool
  (** presence of field "prefer_suspend_clock_for_duration" in [trace_config] *)

val trace_config_set_prefer_suspend_clock_for_duration : trace_config -> bool -> unit
  (** set field prefer_suspend_clock_for_duration in trace_config *)

val trace_config_has_enable_extra_guardrails : trace_config -> bool
  (** presence of field "enable_extra_guardrails" in [trace_config] *)

val trace_config_set_enable_extra_guardrails : trace_config -> bool -> unit
  (** set field enable_extra_guardrails in trace_config *)

val trace_config_has_lockdown_mode : trace_config -> bool
  (** presence of field "lockdown_mode" in [trace_config] *)

val trace_config_set_lockdown_mode : trace_config -> trace_config_lockdown_mode_operation -> unit
  (** set field lockdown_mode in trace_config *)

val trace_config_set_producers : trace_config -> trace_config_producer_config list -> unit
  (** set field producers in trace_config *)

val trace_config_set_statsd_metadata : trace_config -> trace_config_statsd_metadata -> unit
  (** set field statsd_metadata in trace_config *)

val trace_config_has_write_into_file : trace_config -> bool
  (** presence of field "write_into_file" in [trace_config] *)

val trace_config_set_write_into_file : trace_config -> bool -> unit
  (** set field write_into_file in trace_config *)

val trace_config_has_output_path : trace_config -> bool
  (** presence of field "output_path" in [trace_config] *)

val trace_config_set_output_path : trace_config -> string -> unit
  (** set field output_path in trace_config *)

val trace_config_has_file_write_period_ms : trace_config -> bool
  (** presence of field "file_write_period_ms" in [trace_config] *)

val trace_config_set_file_write_period_ms : trace_config -> int32 -> unit
  (** set field file_write_period_ms in trace_config *)

val trace_config_has_max_file_size_bytes : trace_config -> bool
  (** presence of field "max_file_size_bytes" in [trace_config] *)

val trace_config_set_max_file_size_bytes : trace_config -> int64 -> unit
  (** set field max_file_size_bytes in trace_config *)

val trace_config_set_guardrail_overrides : trace_config -> trace_config_guardrail_overrides -> unit
  (** set field guardrail_overrides in trace_config *)

val trace_config_has_deferred_start : trace_config -> bool
  (** presence of field "deferred_start" in [trace_config] *)

val trace_config_set_deferred_start : trace_config -> bool -> unit
  (** set field deferred_start in trace_config *)

val trace_config_has_flush_period_ms : trace_config -> bool
  (** presence of field "flush_period_ms" in [trace_config] *)

val trace_config_set_flush_period_ms : trace_config -> int32 -> unit
  (** set field flush_period_ms in trace_config *)

val trace_config_has_flush_timeout_ms : trace_config -> bool
  (** presence of field "flush_timeout_ms" in [trace_config] *)

val trace_config_set_flush_timeout_ms : trace_config -> int32 -> unit
  (** set field flush_timeout_ms in trace_config *)

val trace_config_has_data_source_stop_timeout_ms : trace_config -> bool
  (** presence of field "data_source_stop_timeout_ms" in [trace_config] *)

val trace_config_set_data_source_stop_timeout_ms : trace_config -> int32 -> unit
  (** set field data_source_stop_timeout_ms in trace_config *)

val trace_config_has_notify_traceur : trace_config -> bool
  (** presence of field "notify_traceur" in [trace_config] *)

val trace_config_set_notify_traceur : trace_config -> bool -> unit
  (** set field notify_traceur in trace_config *)

val trace_config_has_bugreport_score : trace_config -> bool
  (** presence of field "bugreport_score" in [trace_config] *)

val trace_config_set_bugreport_score : trace_config -> int32 -> unit
  (** set field bugreport_score in trace_config *)

val trace_config_has_bugreport_filename : trace_config -> bool
  (** presence of field "bugreport_filename" in [trace_config] *)

val trace_config_set_bugreport_filename : trace_config -> string -> unit
  (** set field bugreport_filename in trace_config *)

val trace_config_set_trigger_config : trace_config -> trace_config_trigger_config -> unit
  (** set field trigger_config in trace_config *)

val trace_config_set_activate_triggers : trace_config -> string list -> unit
  (** set field activate_triggers in trace_config *)

val trace_config_set_incremental_state_config : trace_config -> trace_config_incremental_state_config -> unit
  (** set field incremental_state_config in trace_config *)

val trace_config_has_allow_user_build_tracing : trace_config -> bool
  (** presence of field "allow_user_build_tracing" in [trace_config] *)

val trace_config_set_allow_user_build_tracing : trace_config -> bool -> unit
  (** set field allow_user_build_tracing in trace_config *)

val trace_config_has_unique_session_name : trace_config -> bool
  (** presence of field "unique_session_name" in [trace_config] *)

val trace_config_set_unique_session_name : trace_config -> string -> unit
  (** set field unique_session_name in trace_config *)

val trace_config_has_compression_type : trace_config -> bool
  (** presence of field "compression_type" in [trace_config] *)

val trace_config_set_compression_type : trace_config -> trace_config_compression_type -> unit
  (** set field compression_type in trace_config *)

val trace_config_set_incident_report_config : trace_config -> trace_config_incident_report_config -> unit
  (** set field incident_report_config in trace_config *)

val trace_config_has_statsd_logging : trace_config -> bool
  (** presence of field "statsd_logging" in [trace_config] *)

val trace_config_set_statsd_logging : trace_config -> trace_config_statsd_logging -> unit
  (** set field statsd_logging in trace_config *)

val trace_config_has_trace_uuid_msb : trace_config -> bool
  (** presence of field "trace_uuid_msb" in [trace_config] *)

val trace_config_set_trace_uuid_msb : trace_config -> int64 -> unit
  (** set field trace_uuid_msb in trace_config *)

val trace_config_has_trace_uuid_lsb : trace_config -> bool
  (** presence of field "trace_uuid_lsb" in [trace_config] *)

val trace_config_set_trace_uuid_lsb : trace_config -> int64 -> unit
  (** set field trace_uuid_lsb in trace_config *)

val trace_config_set_trace_filter : trace_config -> trace_config_trace_filter -> unit
  (** set field trace_filter in trace_config *)

val trace_config_set_android_report_config : trace_config -> trace_config_android_report_config -> unit
  (** set field android_report_config in trace_config *)

val trace_config_set_cmd_trace_start_delay : trace_config -> trace_config_cmd_trace_start_delay -> unit
  (** set field cmd_trace_start_delay in trace_config *)

val trace_config_set_session_semaphores : trace_config -> trace_config_session_semaphore list -> unit
  (** set field session_semaphores in trace_config *)

val trace_config_set_priority_boost : trace_config -> priority_boost_config -> unit
  (** set field priority_boost in trace_config *)

val trace_config_has_exclusive_prio : trace_config -> bool
  (** presence of field "exclusive_prio" in [trace_config] *)

val trace_config_set_exclusive_prio : trace_config -> int32 -> unit
  (** set field exclusive_prio in trace_config *)

val trace_config_has_no_flush_before_write_into_file : trace_config -> bool
  (** presence of field "no_flush_before_write_into_file" in [trace_config] *)

val trace_config_set_no_flush_before_write_into_file : trace_config -> bool -> unit
  (** set field no_flush_before_write_into_file in trace_config *)

val make_utsname : 
  ?sysname:string ->
  ?version:string ->
  ?release:string ->
  ?machine:string ->
  unit ->
  utsname
(** [make_utsname … ()] is a builder for type [utsname] *)

val copy_utsname : utsname -> utsname

val utsname_has_sysname : utsname -> bool
  (** presence of field "sysname" in [utsname] *)

val utsname_set_sysname : utsname -> string -> unit
  (** set field sysname in utsname *)

val utsname_has_version : utsname -> bool
  (** presence of field "version" in [utsname] *)

val utsname_set_version : utsname -> string -> unit
  (** set field version in utsname *)

val utsname_has_release : utsname -> bool
  (** presence of field "release" in [utsname] *)

val utsname_set_release : utsname -> string -> unit
  (** set field release in utsname *)

val utsname_has_machine : utsname -> bool
  (** presence of field "machine" in [utsname] *)

val utsname_set_machine : utsname -> string -> unit
  (** set field machine in utsname *)

val make_system_info : 
  ?utsname:utsname ->
  ?android_build_fingerprint:string ->
  ?android_device_manufacturer:string ->
  ?android_soc_model:string ->
  ?android_guest_soc_model:string ->
  ?android_hardware_revision:string ->
  ?android_storage_model:string ->
  ?android_ram_model:string ->
  ?android_serial_console:string ->
  ?tracing_service_version:string ->
  ?android_sdk_version:int64 ->
  ?page_size:int32 ->
  ?num_cpus:int32 ->
  ?timezone_off_mins:int32 ->
  ?hz:int64 ->
  unit ->
  system_info
(** [make_system_info … ()] is a builder for type [system_info] *)

val copy_system_info : system_info -> system_info

val system_info_set_utsname : system_info -> utsname -> unit
  (** set field utsname in system_info *)

val system_info_has_android_build_fingerprint : system_info -> bool
  (** presence of field "android_build_fingerprint" in [system_info] *)

val system_info_set_android_build_fingerprint : system_info -> string -> unit
  (** set field android_build_fingerprint in system_info *)

val system_info_has_android_device_manufacturer : system_info -> bool
  (** presence of field "android_device_manufacturer" in [system_info] *)

val system_info_set_android_device_manufacturer : system_info -> string -> unit
  (** set field android_device_manufacturer in system_info *)

val system_info_has_android_soc_model : system_info -> bool
  (** presence of field "android_soc_model" in [system_info] *)

val system_info_set_android_soc_model : system_info -> string -> unit
  (** set field android_soc_model in system_info *)

val system_info_has_android_guest_soc_model : system_info -> bool
  (** presence of field "android_guest_soc_model" in [system_info] *)

val system_info_set_android_guest_soc_model : system_info -> string -> unit
  (** set field android_guest_soc_model in system_info *)

val system_info_has_android_hardware_revision : system_info -> bool
  (** presence of field "android_hardware_revision" in [system_info] *)

val system_info_set_android_hardware_revision : system_info -> string -> unit
  (** set field android_hardware_revision in system_info *)

val system_info_has_android_storage_model : system_info -> bool
  (** presence of field "android_storage_model" in [system_info] *)

val system_info_set_android_storage_model : system_info -> string -> unit
  (** set field android_storage_model in system_info *)

val system_info_has_android_ram_model : system_info -> bool
  (** presence of field "android_ram_model" in [system_info] *)

val system_info_set_android_ram_model : system_info -> string -> unit
  (** set field android_ram_model in system_info *)

val system_info_has_android_serial_console : system_info -> bool
  (** presence of field "android_serial_console" in [system_info] *)

val system_info_set_android_serial_console : system_info -> string -> unit
  (** set field android_serial_console in system_info *)

val system_info_has_tracing_service_version : system_info -> bool
  (** presence of field "tracing_service_version" in [system_info] *)

val system_info_set_tracing_service_version : system_info -> string -> unit
  (** set field tracing_service_version in system_info *)

val system_info_has_android_sdk_version : system_info -> bool
  (** presence of field "android_sdk_version" in [system_info] *)

val system_info_set_android_sdk_version : system_info -> int64 -> unit
  (** set field android_sdk_version in system_info *)

val system_info_has_page_size : system_info -> bool
  (** presence of field "page_size" in [system_info] *)

val system_info_set_page_size : system_info -> int32 -> unit
  (** set field page_size in system_info *)

val system_info_has_num_cpus : system_info -> bool
  (** presence of field "num_cpus" in [system_info] *)

val system_info_set_num_cpus : system_info -> int32 -> unit
  (** set field num_cpus in system_info *)

val system_info_has_timezone_off_mins : system_info -> bool
  (** presence of field "timezone_off_mins" in [system_info] *)

val system_info_set_timezone_off_mins : system_info -> int32 -> unit
  (** set field timezone_off_mins in system_info *)

val system_info_has_hz : system_info -> bool
  (** presence of field "hz" in [system_info] *)

val system_info_set_hz : system_info -> int64 -> unit
  (** set field hz in system_info *)

val make_trace_stats_buffer_stats : 
  ?buffer_size:int64 ->
  ?bytes_written:int64 ->
  ?bytes_overwritten:int64 ->
  ?bytes_read:int64 ->
  ?padding_bytes_written:int64 ->
  ?padding_bytes_cleared:int64 ->
  ?chunks_written:int64 ->
  ?chunks_rewritten:int64 ->
  ?chunks_overwritten:int64 ->
  ?chunks_discarded:int64 ->
  ?chunks_read:int64 ->
  ?chunks_committed_out_of_order:int64 ->
  ?write_wrap_count:int64 ->
  ?patches_succeeded:int64 ->
  ?patches_failed:int64 ->
  ?readaheads_succeeded:int64 ->
  ?readaheads_failed:int64 ->
  ?abi_violations:int64 ->
  ?trace_writer_packet_loss:int64 ->
  unit ->
  trace_stats_buffer_stats
(** [make_trace_stats_buffer_stats … ()] is a builder for type [trace_stats_buffer_stats] *)

val copy_trace_stats_buffer_stats : trace_stats_buffer_stats -> trace_stats_buffer_stats

val trace_stats_buffer_stats_has_buffer_size : trace_stats_buffer_stats -> bool
  (** presence of field "buffer_size" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_buffer_size : trace_stats_buffer_stats -> int64 -> unit
  (** set field buffer_size in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_bytes_written : trace_stats_buffer_stats -> bool
  (** presence of field "bytes_written" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_bytes_written : trace_stats_buffer_stats -> int64 -> unit
  (** set field bytes_written in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_bytes_overwritten : trace_stats_buffer_stats -> bool
  (** presence of field "bytes_overwritten" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_bytes_overwritten : trace_stats_buffer_stats -> int64 -> unit
  (** set field bytes_overwritten in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_bytes_read : trace_stats_buffer_stats -> bool
  (** presence of field "bytes_read" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_bytes_read : trace_stats_buffer_stats -> int64 -> unit
  (** set field bytes_read in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_padding_bytes_written : trace_stats_buffer_stats -> bool
  (** presence of field "padding_bytes_written" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_padding_bytes_written : trace_stats_buffer_stats -> int64 -> unit
  (** set field padding_bytes_written in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_padding_bytes_cleared : trace_stats_buffer_stats -> bool
  (** presence of field "padding_bytes_cleared" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_padding_bytes_cleared : trace_stats_buffer_stats -> int64 -> unit
  (** set field padding_bytes_cleared in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_chunks_written : trace_stats_buffer_stats -> bool
  (** presence of field "chunks_written" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_chunks_written : trace_stats_buffer_stats -> int64 -> unit
  (** set field chunks_written in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_chunks_rewritten : trace_stats_buffer_stats -> bool
  (** presence of field "chunks_rewritten" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_chunks_rewritten : trace_stats_buffer_stats -> int64 -> unit
  (** set field chunks_rewritten in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_chunks_overwritten : trace_stats_buffer_stats -> bool
  (** presence of field "chunks_overwritten" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_chunks_overwritten : trace_stats_buffer_stats -> int64 -> unit
  (** set field chunks_overwritten in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_chunks_discarded : trace_stats_buffer_stats -> bool
  (** presence of field "chunks_discarded" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_chunks_discarded : trace_stats_buffer_stats -> int64 -> unit
  (** set field chunks_discarded in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_chunks_read : trace_stats_buffer_stats -> bool
  (** presence of field "chunks_read" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_chunks_read : trace_stats_buffer_stats -> int64 -> unit
  (** set field chunks_read in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_chunks_committed_out_of_order : trace_stats_buffer_stats -> bool
  (** presence of field "chunks_committed_out_of_order" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_chunks_committed_out_of_order : trace_stats_buffer_stats -> int64 -> unit
  (** set field chunks_committed_out_of_order in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_write_wrap_count : trace_stats_buffer_stats -> bool
  (** presence of field "write_wrap_count" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_write_wrap_count : trace_stats_buffer_stats -> int64 -> unit
  (** set field write_wrap_count in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_patches_succeeded : trace_stats_buffer_stats -> bool
  (** presence of field "patches_succeeded" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_patches_succeeded : trace_stats_buffer_stats -> int64 -> unit
  (** set field patches_succeeded in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_patches_failed : trace_stats_buffer_stats -> bool
  (** presence of field "patches_failed" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_patches_failed : trace_stats_buffer_stats -> int64 -> unit
  (** set field patches_failed in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_readaheads_succeeded : trace_stats_buffer_stats -> bool
  (** presence of field "readaheads_succeeded" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_readaheads_succeeded : trace_stats_buffer_stats -> int64 -> unit
  (** set field readaheads_succeeded in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_readaheads_failed : trace_stats_buffer_stats -> bool
  (** presence of field "readaheads_failed" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_readaheads_failed : trace_stats_buffer_stats -> int64 -> unit
  (** set field readaheads_failed in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_abi_violations : trace_stats_buffer_stats -> bool
  (** presence of field "abi_violations" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_abi_violations : trace_stats_buffer_stats -> int64 -> unit
  (** set field abi_violations in trace_stats_buffer_stats *)

val trace_stats_buffer_stats_has_trace_writer_packet_loss : trace_stats_buffer_stats -> bool
  (** presence of field "trace_writer_packet_loss" in [trace_stats_buffer_stats] *)

val trace_stats_buffer_stats_set_trace_writer_packet_loss : trace_stats_buffer_stats -> int64 -> unit
  (** set field trace_writer_packet_loss in trace_stats_buffer_stats *)

val make_trace_stats_writer_stats : 
  ?sequence_id:int64 ->
  ?buffer:int32 ->
  ?chunk_payload_histogram_counts:int64 list ->
  ?chunk_payload_histogram_sum:int64 list ->
  unit ->
  trace_stats_writer_stats
(** [make_trace_stats_writer_stats … ()] is a builder for type [trace_stats_writer_stats] *)

val copy_trace_stats_writer_stats : trace_stats_writer_stats -> trace_stats_writer_stats

val trace_stats_writer_stats_has_sequence_id : trace_stats_writer_stats -> bool
  (** presence of field "sequence_id" in [trace_stats_writer_stats] *)

val trace_stats_writer_stats_set_sequence_id : trace_stats_writer_stats -> int64 -> unit
  (** set field sequence_id in trace_stats_writer_stats *)

val trace_stats_writer_stats_has_buffer : trace_stats_writer_stats -> bool
  (** presence of field "buffer" in [trace_stats_writer_stats] *)

val trace_stats_writer_stats_set_buffer : trace_stats_writer_stats -> int32 -> unit
  (** set field buffer in trace_stats_writer_stats *)

val trace_stats_writer_stats_set_chunk_payload_histogram_counts : trace_stats_writer_stats -> int64 list -> unit
  (** set field chunk_payload_histogram_counts in trace_stats_writer_stats *)

val trace_stats_writer_stats_set_chunk_payload_histogram_sum : trace_stats_writer_stats -> int64 list -> unit
  (** set field chunk_payload_histogram_sum in trace_stats_writer_stats *)

val make_trace_stats_filter_stats : 
  ?input_packets:int64 ->
  ?input_bytes:int64 ->
  ?output_bytes:int64 ->
  ?errors:int64 ->
  ?time_taken_ns:int64 ->
  ?bytes_discarded_per_buffer:int64 list ->
  unit ->
  trace_stats_filter_stats
(** [make_trace_stats_filter_stats … ()] is a builder for type [trace_stats_filter_stats] *)

val copy_trace_stats_filter_stats : trace_stats_filter_stats -> trace_stats_filter_stats

val trace_stats_filter_stats_has_input_packets : trace_stats_filter_stats -> bool
  (** presence of field "input_packets" in [trace_stats_filter_stats] *)

val trace_stats_filter_stats_set_input_packets : trace_stats_filter_stats -> int64 -> unit
  (** set field input_packets in trace_stats_filter_stats *)

val trace_stats_filter_stats_has_input_bytes : trace_stats_filter_stats -> bool
  (** presence of field "input_bytes" in [trace_stats_filter_stats] *)

val trace_stats_filter_stats_set_input_bytes : trace_stats_filter_stats -> int64 -> unit
  (** set field input_bytes in trace_stats_filter_stats *)

val trace_stats_filter_stats_has_output_bytes : trace_stats_filter_stats -> bool
  (** presence of field "output_bytes" in [trace_stats_filter_stats] *)

val trace_stats_filter_stats_set_output_bytes : trace_stats_filter_stats -> int64 -> unit
  (** set field output_bytes in trace_stats_filter_stats *)

val trace_stats_filter_stats_has_errors : trace_stats_filter_stats -> bool
  (** presence of field "errors" in [trace_stats_filter_stats] *)

val trace_stats_filter_stats_set_errors : trace_stats_filter_stats -> int64 -> unit
  (** set field errors in trace_stats_filter_stats *)

val trace_stats_filter_stats_has_time_taken_ns : trace_stats_filter_stats -> bool
  (** presence of field "time_taken_ns" in [trace_stats_filter_stats] *)

val trace_stats_filter_stats_set_time_taken_ns : trace_stats_filter_stats -> int64 -> unit
  (** set field time_taken_ns in trace_stats_filter_stats *)

val trace_stats_filter_stats_set_bytes_discarded_per_buffer : trace_stats_filter_stats -> int64 list -> unit
  (** set field bytes_discarded_per_buffer in trace_stats_filter_stats *)

val make_trace_stats : 
  ?buffer_stats:trace_stats_buffer_stats list ->
  ?chunk_payload_histogram_def:int64 list ->
  ?writer_stats:trace_stats_writer_stats list ->
  ?producers_connected:int32 ->
  ?producers_seen:int64 ->
  ?data_sources_registered:int32 ->
  ?data_sources_seen:int64 ->
  ?tracing_sessions:int32 ->
  ?total_buffers:int32 ->
  ?chunks_discarded:int64 ->
  ?patches_discarded:int64 ->
  ?invalid_packets:int64 ->
  ?filter_stats:trace_stats_filter_stats ->
  ?flushes_requested:int64 ->
  ?flushes_succeeded:int64 ->
  ?flushes_failed:int64 ->
  ?final_flush_outcome:trace_stats_final_flush_outcome ->
  unit ->
  trace_stats
(** [make_trace_stats … ()] is a builder for type [trace_stats] *)

val copy_trace_stats : trace_stats -> trace_stats

val trace_stats_set_buffer_stats : trace_stats -> trace_stats_buffer_stats list -> unit
  (** set field buffer_stats in trace_stats *)

val trace_stats_set_chunk_payload_histogram_def : trace_stats -> int64 list -> unit
  (** set field chunk_payload_histogram_def in trace_stats *)

val trace_stats_set_writer_stats : trace_stats -> trace_stats_writer_stats list -> unit
  (** set field writer_stats in trace_stats *)

val trace_stats_has_producers_connected : trace_stats -> bool
  (** presence of field "producers_connected" in [trace_stats] *)

val trace_stats_set_producers_connected : trace_stats -> int32 -> unit
  (** set field producers_connected in trace_stats *)

val trace_stats_has_producers_seen : trace_stats -> bool
  (** presence of field "producers_seen" in [trace_stats] *)

val trace_stats_set_producers_seen : trace_stats -> int64 -> unit
  (** set field producers_seen in trace_stats *)

val trace_stats_has_data_sources_registered : trace_stats -> bool
  (** presence of field "data_sources_registered" in [trace_stats] *)

val trace_stats_set_data_sources_registered : trace_stats -> int32 -> unit
  (** set field data_sources_registered in trace_stats *)

val trace_stats_has_data_sources_seen : trace_stats -> bool
  (** presence of field "data_sources_seen" in [trace_stats] *)

val trace_stats_set_data_sources_seen : trace_stats -> int64 -> unit
  (** set field data_sources_seen in trace_stats *)

val trace_stats_has_tracing_sessions : trace_stats -> bool
  (** presence of field "tracing_sessions" in [trace_stats] *)

val trace_stats_set_tracing_sessions : trace_stats -> int32 -> unit
  (** set field tracing_sessions in trace_stats *)

val trace_stats_has_total_buffers : trace_stats -> bool
  (** presence of field "total_buffers" in [trace_stats] *)

val trace_stats_set_total_buffers : trace_stats -> int32 -> unit
  (** set field total_buffers in trace_stats *)

val trace_stats_has_chunks_discarded : trace_stats -> bool
  (** presence of field "chunks_discarded" in [trace_stats] *)

val trace_stats_set_chunks_discarded : trace_stats -> int64 -> unit
  (** set field chunks_discarded in trace_stats *)

val trace_stats_has_patches_discarded : trace_stats -> bool
  (** presence of field "patches_discarded" in [trace_stats] *)

val trace_stats_set_patches_discarded : trace_stats -> int64 -> unit
  (** set field patches_discarded in trace_stats *)

val trace_stats_has_invalid_packets : trace_stats -> bool
  (** presence of field "invalid_packets" in [trace_stats] *)

val trace_stats_set_invalid_packets : trace_stats -> int64 -> unit
  (** set field invalid_packets in trace_stats *)

val trace_stats_set_filter_stats : trace_stats -> trace_stats_filter_stats -> unit
  (** set field filter_stats in trace_stats *)

val trace_stats_has_flushes_requested : trace_stats -> bool
  (** presence of field "flushes_requested" in [trace_stats] *)

val trace_stats_set_flushes_requested : trace_stats -> int64 -> unit
  (** set field flushes_requested in trace_stats *)

val trace_stats_has_flushes_succeeded : trace_stats -> bool
  (** presence of field "flushes_succeeded" in [trace_stats] *)

val trace_stats_set_flushes_succeeded : trace_stats -> int64 -> unit
  (** set field flushes_succeeded in trace_stats *)

val trace_stats_has_flushes_failed : trace_stats -> bool
  (** presence of field "flushes_failed" in [trace_stats] *)

val trace_stats_set_flushes_failed : trace_stats -> int64 -> unit
  (** set field flushes_failed in trace_stats *)

val trace_stats_has_final_flush_outcome : trace_stats -> bool
  (** presence of field "final_flush_outcome" in [trace_stats] *)

val trace_stats_set_final_flush_outcome : trace_stats -> trace_stats_final_flush_outcome -> unit
  (** set field final_flush_outcome in trace_stats *)

val make_proto_log_message : 
  ?message_id:int64 ->
  ?str_param_iids:int32 list ->
  ?sint64_params:int64 list ->
  ?double_params:float list ->
  ?boolean_params:int32 list ->
  ?stacktrace_iid:int32 ->
  unit ->
  proto_log_message
(** [make_proto_log_message … ()] is a builder for type [proto_log_message] *)

val copy_proto_log_message : proto_log_message -> proto_log_message

val proto_log_message_has_message_id : proto_log_message -> bool
  (** presence of field "message_id" in [proto_log_message] *)

val proto_log_message_set_message_id : proto_log_message -> int64 -> unit
  (** set field message_id in proto_log_message *)

val proto_log_message_set_str_param_iids : proto_log_message -> int32 list -> unit
  (** set field str_param_iids in proto_log_message *)

val proto_log_message_set_sint64_params : proto_log_message -> int64 list -> unit
  (** set field sint64_params in proto_log_message *)

val proto_log_message_set_double_params : proto_log_message -> float list -> unit
  (** set field double_params in proto_log_message *)

val proto_log_message_set_boolean_params : proto_log_message -> int32 list -> unit
  (** set field boolean_params in proto_log_message *)

val proto_log_message_has_stacktrace_iid : proto_log_message -> bool
  (** presence of field "stacktrace_iid" in [proto_log_message] *)

val proto_log_message_set_stacktrace_iid : proto_log_message -> int32 -> unit
  (** set field stacktrace_iid in proto_log_message *)

val make_proto_log_viewer_config_message_data : 
  ?message_id:int64 ->
  ?message:string ->
  ?level:proto_log_level ->
  ?group_id:int32 ->
  ?location:string ->
  unit ->
  proto_log_viewer_config_message_data
(** [make_proto_log_viewer_config_message_data … ()] is a builder for type [proto_log_viewer_config_message_data] *)

val copy_proto_log_viewer_config_message_data : proto_log_viewer_config_message_data -> proto_log_viewer_config_message_data

val proto_log_viewer_config_message_data_has_message_id : proto_log_viewer_config_message_data -> bool
  (** presence of field "message_id" in [proto_log_viewer_config_message_data] *)

val proto_log_viewer_config_message_data_set_message_id : proto_log_viewer_config_message_data -> int64 -> unit
  (** set field message_id in proto_log_viewer_config_message_data *)

val proto_log_viewer_config_message_data_has_message : proto_log_viewer_config_message_data -> bool
  (** presence of field "message" in [proto_log_viewer_config_message_data] *)

val proto_log_viewer_config_message_data_set_message : proto_log_viewer_config_message_data -> string -> unit
  (** set field message in proto_log_viewer_config_message_data *)

val proto_log_viewer_config_message_data_has_level : proto_log_viewer_config_message_data -> bool
  (** presence of field "level" in [proto_log_viewer_config_message_data] *)

val proto_log_viewer_config_message_data_set_level : proto_log_viewer_config_message_data -> proto_log_level -> unit
  (** set field level in proto_log_viewer_config_message_data *)

val proto_log_viewer_config_message_data_has_group_id : proto_log_viewer_config_message_data -> bool
  (** presence of field "group_id" in [proto_log_viewer_config_message_data] *)

val proto_log_viewer_config_message_data_set_group_id : proto_log_viewer_config_message_data -> int32 -> unit
  (** set field group_id in proto_log_viewer_config_message_data *)

val proto_log_viewer_config_message_data_has_location : proto_log_viewer_config_message_data -> bool
  (** presence of field "location" in [proto_log_viewer_config_message_data] *)

val proto_log_viewer_config_message_data_set_location : proto_log_viewer_config_message_data -> string -> unit
  (** set field location in proto_log_viewer_config_message_data *)

val make_proto_log_viewer_config_group : 
  ?id:int32 ->
  ?name:string ->
  ?tag:string ->
  unit ->
  proto_log_viewer_config_group
(** [make_proto_log_viewer_config_group … ()] is a builder for type [proto_log_viewer_config_group] *)

val copy_proto_log_viewer_config_group : proto_log_viewer_config_group -> proto_log_viewer_config_group

val proto_log_viewer_config_group_has_id : proto_log_viewer_config_group -> bool
  (** presence of field "id" in [proto_log_viewer_config_group] *)

val proto_log_viewer_config_group_set_id : proto_log_viewer_config_group -> int32 -> unit
  (** set field id in proto_log_viewer_config_group *)

val proto_log_viewer_config_group_has_name : proto_log_viewer_config_group -> bool
  (** presence of field "name" in [proto_log_viewer_config_group] *)

val proto_log_viewer_config_group_set_name : proto_log_viewer_config_group -> string -> unit
  (** set field name in proto_log_viewer_config_group *)

val proto_log_viewer_config_group_has_tag : proto_log_viewer_config_group -> bool
  (** presence of field "tag" in [proto_log_viewer_config_group] *)

val proto_log_viewer_config_group_set_tag : proto_log_viewer_config_group -> string -> unit
  (** set field tag in proto_log_viewer_config_group *)

val make_proto_log_viewer_config : 
  ?messages:proto_log_viewer_config_message_data list ->
  ?groups:proto_log_viewer_config_group list ->
  unit ->
  proto_log_viewer_config
(** [make_proto_log_viewer_config … ()] is a builder for type [proto_log_viewer_config] *)

val copy_proto_log_viewer_config : proto_log_viewer_config -> proto_log_viewer_config

val proto_log_viewer_config_set_messages : proto_log_viewer_config -> proto_log_viewer_config_message_data list -> unit
  (** set field messages in proto_log_viewer_config *)

val proto_log_viewer_config_set_groups : proto_log_viewer_config -> proto_log_viewer_config_group list -> unit
  (** set field groups in proto_log_viewer_config *)

val make_shell_transition_target : 
  ?mode:int32 ->
  ?layer_id:int32 ->
  ?window_id:int32 ->
  ?flags:int32 ->
  unit ->
  shell_transition_target
(** [make_shell_transition_target … ()] is a builder for type [shell_transition_target] *)

val copy_shell_transition_target : shell_transition_target -> shell_transition_target

val shell_transition_target_has_mode : shell_transition_target -> bool
  (** presence of field "mode" in [shell_transition_target] *)

val shell_transition_target_set_mode : shell_transition_target -> int32 -> unit
  (** set field mode in shell_transition_target *)

val shell_transition_target_has_layer_id : shell_transition_target -> bool
  (** presence of field "layer_id" in [shell_transition_target] *)

val shell_transition_target_set_layer_id : shell_transition_target -> int32 -> unit
  (** set field layer_id in shell_transition_target *)

val shell_transition_target_has_window_id : shell_transition_target -> bool
  (** presence of field "window_id" in [shell_transition_target] *)

val shell_transition_target_set_window_id : shell_transition_target -> int32 -> unit
  (** set field window_id in shell_transition_target *)

val shell_transition_target_has_flags : shell_transition_target -> bool
  (** presence of field "flags" in [shell_transition_target] *)

val shell_transition_target_set_flags : shell_transition_target -> int32 -> unit
  (** set field flags in shell_transition_target *)

val make_shell_transition : 
  ?id:int32 ->
  ?create_time_ns:int64 ->
  ?send_time_ns:int64 ->
  ?dispatch_time_ns:int64 ->
  ?merge_time_ns:int64 ->
  ?merge_request_time_ns:int64 ->
  ?shell_abort_time_ns:int64 ->
  ?wm_abort_time_ns:int64 ->
  ?finish_time_ns:int64 ->
  ?start_transaction_id:int64 ->
  ?finish_transaction_id:int64 ->
  ?handler:int32 ->
  ?type_:int32 ->
  ?targets:shell_transition_target list ->
  ?merge_target:int32 ->
  ?flags:int32 ->
  ?starting_window_remove_time_ns:int64 ->
  unit ->
  shell_transition
(** [make_shell_transition … ()] is a builder for type [shell_transition] *)

val copy_shell_transition : shell_transition -> shell_transition

val shell_transition_has_id : shell_transition -> bool
  (** presence of field "id" in [shell_transition] *)

val shell_transition_set_id : shell_transition -> int32 -> unit
  (** set field id in shell_transition *)

val shell_transition_has_create_time_ns : shell_transition -> bool
  (** presence of field "create_time_ns" in [shell_transition] *)

val shell_transition_set_create_time_ns : shell_transition -> int64 -> unit
  (** set field create_time_ns in shell_transition *)

val shell_transition_has_send_time_ns : shell_transition -> bool
  (** presence of field "send_time_ns" in [shell_transition] *)

val shell_transition_set_send_time_ns : shell_transition -> int64 -> unit
  (** set field send_time_ns in shell_transition *)

val shell_transition_has_dispatch_time_ns : shell_transition -> bool
  (** presence of field "dispatch_time_ns" in [shell_transition] *)

val shell_transition_set_dispatch_time_ns : shell_transition -> int64 -> unit
  (** set field dispatch_time_ns in shell_transition *)

val shell_transition_has_merge_time_ns : shell_transition -> bool
  (** presence of field "merge_time_ns" in [shell_transition] *)

val shell_transition_set_merge_time_ns : shell_transition -> int64 -> unit
  (** set field merge_time_ns in shell_transition *)

val shell_transition_has_merge_request_time_ns : shell_transition -> bool
  (** presence of field "merge_request_time_ns" in [shell_transition] *)

val shell_transition_set_merge_request_time_ns : shell_transition -> int64 -> unit
  (** set field merge_request_time_ns in shell_transition *)

val shell_transition_has_shell_abort_time_ns : shell_transition -> bool
  (** presence of field "shell_abort_time_ns" in [shell_transition] *)

val shell_transition_set_shell_abort_time_ns : shell_transition -> int64 -> unit
  (** set field shell_abort_time_ns in shell_transition *)

val shell_transition_has_wm_abort_time_ns : shell_transition -> bool
  (** presence of field "wm_abort_time_ns" in [shell_transition] *)

val shell_transition_set_wm_abort_time_ns : shell_transition -> int64 -> unit
  (** set field wm_abort_time_ns in shell_transition *)

val shell_transition_has_finish_time_ns : shell_transition -> bool
  (** presence of field "finish_time_ns" in [shell_transition] *)

val shell_transition_set_finish_time_ns : shell_transition -> int64 -> unit
  (** set field finish_time_ns in shell_transition *)

val shell_transition_has_start_transaction_id : shell_transition -> bool
  (** presence of field "start_transaction_id" in [shell_transition] *)

val shell_transition_set_start_transaction_id : shell_transition -> int64 -> unit
  (** set field start_transaction_id in shell_transition *)

val shell_transition_has_finish_transaction_id : shell_transition -> bool
  (** presence of field "finish_transaction_id" in [shell_transition] *)

val shell_transition_set_finish_transaction_id : shell_transition -> int64 -> unit
  (** set field finish_transaction_id in shell_transition *)

val shell_transition_has_handler : shell_transition -> bool
  (** presence of field "handler" in [shell_transition] *)

val shell_transition_set_handler : shell_transition -> int32 -> unit
  (** set field handler in shell_transition *)

val shell_transition_has_type_ : shell_transition -> bool
  (** presence of field "type_" in [shell_transition] *)

val shell_transition_set_type_ : shell_transition -> int32 -> unit
  (** set field type_ in shell_transition *)

val shell_transition_set_targets : shell_transition -> shell_transition_target list -> unit
  (** set field targets in shell_transition *)

val shell_transition_has_merge_target : shell_transition -> bool
  (** presence of field "merge_target" in [shell_transition] *)

val shell_transition_set_merge_target : shell_transition -> int32 -> unit
  (** set field merge_target in shell_transition *)

val shell_transition_has_flags : shell_transition -> bool
  (** presence of field "flags" in [shell_transition] *)

val shell_transition_set_flags : shell_transition -> int32 -> unit
  (** set field flags in shell_transition *)

val shell_transition_has_starting_window_remove_time_ns : shell_transition -> bool
  (** presence of field "starting_window_remove_time_ns" in [shell_transition] *)

val shell_transition_set_starting_window_remove_time_ns : shell_transition -> int64 -> unit
  (** set field starting_window_remove_time_ns in shell_transition *)

val make_shell_handler_mapping : 
  ?id:int32 ->
  ?name:string ->
  unit ->
  shell_handler_mapping
(** [make_shell_handler_mapping … ()] is a builder for type [shell_handler_mapping] *)

val copy_shell_handler_mapping : shell_handler_mapping -> shell_handler_mapping

val shell_handler_mapping_has_id : shell_handler_mapping -> bool
  (** presence of field "id" in [shell_handler_mapping] *)

val shell_handler_mapping_set_id : shell_handler_mapping -> int32 -> unit
  (** set field id in shell_handler_mapping *)

val shell_handler_mapping_has_name : shell_handler_mapping -> bool
  (** presence of field "name" in [shell_handler_mapping] *)

val shell_handler_mapping_set_name : shell_handler_mapping -> string -> unit
  (** set field name in shell_handler_mapping *)

val make_shell_handler_mappings : 
  ?mapping:shell_handler_mapping list ->
  unit ->
  shell_handler_mappings
(** [make_shell_handler_mappings … ()] is a builder for type [shell_handler_mappings] *)

val copy_shell_handler_mappings : shell_handler_mappings -> shell_handler_mappings

val shell_handler_mappings_set_mapping : shell_handler_mappings -> shell_handler_mapping list -> unit
  (** set field mapping in shell_handler_mappings *)

val make_rect_proto : 
  ?left:int32 ->
  ?top:int32 ->
  ?right:int32 ->
  ?bottom:int32 ->
  unit ->
  rect_proto
(** [make_rect_proto … ()] is a builder for type [rect_proto] *)

val copy_rect_proto : rect_proto -> rect_proto

val rect_proto_has_left : rect_proto -> bool
  (** presence of field "left" in [rect_proto] *)

val rect_proto_set_left : rect_proto -> int32 -> unit
  (** set field left in rect_proto *)

val rect_proto_has_top : rect_proto -> bool
  (** presence of field "top" in [rect_proto] *)

val rect_proto_set_top : rect_proto -> int32 -> unit
  (** set field top in rect_proto *)

val rect_proto_has_right : rect_proto -> bool
  (** presence of field "right" in [rect_proto] *)

val rect_proto_set_right : rect_proto -> int32 -> unit
  (** set field right in rect_proto *)

val rect_proto_has_bottom : rect_proto -> bool
  (** presence of field "bottom" in [rect_proto] *)

val rect_proto_set_bottom : rect_proto -> int32 -> unit
  (** set field bottom in rect_proto *)

val make_region_proto : 
  ?rect:rect_proto list ->
  unit ->
  region_proto
(** [make_region_proto … ()] is a builder for type [region_proto] *)

val copy_region_proto : region_proto -> region_proto

val region_proto_set_rect : region_proto -> rect_proto list -> unit
  (** set field rect in region_proto *)

val make_size_proto : 
  ?w:int32 ->
  ?h:int32 ->
  unit ->
  size_proto
(** [make_size_proto … ()] is a builder for type [size_proto] *)

val copy_size_proto : size_proto -> size_proto

val size_proto_has_w : size_proto -> bool
  (** presence of field "w" in [size_proto] *)

val size_proto_set_w : size_proto -> int32 -> unit
  (** set field w in size_proto *)

val size_proto_has_h : size_proto -> bool
  (** presence of field "h" in [size_proto] *)

val size_proto_set_h : size_proto -> int32 -> unit
  (** set field h in size_proto *)

val make_transform_proto : 
  ?dsdx:float ->
  ?dtdx:float ->
  ?dsdy:float ->
  ?dtdy:float ->
  ?type_:int32 ->
  unit ->
  transform_proto
(** [make_transform_proto … ()] is a builder for type [transform_proto] *)

val copy_transform_proto : transform_proto -> transform_proto

val transform_proto_has_dsdx : transform_proto -> bool
  (** presence of field "dsdx" in [transform_proto] *)

val transform_proto_set_dsdx : transform_proto -> float -> unit
  (** set field dsdx in transform_proto *)

val transform_proto_has_dtdx : transform_proto -> bool
  (** presence of field "dtdx" in [transform_proto] *)

val transform_proto_set_dtdx : transform_proto -> float -> unit
  (** set field dtdx in transform_proto *)

val transform_proto_has_dsdy : transform_proto -> bool
  (** presence of field "dsdy" in [transform_proto] *)

val transform_proto_set_dsdy : transform_proto -> float -> unit
  (** set field dsdy in transform_proto *)

val transform_proto_has_dtdy : transform_proto -> bool
  (** presence of field "dtdy" in [transform_proto] *)

val transform_proto_set_dtdy : transform_proto -> float -> unit
  (** set field dtdy in transform_proto *)

val transform_proto_has_type_ : transform_proto -> bool
  (** presence of field "type_" in [transform_proto] *)

val transform_proto_set_type_ : transform_proto -> int32 -> unit
  (** set field type_ in transform_proto *)

val make_color_proto : 
  ?r:float ->
  ?g:float ->
  ?b:float ->
  ?a:float ->
  unit ->
  color_proto
(** [make_color_proto … ()] is a builder for type [color_proto] *)

val copy_color_proto : color_proto -> color_proto

val color_proto_has_r : color_proto -> bool
  (** presence of field "r" in [color_proto] *)

val color_proto_set_r : color_proto -> float -> unit
  (** set field r in color_proto *)

val color_proto_has_g : color_proto -> bool
  (** presence of field "g" in [color_proto] *)

val color_proto_set_g : color_proto -> float -> unit
  (** set field g in color_proto *)

val color_proto_has_b : color_proto -> bool
  (** presence of field "b" in [color_proto] *)

val color_proto_set_b : color_proto -> float -> unit
  (** set field b in color_proto *)

val color_proto_has_a : color_proto -> bool
  (** presence of field "a" in [color_proto] *)

val color_proto_set_a : color_proto -> float -> unit
  (** set field a in color_proto *)

val make_input_window_info_proto : 
  ?layout_params_flags:int32 ->
  ?layout_params_type:int32 ->
  ?frame:rect_proto ->
  ?touchable_region:region_proto ->
  ?surface_inset:int32 ->
  ?visible:bool ->
  ?can_receive_keys:bool ->
  ?focusable:bool ->
  ?has_wallpaper:bool ->
  ?global_scale_factor:float ->
  ?window_x_scale:float ->
  ?window_y_scale:float ->
  ?crop_layer_id:int32 ->
  ?replace_touchable_region_with_crop:bool ->
  ?touchable_region_crop:rect_proto ->
  ?transform:transform_proto ->
  ?input_config:int32 ->
  unit ->
  input_window_info_proto
(** [make_input_window_info_proto … ()] is a builder for type [input_window_info_proto] *)

val copy_input_window_info_proto : input_window_info_proto -> input_window_info_proto

val input_window_info_proto_has_layout_params_flags : input_window_info_proto -> bool
  (** presence of field "layout_params_flags" in [input_window_info_proto] *)

val input_window_info_proto_set_layout_params_flags : input_window_info_proto -> int32 -> unit
  (** set field layout_params_flags in input_window_info_proto *)

val input_window_info_proto_has_layout_params_type : input_window_info_proto -> bool
  (** presence of field "layout_params_type" in [input_window_info_proto] *)

val input_window_info_proto_set_layout_params_type : input_window_info_proto -> int32 -> unit
  (** set field layout_params_type in input_window_info_proto *)

val input_window_info_proto_set_frame : input_window_info_proto -> rect_proto -> unit
  (** set field frame in input_window_info_proto *)

val input_window_info_proto_set_touchable_region : input_window_info_proto -> region_proto -> unit
  (** set field touchable_region in input_window_info_proto *)

val input_window_info_proto_has_surface_inset : input_window_info_proto -> bool
  (** presence of field "surface_inset" in [input_window_info_proto] *)

val input_window_info_proto_set_surface_inset : input_window_info_proto -> int32 -> unit
  (** set field surface_inset in input_window_info_proto *)

val input_window_info_proto_has_visible : input_window_info_proto -> bool
  (** presence of field "visible" in [input_window_info_proto] *)

val input_window_info_proto_set_visible : input_window_info_proto -> bool -> unit
  (** set field visible in input_window_info_proto *)

val input_window_info_proto_has_can_receive_keys : input_window_info_proto -> bool
  (** presence of field "can_receive_keys" in [input_window_info_proto] *)

val input_window_info_proto_set_can_receive_keys : input_window_info_proto -> bool -> unit
  (** set field can_receive_keys in input_window_info_proto *)

val input_window_info_proto_has_focusable : input_window_info_proto -> bool
  (** presence of field "focusable" in [input_window_info_proto] *)

val input_window_info_proto_set_focusable : input_window_info_proto -> bool -> unit
  (** set field focusable in input_window_info_proto *)

val input_window_info_proto_has_has_wallpaper : input_window_info_proto -> bool
  (** presence of field "has_wallpaper" in [input_window_info_proto] *)

val input_window_info_proto_set_has_wallpaper : input_window_info_proto -> bool -> unit
  (** set field has_wallpaper in input_window_info_proto *)

val input_window_info_proto_has_global_scale_factor : input_window_info_proto -> bool
  (** presence of field "global_scale_factor" in [input_window_info_proto] *)

val input_window_info_proto_set_global_scale_factor : input_window_info_proto -> float -> unit
  (** set field global_scale_factor in input_window_info_proto *)

val input_window_info_proto_has_window_x_scale : input_window_info_proto -> bool
  (** presence of field "window_x_scale" in [input_window_info_proto] *)

val input_window_info_proto_set_window_x_scale : input_window_info_proto -> float -> unit
  (** set field window_x_scale in input_window_info_proto *)

val input_window_info_proto_has_window_y_scale : input_window_info_proto -> bool
  (** presence of field "window_y_scale" in [input_window_info_proto] *)

val input_window_info_proto_set_window_y_scale : input_window_info_proto -> float -> unit
  (** set field window_y_scale in input_window_info_proto *)

val input_window_info_proto_has_crop_layer_id : input_window_info_proto -> bool
  (** presence of field "crop_layer_id" in [input_window_info_proto] *)

val input_window_info_proto_set_crop_layer_id : input_window_info_proto -> int32 -> unit
  (** set field crop_layer_id in input_window_info_proto *)

val input_window_info_proto_has_replace_touchable_region_with_crop : input_window_info_proto -> bool
  (** presence of field "replace_touchable_region_with_crop" in [input_window_info_proto] *)

val input_window_info_proto_set_replace_touchable_region_with_crop : input_window_info_proto -> bool -> unit
  (** set field replace_touchable_region_with_crop in input_window_info_proto *)

val input_window_info_proto_set_touchable_region_crop : input_window_info_proto -> rect_proto -> unit
  (** set field touchable_region_crop in input_window_info_proto *)

val input_window_info_proto_set_transform : input_window_info_proto -> transform_proto -> unit
  (** set field transform in input_window_info_proto *)

val input_window_info_proto_has_input_config : input_window_info_proto -> bool
  (** presence of field "input_config" in [input_window_info_proto] *)

val input_window_info_proto_set_input_config : input_window_info_proto -> int32 -> unit
  (** set field input_config in input_window_info_proto *)

val make_blur_region : 
  ?blur_radius:int32 ->
  ?corner_radius_tl:int32 ->
  ?corner_radius_tr:int32 ->
  ?corner_radius_bl:int32 ->
  ?corner_radius_br:float ->
  ?corner_radius_tlx:float ->
  ?corner_radius_tly:float ->
  ?corner_radius_trx:float ->
  ?corner_radius_try:float ->
  ?corner_radius_blx:float ->
  ?corner_radius_bly:float ->
  ?corner_radius_brx:float ->
  ?corner_radius_bry:float ->
  ?alpha:float ->
  ?left:int32 ->
  ?top:int32 ->
  ?right:int32 ->
  ?bottom:int32 ->
  unit ->
  blur_region
(** [make_blur_region … ()] is a builder for type [blur_region] *)

val copy_blur_region : blur_region -> blur_region

val blur_region_has_blur_radius : blur_region -> bool
  (** presence of field "blur_radius" in [blur_region] *)

val blur_region_set_blur_radius : blur_region -> int32 -> unit
  (** set field blur_radius in blur_region *)

val blur_region_has_corner_radius_tl : blur_region -> bool
  (** presence of field "corner_radius_tl" in [blur_region] *)

val blur_region_set_corner_radius_tl : blur_region -> int32 -> unit
  (** set field corner_radius_tl in blur_region *)

val blur_region_has_corner_radius_tr : blur_region -> bool
  (** presence of field "corner_radius_tr" in [blur_region] *)

val blur_region_set_corner_radius_tr : blur_region -> int32 -> unit
  (** set field corner_radius_tr in blur_region *)

val blur_region_has_corner_radius_bl : blur_region -> bool
  (** presence of field "corner_radius_bl" in [blur_region] *)

val blur_region_set_corner_radius_bl : blur_region -> int32 -> unit
  (** set field corner_radius_bl in blur_region *)

val blur_region_has_corner_radius_br : blur_region -> bool
  (** presence of field "corner_radius_br" in [blur_region] *)

val blur_region_set_corner_radius_br : blur_region -> float -> unit
  (** set field corner_radius_br in blur_region *)

val blur_region_has_corner_radius_tlx : blur_region -> bool
  (** presence of field "corner_radius_tlx" in [blur_region] *)

val blur_region_set_corner_radius_tlx : blur_region -> float -> unit
  (** set field corner_radius_tlx in blur_region *)

val blur_region_has_corner_radius_tly : blur_region -> bool
  (** presence of field "corner_radius_tly" in [blur_region] *)

val blur_region_set_corner_radius_tly : blur_region -> float -> unit
  (** set field corner_radius_tly in blur_region *)

val blur_region_has_corner_radius_trx : blur_region -> bool
  (** presence of field "corner_radius_trx" in [blur_region] *)

val blur_region_set_corner_radius_trx : blur_region -> float -> unit
  (** set field corner_radius_trx in blur_region *)

val blur_region_has_corner_radius_try : blur_region -> bool
  (** presence of field "corner_radius_try" in [blur_region] *)

val blur_region_set_corner_radius_try : blur_region -> float -> unit
  (** set field corner_radius_try in blur_region *)

val blur_region_has_corner_radius_blx : blur_region -> bool
  (** presence of field "corner_radius_blx" in [blur_region] *)

val blur_region_set_corner_radius_blx : blur_region -> float -> unit
  (** set field corner_radius_blx in blur_region *)

val blur_region_has_corner_radius_bly : blur_region -> bool
  (** presence of field "corner_radius_bly" in [blur_region] *)

val blur_region_set_corner_radius_bly : blur_region -> float -> unit
  (** set field corner_radius_bly in blur_region *)

val blur_region_has_corner_radius_brx : blur_region -> bool
  (** presence of field "corner_radius_brx" in [blur_region] *)

val blur_region_set_corner_radius_brx : blur_region -> float -> unit
  (** set field corner_radius_brx in blur_region *)

val blur_region_has_corner_radius_bry : blur_region -> bool
  (** presence of field "corner_radius_bry" in [blur_region] *)

val blur_region_set_corner_radius_bry : blur_region -> float -> unit
  (** set field corner_radius_bry in blur_region *)

val blur_region_has_alpha : blur_region -> bool
  (** presence of field "alpha" in [blur_region] *)

val blur_region_set_alpha : blur_region -> float -> unit
  (** set field alpha in blur_region *)

val blur_region_has_left : blur_region -> bool
  (** presence of field "left" in [blur_region] *)

val blur_region_set_left : blur_region -> int32 -> unit
  (** set field left in blur_region *)

val blur_region_has_top : blur_region -> bool
  (** presence of field "top" in [blur_region] *)

val blur_region_set_top : blur_region -> int32 -> unit
  (** set field top in blur_region *)

val blur_region_has_right : blur_region -> bool
  (** presence of field "right" in [blur_region] *)

val blur_region_set_right : blur_region -> int32 -> unit
  (** set field right in blur_region *)

val blur_region_has_bottom : blur_region -> bool
  (** presence of field "bottom" in [blur_region] *)

val blur_region_set_bottom : blur_region -> int32 -> unit
  (** set field bottom in blur_region *)

val make_color_transform_proto : 
  ?val_:float list ->
  unit ->
  color_transform_proto
(** [make_color_transform_proto … ()] is a builder for type [color_transform_proto] *)

val copy_color_transform_proto : color_transform_proto -> color_transform_proto

val color_transform_proto_set_val_ : color_transform_proto -> float list -> unit
  (** set field val_ in color_transform_proto *)

val make_box_shadow_settings_box_shadow_params : 
  ?blur_radius:float ->
  ?spread_radius:float ->
  ?color:int32 ->
  ?offset_x:float ->
  ?offset_y:float ->
  unit ->
  box_shadow_settings_box_shadow_params
(** [make_box_shadow_settings_box_shadow_params … ()] is a builder for type [box_shadow_settings_box_shadow_params] *)

val copy_box_shadow_settings_box_shadow_params : box_shadow_settings_box_shadow_params -> box_shadow_settings_box_shadow_params

val box_shadow_settings_box_shadow_params_has_blur_radius : box_shadow_settings_box_shadow_params -> bool
  (** presence of field "blur_radius" in [box_shadow_settings_box_shadow_params] *)

val box_shadow_settings_box_shadow_params_set_blur_radius : box_shadow_settings_box_shadow_params -> float -> unit
  (** set field blur_radius in box_shadow_settings_box_shadow_params *)

val box_shadow_settings_box_shadow_params_has_spread_radius : box_shadow_settings_box_shadow_params -> bool
  (** presence of field "spread_radius" in [box_shadow_settings_box_shadow_params] *)

val box_shadow_settings_box_shadow_params_set_spread_radius : box_shadow_settings_box_shadow_params -> float -> unit
  (** set field spread_radius in box_shadow_settings_box_shadow_params *)

val box_shadow_settings_box_shadow_params_has_color : box_shadow_settings_box_shadow_params -> bool
  (** presence of field "color" in [box_shadow_settings_box_shadow_params] *)

val box_shadow_settings_box_shadow_params_set_color : box_shadow_settings_box_shadow_params -> int32 -> unit
  (** set field color in box_shadow_settings_box_shadow_params *)

val box_shadow_settings_box_shadow_params_has_offset_x : box_shadow_settings_box_shadow_params -> bool
  (** presence of field "offset_x" in [box_shadow_settings_box_shadow_params] *)

val box_shadow_settings_box_shadow_params_set_offset_x : box_shadow_settings_box_shadow_params -> float -> unit
  (** set field offset_x in box_shadow_settings_box_shadow_params *)

val box_shadow_settings_box_shadow_params_has_offset_y : box_shadow_settings_box_shadow_params -> bool
  (** presence of field "offset_y" in [box_shadow_settings_box_shadow_params] *)

val box_shadow_settings_box_shadow_params_set_offset_y : box_shadow_settings_box_shadow_params -> float -> unit
  (** set field offset_y in box_shadow_settings_box_shadow_params *)

val make_box_shadow_settings : 
  ?box_shadows:box_shadow_settings_box_shadow_params list ->
  unit ->
  box_shadow_settings
(** [make_box_shadow_settings … ()] is a builder for type [box_shadow_settings] *)

val copy_box_shadow_settings : box_shadow_settings -> box_shadow_settings

val box_shadow_settings_set_box_shadows : box_shadow_settings -> box_shadow_settings_box_shadow_params list -> unit
  (** set field box_shadows in box_shadow_settings *)

val make_border_settings : 
  ?stroke_width:float ->
  ?color:int32 ->
  unit ->
  border_settings
(** [make_border_settings … ()] is a builder for type [border_settings] *)

val copy_border_settings : border_settings -> border_settings

val border_settings_has_stroke_width : border_settings -> bool
  (** presence of field "stroke_width" in [border_settings] *)

val border_settings_set_stroke_width : border_settings -> float -> unit
  (** set field stroke_width in border_settings *)

val border_settings_has_color : border_settings -> bool
  (** presence of field "color" in [border_settings] *)

val border_settings_set_color : border_settings -> int32 -> unit
  (** set field color in border_settings *)

val make_position_proto : 
  ?x:float ->
  ?y:float ->
  unit ->
  position_proto
(** [make_position_proto … ()] is a builder for type [position_proto] *)

val copy_position_proto : position_proto -> position_proto

val position_proto_has_x : position_proto -> bool
  (** presence of field "x" in [position_proto] *)

val position_proto_set_x : position_proto -> float -> unit
  (** set field x in position_proto *)

val position_proto_has_y : position_proto -> bool
  (** presence of field "y" in [position_proto] *)

val position_proto_set_y : position_proto -> float -> unit
  (** set field y in position_proto *)

val make_active_buffer_proto : 
  ?width:int32 ->
  ?height:int32 ->
  ?stride:int32 ->
  ?format:int32 ->
  ?usage:int64 ->
  unit ->
  active_buffer_proto
(** [make_active_buffer_proto … ()] is a builder for type [active_buffer_proto] *)

val copy_active_buffer_proto : active_buffer_proto -> active_buffer_proto

val active_buffer_proto_has_width : active_buffer_proto -> bool
  (** presence of field "width" in [active_buffer_proto] *)

val active_buffer_proto_set_width : active_buffer_proto -> int32 -> unit
  (** set field width in active_buffer_proto *)

val active_buffer_proto_has_height : active_buffer_proto -> bool
  (** presence of field "height" in [active_buffer_proto] *)

val active_buffer_proto_set_height : active_buffer_proto -> int32 -> unit
  (** set field height in active_buffer_proto *)

val active_buffer_proto_has_stride : active_buffer_proto -> bool
  (** presence of field "stride" in [active_buffer_proto] *)

val active_buffer_proto_set_stride : active_buffer_proto -> int32 -> unit
  (** set field stride in active_buffer_proto *)

val active_buffer_proto_has_format : active_buffer_proto -> bool
  (** presence of field "format" in [active_buffer_proto] *)

val active_buffer_proto_set_format : active_buffer_proto -> int32 -> unit
  (** set field format in active_buffer_proto *)

val active_buffer_proto_has_usage : active_buffer_proto -> bool
  (** presence of field "usage" in [active_buffer_proto] *)

val active_buffer_proto_set_usage : active_buffer_proto -> int64 -> unit
  (** set field usage in active_buffer_proto *)

val make_float_rect_proto : 
  ?left:float ->
  ?top:float ->
  ?right:float ->
  ?bottom:float ->
  unit ->
  float_rect_proto
(** [make_float_rect_proto … ()] is a builder for type [float_rect_proto] *)

val copy_float_rect_proto : float_rect_proto -> float_rect_proto

val float_rect_proto_has_left : float_rect_proto -> bool
  (** presence of field "left" in [float_rect_proto] *)

val float_rect_proto_set_left : float_rect_proto -> float -> unit
  (** set field left in float_rect_proto *)

val float_rect_proto_has_top : float_rect_proto -> bool
  (** presence of field "top" in [float_rect_proto] *)

val float_rect_proto_set_top : float_rect_proto -> float -> unit
  (** set field top in float_rect_proto *)

val float_rect_proto_has_right : float_rect_proto -> bool
  (** presence of field "right" in [float_rect_proto] *)

val float_rect_proto_set_right : float_rect_proto -> float -> unit
  (** set field right in float_rect_proto *)

val float_rect_proto_has_bottom : float_rect_proto -> bool
  (** presence of field "bottom" in [float_rect_proto] *)

val float_rect_proto_set_bottom : float_rect_proto -> float -> unit
  (** set field bottom in float_rect_proto *)

val make_barrier_layer_proto : 
  ?id:int32 ->
  ?frame_number:int64 ->
  unit ->
  barrier_layer_proto
(** [make_barrier_layer_proto … ()] is a builder for type [barrier_layer_proto] *)

val copy_barrier_layer_proto : barrier_layer_proto -> barrier_layer_proto

val barrier_layer_proto_has_id : barrier_layer_proto -> bool
  (** presence of field "id" in [barrier_layer_proto] *)

val barrier_layer_proto_set_id : barrier_layer_proto -> int32 -> unit
  (** set field id in barrier_layer_proto *)

val barrier_layer_proto_has_frame_number : barrier_layer_proto -> bool
  (** presence of field "frame_number" in [barrier_layer_proto] *)

val barrier_layer_proto_set_frame_number : barrier_layer_proto -> int64 -> unit
  (** set field frame_number in barrier_layer_proto *)

val make_corner_radii_proto : 
  ?tl:float ->
  ?tr:float ->
  ?bl:float ->
  ?br:float ->
  unit ->
  corner_radii_proto
(** [make_corner_radii_proto … ()] is a builder for type [corner_radii_proto] *)

val copy_corner_radii_proto : corner_radii_proto -> corner_radii_proto

val corner_radii_proto_has_tl : corner_radii_proto -> bool
  (** presence of field "tl" in [corner_radii_proto] *)

val corner_radii_proto_set_tl : corner_radii_proto -> float -> unit
  (** set field tl in corner_radii_proto *)

val corner_radii_proto_has_tr : corner_radii_proto -> bool
  (** presence of field "tr" in [corner_radii_proto] *)

val corner_radii_proto_set_tr : corner_radii_proto -> float -> unit
  (** set field tr in corner_radii_proto *)

val corner_radii_proto_has_bl : corner_radii_proto -> bool
  (** presence of field "bl" in [corner_radii_proto] *)

val corner_radii_proto_set_bl : corner_radii_proto -> float -> unit
  (** set field bl in corner_radii_proto *)

val corner_radii_proto_has_br : corner_radii_proto -> bool
  (** presence of field "br" in [corner_radii_proto] *)

val corner_radii_proto_set_br : corner_radii_proto -> float -> unit
  (** set field br in corner_radii_proto *)

val make_layer_proto : 
  ?id:int32 ->
  ?name:string ->
  ?children:int32 list ->
  ?relatives:int32 list ->
  ?type_:string ->
  ?transparent_region:region_proto ->
  ?visible_region:region_proto ->
  ?damage_region:region_proto ->
  ?layer_stack:int32 ->
  ?z:int32 ->
  ?position:position_proto ->
  ?requested_position:position_proto ->
  ?size:size_proto ->
  ?crop:rect_proto ->
  ?final_crop:rect_proto ->
  ?is_opaque:bool ->
  ?invalidate:bool ->
  ?dataspace:string ->
  ?pixel_format:string ->
  ?color:color_proto ->
  ?requested_color:color_proto ->
  ?flags:int32 ->
  ?transform:transform_proto ->
  ?requested_transform:transform_proto ->
  ?parent:int32 ->
  ?z_order_relative_of:int32 ->
  ?active_buffer:active_buffer_proto ->
  ?queued_frames:int32 ->
  ?refresh_pending:bool ->
  ?hwc_frame:rect_proto ->
  ?hwc_crop:float_rect_proto ->
  ?hwc_transform:int32 ->
  ?window_type:int32 ->
  ?app_id:int32 ->
  ?hwc_composition_type:hwc_composition_type ->
  ?is_protected:bool ->
  ?curr_frame:int64 ->
  ?barrier_layer:barrier_layer_proto list ->
  ?buffer_transform:transform_proto ->
  ?effective_scaling_mode:int32 ->
  ?corner_radius:float ->
  ?metadata:(int32 * string) list ->
  ?effective_transform:transform_proto ->
  ?source_bounds:float_rect_proto ->
  ?bounds:float_rect_proto ->
  ?screen_bounds:float_rect_proto ->
  ?input_window_info:input_window_info_proto ->
  ?corner_radius_crop:float_rect_proto ->
  ?shadow_radius:float ->
  ?color_transform:color_transform_proto ->
  ?is_relative_of:bool ->
  ?background_blur_radius:int32 ->
  ?owner_uid:int32 ->
  ?blur_regions:blur_region list ->
  ?is_trusted_overlay:bool ->
  ?requested_corner_radius:float ->
  ?destination_frame:rect_proto ->
  ?original_id:int32 ->
  ?trusted_overlay:trusted_overlay ->
  ?background_blur_scale:float ->
  ?corner_radii:corner_radii_proto ->
  ?requested_corner_radii:corner_radii_proto ->
  ?client_drawn_corner_radii:corner_radii_proto ->
  ?system_content_priority:int32 ->
  ?box_shadow_settings:box_shadow_settings ->
  ?border_settings:border_settings ->
  ?effective_radii:corner_radii_proto ->
  unit ->
  layer_proto
(** [make_layer_proto … ()] is a builder for type [layer_proto] *)

val copy_layer_proto : layer_proto -> layer_proto

val layer_proto_has_id : layer_proto -> bool
  (** presence of field "id" in [layer_proto] *)

val layer_proto_set_id : layer_proto -> int32 -> unit
  (** set field id in layer_proto *)

val layer_proto_has_name : layer_proto -> bool
  (** presence of field "name" in [layer_proto] *)

val layer_proto_set_name : layer_proto -> string -> unit
  (** set field name in layer_proto *)

val layer_proto_set_children : layer_proto -> int32 list -> unit
  (** set field children in layer_proto *)

val layer_proto_set_relatives : layer_proto -> int32 list -> unit
  (** set field relatives in layer_proto *)

val layer_proto_has_type_ : layer_proto -> bool
  (** presence of field "type_" in [layer_proto] *)

val layer_proto_set_type_ : layer_proto -> string -> unit
  (** set field type_ in layer_proto *)

val layer_proto_set_transparent_region : layer_proto -> region_proto -> unit
  (** set field transparent_region in layer_proto *)

val layer_proto_set_visible_region : layer_proto -> region_proto -> unit
  (** set field visible_region in layer_proto *)

val layer_proto_set_damage_region : layer_proto -> region_proto -> unit
  (** set field damage_region in layer_proto *)

val layer_proto_has_layer_stack : layer_proto -> bool
  (** presence of field "layer_stack" in [layer_proto] *)

val layer_proto_set_layer_stack : layer_proto -> int32 -> unit
  (** set field layer_stack in layer_proto *)

val layer_proto_has_z : layer_proto -> bool
  (** presence of field "z" in [layer_proto] *)

val layer_proto_set_z : layer_proto -> int32 -> unit
  (** set field z in layer_proto *)

val layer_proto_set_position : layer_proto -> position_proto -> unit
  (** set field position in layer_proto *)

val layer_proto_set_requested_position : layer_proto -> position_proto -> unit
  (** set field requested_position in layer_proto *)

val layer_proto_set_size : layer_proto -> size_proto -> unit
  (** set field size in layer_proto *)

val layer_proto_set_crop : layer_proto -> rect_proto -> unit
  (** set field crop in layer_proto *)

val layer_proto_set_final_crop : layer_proto -> rect_proto -> unit
  (** set field final_crop in layer_proto *)

val layer_proto_has_is_opaque : layer_proto -> bool
  (** presence of field "is_opaque" in [layer_proto] *)

val layer_proto_set_is_opaque : layer_proto -> bool -> unit
  (** set field is_opaque in layer_proto *)

val layer_proto_has_invalidate : layer_proto -> bool
  (** presence of field "invalidate" in [layer_proto] *)

val layer_proto_set_invalidate : layer_proto -> bool -> unit
  (** set field invalidate in layer_proto *)

val layer_proto_has_dataspace : layer_proto -> bool
  (** presence of field "dataspace" in [layer_proto] *)

val layer_proto_set_dataspace : layer_proto -> string -> unit
  (** set field dataspace in layer_proto *)

val layer_proto_has_pixel_format : layer_proto -> bool
  (** presence of field "pixel_format" in [layer_proto] *)

val layer_proto_set_pixel_format : layer_proto -> string -> unit
  (** set field pixel_format in layer_proto *)

val layer_proto_set_color : layer_proto -> color_proto -> unit
  (** set field color in layer_proto *)

val layer_proto_set_requested_color : layer_proto -> color_proto -> unit
  (** set field requested_color in layer_proto *)

val layer_proto_has_flags : layer_proto -> bool
  (** presence of field "flags" in [layer_proto] *)

val layer_proto_set_flags : layer_proto -> int32 -> unit
  (** set field flags in layer_proto *)

val layer_proto_set_transform : layer_proto -> transform_proto -> unit
  (** set field transform in layer_proto *)

val layer_proto_set_requested_transform : layer_proto -> transform_proto -> unit
  (** set field requested_transform in layer_proto *)

val layer_proto_has_parent : layer_proto -> bool
  (** presence of field "parent" in [layer_proto] *)

val layer_proto_set_parent : layer_proto -> int32 -> unit
  (** set field parent in layer_proto *)

val layer_proto_has_z_order_relative_of : layer_proto -> bool
  (** presence of field "z_order_relative_of" in [layer_proto] *)

val layer_proto_set_z_order_relative_of : layer_proto -> int32 -> unit
  (** set field z_order_relative_of in layer_proto *)

val layer_proto_set_active_buffer : layer_proto -> active_buffer_proto -> unit
  (** set field active_buffer in layer_proto *)

val layer_proto_has_queued_frames : layer_proto -> bool
  (** presence of field "queued_frames" in [layer_proto] *)

val layer_proto_set_queued_frames : layer_proto -> int32 -> unit
  (** set field queued_frames in layer_proto *)

val layer_proto_has_refresh_pending : layer_proto -> bool
  (** presence of field "refresh_pending" in [layer_proto] *)

val layer_proto_set_refresh_pending : layer_proto -> bool -> unit
  (** set field refresh_pending in layer_proto *)

val layer_proto_set_hwc_frame : layer_proto -> rect_proto -> unit
  (** set field hwc_frame in layer_proto *)

val layer_proto_set_hwc_crop : layer_proto -> float_rect_proto -> unit
  (** set field hwc_crop in layer_proto *)

val layer_proto_has_hwc_transform : layer_proto -> bool
  (** presence of field "hwc_transform" in [layer_proto] *)

val layer_proto_set_hwc_transform : layer_proto -> int32 -> unit
  (** set field hwc_transform in layer_proto *)

val layer_proto_has_window_type : layer_proto -> bool
  (** presence of field "window_type" in [layer_proto] *)

val layer_proto_set_window_type : layer_proto -> int32 -> unit
  (** set field window_type in layer_proto *)

val layer_proto_has_app_id : layer_proto -> bool
  (** presence of field "app_id" in [layer_proto] *)

val layer_proto_set_app_id : layer_proto -> int32 -> unit
  (** set field app_id in layer_proto *)

val layer_proto_has_hwc_composition_type : layer_proto -> bool
  (** presence of field "hwc_composition_type" in [layer_proto] *)

val layer_proto_set_hwc_composition_type : layer_proto -> hwc_composition_type -> unit
  (** set field hwc_composition_type in layer_proto *)

val layer_proto_has_is_protected : layer_proto -> bool
  (** presence of field "is_protected" in [layer_proto] *)

val layer_proto_set_is_protected : layer_proto -> bool -> unit
  (** set field is_protected in layer_proto *)

val layer_proto_has_curr_frame : layer_proto -> bool
  (** presence of field "curr_frame" in [layer_proto] *)

val layer_proto_set_curr_frame : layer_proto -> int64 -> unit
  (** set field curr_frame in layer_proto *)

val layer_proto_set_barrier_layer : layer_proto -> barrier_layer_proto list -> unit
  (** set field barrier_layer in layer_proto *)

val layer_proto_set_buffer_transform : layer_proto -> transform_proto -> unit
  (** set field buffer_transform in layer_proto *)

val layer_proto_has_effective_scaling_mode : layer_proto -> bool
  (** presence of field "effective_scaling_mode" in [layer_proto] *)

val layer_proto_set_effective_scaling_mode : layer_proto -> int32 -> unit
  (** set field effective_scaling_mode in layer_proto *)

val layer_proto_has_corner_radius : layer_proto -> bool
  (** presence of field "corner_radius" in [layer_proto] *)

val layer_proto_set_corner_radius : layer_proto -> float -> unit
  (** set field corner_radius in layer_proto *)

val layer_proto_set_metadata : layer_proto -> (int32 * string) list -> unit
  (** set field metadata in layer_proto *)

val layer_proto_set_effective_transform : layer_proto -> transform_proto -> unit
  (** set field effective_transform in layer_proto *)

val layer_proto_set_source_bounds : layer_proto -> float_rect_proto -> unit
  (** set field source_bounds in layer_proto *)

val layer_proto_set_bounds : layer_proto -> float_rect_proto -> unit
  (** set field bounds in layer_proto *)

val layer_proto_set_screen_bounds : layer_proto -> float_rect_proto -> unit
  (** set field screen_bounds in layer_proto *)

val layer_proto_set_input_window_info : layer_proto -> input_window_info_proto -> unit
  (** set field input_window_info in layer_proto *)

val layer_proto_set_corner_radius_crop : layer_proto -> float_rect_proto -> unit
  (** set field corner_radius_crop in layer_proto *)

val layer_proto_has_shadow_radius : layer_proto -> bool
  (** presence of field "shadow_radius" in [layer_proto] *)

val layer_proto_set_shadow_radius : layer_proto -> float -> unit
  (** set field shadow_radius in layer_proto *)

val layer_proto_set_color_transform : layer_proto -> color_transform_proto -> unit
  (** set field color_transform in layer_proto *)

val layer_proto_has_is_relative_of : layer_proto -> bool
  (** presence of field "is_relative_of" in [layer_proto] *)

val layer_proto_set_is_relative_of : layer_proto -> bool -> unit
  (** set field is_relative_of in layer_proto *)

val layer_proto_has_background_blur_radius : layer_proto -> bool
  (** presence of field "background_blur_radius" in [layer_proto] *)

val layer_proto_set_background_blur_radius : layer_proto -> int32 -> unit
  (** set field background_blur_radius in layer_proto *)

val layer_proto_has_owner_uid : layer_proto -> bool
  (** presence of field "owner_uid" in [layer_proto] *)

val layer_proto_set_owner_uid : layer_proto -> int32 -> unit
  (** set field owner_uid in layer_proto *)

val layer_proto_set_blur_regions : layer_proto -> blur_region list -> unit
  (** set field blur_regions in layer_proto *)

val layer_proto_has_is_trusted_overlay : layer_proto -> bool
  (** presence of field "is_trusted_overlay" in [layer_proto] *)

val layer_proto_set_is_trusted_overlay : layer_proto -> bool -> unit
  (** set field is_trusted_overlay in layer_proto *)

val layer_proto_has_requested_corner_radius : layer_proto -> bool
  (** presence of field "requested_corner_radius" in [layer_proto] *)

val layer_proto_set_requested_corner_radius : layer_proto -> float -> unit
  (** set field requested_corner_radius in layer_proto *)

val layer_proto_set_destination_frame : layer_proto -> rect_proto -> unit
  (** set field destination_frame in layer_proto *)

val layer_proto_has_original_id : layer_proto -> bool
  (** presence of field "original_id" in [layer_proto] *)

val layer_proto_set_original_id : layer_proto -> int32 -> unit
  (** set field original_id in layer_proto *)

val layer_proto_has_trusted_overlay : layer_proto -> bool
  (** presence of field "trusted_overlay" in [layer_proto] *)

val layer_proto_set_trusted_overlay : layer_proto -> trusted_overlay -> unit
  (** set field trusted_overlay in layer_proto *)

val layer_proto_has_background_blur_scale : layer_proto -> bool
  (** presence of field "background_blur_scale" in [layer_proto] *)

val layer_proto_set_background_blur_scale : layer_proto -> float -> unit
  (** set field background_blur_scale in layer_proto *)

val layer_proto_set_corner_radii : layer_proto -> corner_radii_proto -> unit
  (** set field corner_radii in layer_proto *)

val layer_proto_set_requested_corner_radii : layer_proto -> corner_radii_proto -> unit
  (** set field requested_corner_radii in layer_proto *)

val layer_proto_set_client_drawn_corner_radii : layer_proto -> corner_radii_proto -> unit
  (** set field client_drawn_corner_radii in layer_proto *)

val layer_proto_has_system_content_priority : layer_proto -> bool
  (** presence of field "system_content_priority" in [layer_proto] *)

val layer_proto_set_system_content_priority : layer_proto -> int32 -> unit
  (** set field system_content_priority in layer_proto *)

val layer_proto_set_box_shadow_settings : layer_proto -> box_shadow_settings -> unit
  (** set field box_shadow_settings in layer_proto *)

val layer_proto_set_border_settings : layer_proto -> border_settings -> unit
  (** set field border_settings in layer_proto *)

val layer_proto_set_effective_radii : layer_proto -> corner_radii_proto -> unit
  (** set field effective_radii in layer_proto *)

val make_layers_proto : 
  ?layers:layer_proto list ->
  unit ->
  layers_proto
(** [make_layers_proto … ()] is a builder for type [layers_proto] *)

val copy_layers_proto : layers_proto -> layers_proto

val layers_proto_set_layers : layers_proto -> layer_proto list -> unit
  (** set field layers in layers_proto *)

val make_display_proto : 
  ?id:int64 ->
  ?name:string ->
  ?layer_stack:int32 ->
  ?size:size_proto ->
  ?layer_stack_space_rect:rect_proto ->
  ?transform:transform_proto ->
  ?is_virtual:bool ->
  ?dpi_x:float ->
  ?dpi_y:float ->
  unit ->
  display_proto
(** [make_display_proto … ()] is a builder for type [display_proto] *)

val copy_display_proto : display_proto -> display_proto

val display_proto_has_id : display_proto -> bool
  (** presence of field "id" in [display_proto] *)

val display_proto_set_id : display_proto -> int64 -> unit
  (** set field id in display_proto *)

val display_proto_has_name : display_proto -> bool
  (** presence of field "name" in [display_proto] *)

val display_proto_set_name : display_proto -> string -> unit
  (** set field name in display_proto *)

val display_proto_has_layer_stack : display_proto -> bool
  (** presence of field "layer_stack" in [display_proto] *)

val display_proto_set_layer_stack : display_proto -> int32 -> unit
  (** set field layer_stack in display_proto *)

val display_proto_set_size : display_proto -> size_proto -> unit
  (** set field size in display_proto *)

val display_proto_set_layer_stack_space_rect : display_proto -> rect_proto -> unit
  (** set field layer_stack_space_rect in display_proto *)

val display_proto_set_transform : display_proto -> transform_proto -> unit
  (** set field transform in display_proto *)

val display_proto_has_is_virtual : display_proto -> bool
  (** presence of field "is_virtual" in [display_proto] *)

val display_proto_set_is_virtual : display_proto -> bool -> unit
  (** set field is_virtual in display_proto *)

val display_proto_has_dpi_x : display_proto -> bool
  (** presence of field "dpi_x" in [display_proto] *)

val display_proto_set_dpi_x : display_proto -> float -> unit
  (** set field dpi_x in display_proto *)

val display_proto_has_dpi_y : display_proto -> bool
  (** presence of field "dpi_y" in [display_proto] *)

val display_proto_set_dpi_y : display_proto -> float -> unit
  (** set field dpi_y in display_proto *)

val make_layers_snapshot_proto : 
  ?elapsed_realtime_nanos:int64 ->
  ?where:string ->
  ?layers:layers_proto ->
  ?hwc_blob:string ->
  ?excludes_composition_state:bool ->
  ?missed_entries:int32 ->
  ?displays:display_proto list ->
  ?vsync_id:int64 ->
  unit ->
  layers_snapshot_proto
(** [make_layers_snapshot_proto … ()] is a builder for type [layers_snapshot_proto] *)

val copy_layers_snapshot_proto : layers_snapshot_proto -> layers_snapshot_proto

val layers_snapshot_proto_has_elapsed_realtime_nanos : layers_snapshot_proto -> bool
  (** presence of field "elapsed_realtime_nanos" in [layers_snapshot_proto] *)

val layers_snapshot_proto_set_elapsed_realtime_nanos : layers_snapshot_proto -> int64 -> unit
  (** set field elapsed_realtime_nanos in layers_snapshot_proto *)

val layers_snapshot_proto_has_where : layers_snapshot_proto -> bool
  (** presence of field "where" in [layers_snapshot_proto] *)

val layers_snapshot_proto_set_where : layers_snapshot_proto -> string -> unit
  (** set field where in layers_snapshot_proto *)

val layers_snapshot_proto_set_layers : layers_snapshot_proto -> layers_proto -> unit
  (** set field layers in layers_snapshot_proto *)

val layers_snapshot_proto_has_hwc_blob : layers_snapshot_proto -> bool
  (** presence of field "hwc_blob" in [layers_snapshot_proto] *)

val layers_snapshot_proto_set_hwc_blob : layers_snapshot_proto -> string -> unit
  (** set field hwc_blob in layers_snapshot_proto *)

val layers_snapshot_proto_has_excludes_composition_state : layers_snapshot_proto -> bool
  (** presence of field "excludes_composition_state" in [layers_snapshot_proto] *)

val layers_snapshot_proto_set_excludes_composition_state : layers_snapshot_proto -> bool -> unit
  (** set field excludes_composition_state in layers_snapshot_proto *)

val layers_snapshot_proto_has_missed_entries : layers_snapshot_proto -> bool
  (** presence of field "missed_entries" in [layers_snapshot_proto] *)

val layers_snapshot_proto_set_missed_entries : layers_snapshot_proto -> int32 -> unit
  (** set field missed_entries in layers_snapshot_proto *)

val layers_snapshot_proto_set_displays : layers_snapshot_proto -> display_proto list -> unit
  (** set field displays in layers_snapshot_proto *)

val layers_snapshot_proto_has_vsync_id : layers_snapshot_proto -> bool
  (** presence of field "vsync_id" in [layers_snapshot_proto] *)

val layers_snapshot_proto_set_vsync_id : layers_snapshot_proto -> int64 -> unit
  (** set field vsync_id in layers_snapshot_proto *)

val make_layers_trace_file_proto : 
  ?magic_number:int64 ->
  ?entry:layers_snapshot_proto list ->
  ?real_to_elapsed_time_offset_nanos:int64 ->
  unit ->
  layers_trace_file_proto
(** [make_layers_trace_file_proto … ()] is a builder for type [layers_trace_file_proto] *)

val copy_layers_trace_file_proto : layers_trace_file_proto -> layers_trace_file_proto

val layers_trace_file_proto_has_magic_number : layers_trace_file_proto -> bool
  (** presence of field "magic_number" in [layers_trace_file_proto] *)

val layers_trace_file_proto_set_magic_number : layers_trace_file_proto -> int64 -> unit
  (** set field magic_number in layers_trace_file_proto *)

val layers_trace_file_proto_set_entry : layers_trace_file_proto -> layers_snapshot_proto list -> unit
  (** set field entry in layers_trace_file_proto *)

val layers_trace_file_proto_has_real_to_elapsed_time_offset_nanos : layers_trace_file_proto -> bool
  (** presence of field "real_to_elapsed_time_offset_nanos" in [layers_trace_file_proto] *)

val layers_trace_file_proto_set_real_to_elapsed_time_offset_nanos : layers_trace_file_proto -> int64 -> unit
  (** set field real_to_elapsed_time_offset_nanos in layers_trace_file_proto *)

val make_layer_state_matrix22 : 
  ?dsdx:float ->
  ?dtdx:float ->
  ?dtdy:float ->
  ?dsdy:float ->
  unit ->
  layer_state_matrix22
(** [make_layer_state_matrix22 … ()] is a builder for type [layer_state_matrix22] *)

val copy_layer_state_matrix22 : layer_state_matrix22 -> layer_state_matrix22

val layer_state_matrix22_has_dsdx : layer_state_matrix22 -> bool
  (** presence of field "dsdx" in [layer_state_matrix22] *)

val layer_state_matrix22_set_dsdx : layer_state_matrix22 -> float -> unit
  (** set field dsdx in layer_state_matrix22 *)

val layer_state_matrix22_has_dtdx : layer_state_matrix22 -> bool
  (** presence of field "dtdx" in [layer_state_matrix22] *)

val layer_state_matrix22_set_dtdx : layer_state_matrix22 -> float -> unit
  (** set field dtdx in layer_state_matrix22 *)

val layer_state_matrix22_has_dtdy : layer_state_matrix22 -> bool
  (** presence of field "dtdy" in [layer_state_matrix22] *)

val layer_state_matrix22_set_dtdy : layer_state_matrix22 -> float -> unit
  (** set field dtdy in layer_state_matrix22 *)

val layer_state_matrix22_has_dsdy : layer_state_matrix22 -> bool
  (** presence of field "dsdy" in [layer_state_matrix22] *)

val layer_state_matrix22_set_dsdy : layer_state_matrix22 -> float -> unit
  (** set field dsdy in layer_state_matrix22 *)

val make_layer_state_color3 : 
  ?r:float ->
  ?g:float ->
  ?b:float ->
  unit ->
  layer_state_color3
(** [make_layer_state_color3 … ()] is a builder for type [layer_state_color3] *)

val copy_layer_state_color3 : layer_state_color3 -> layer_state_color3

val layer_state_color3_has_r : layer_state_color3 -> bool
  (** presence of field "r" in [layer_state_color3] *)

val layer_state_color3_set_r : layer_state_color3 -> float -> unit
  (** set field r in layer_state_color3 *)

val layer_state_color3_has_g : layer_state_color3 -> bool
  (** presence of field "g" in [layer_state_color3] *)

val layer_state_color3_set_g : layer_state_color3 -> float -> unit
  (** set field g in layer_state_color3 *)

val layer_state_color3_has_b : layer_state_color3 -> bool
  (** presence of field "b" in [layer_state_color3] *)

val layer_state_color3_set_b : layer_state_color3 -> float -> unit
  (** set field b in layer_state_color3 *)

val make_layer_state_buffer_data : 
  ?buffer_id:int64 ->
  ?width:int32 ->
  ?height:int32 ->
  ?frame_number:int64 ->
  ?flags:int32 ->
  ?cached_buffer_id:int64 ->
  ?pixel_format:layer_state_buffer_data_pixel_format ->
  ?usage:int64 ->
  unit ->
  layer_state_buffer_data
(** [make_layer_state_buffer_data … ()] is a builder for type [layer_state_buffer_data] *)

val copy_layer_state_buffer_data : layer_state_buffer_data -> layer_state_buffer_data

val layer_state_buffer_data_has_buffer_id : layer_state_buffer_data -> bool
  (** presence of field "buffer_id" in [layer_state_buffer_data] *)

val layer_state_buffer_data_set_buffer_id : layer_state_buffer_data -> int64 -> unit
  (** set field buffer_id in layer_state_buffer_data *)

val layer_state_buffer_data_has_width : layer_state_buffer_data -> bool
  (** presence of field "width" in [layer_state_buffer_data] *)

val layer_state_buffer_data_set_width : layer_state_buffer_data -> int32 -> unit
  (** set field width in layer_state_buffer_data *)

val layer_state_buffer_data_has_height : layer_state_buffer_data -> bool
  (** presence of field "height" in [layer_state_buffer_data] *)

val layer_state_buffer_data_set_height : layer_state_buffer_data -> int32 -> unit
  (** set field height in layer_state_buffer_data *)

val layer_state_buffer_data_has_frame_number : layer_state_buffer_data -> bool
  (** presence of field "frame_number" in [layer_state_buffer_data] *)

val layer_state_buffer_data_set_frame_number : layer_state_buffer_data -> int64 -> unit
  (** set field frame_number in layer_state_buffer_data *)

val layer_state_buffer_data_has_flags : layer_state_buffer_data -> bool
  (** presence of field "flags" in [layer_state_buffer_data] *)

val layer_state_buffer_data_set_flags : layer_state_buffer_data -> int32 -> unit
  (** set field flags in layer_state_buffer_data *)

val layer_state_buffer_data_has_cached_buffer_id : layer_state_buffer_data -> bool
  (** presence of field "cached_buffer_id" in [layer_state_buffer_data] *)

val layer_state_buffer_data_set_cached_buffer_id : layer_state_buffer_data -> int64 -> unit
  (** set field cached_buffer_id in layer_state_buffer_data *)

val layer_state_buffer_data_has_pixel_format : layer_state_buffer_data -> bool
  (** presence of field "pixel_format" in [layer_state_buffer_data] *)

val layer_state_buffer_data_set_pixel_format : layer_state_buffer_data -> layer_state_buffer_data_pixel_format -> unit
  (** set field pixel_format in layer_state_buffer_data *)

val layer_state_buffer_data_has_usage : layer_state_buffer_data -> bool
  (** presence of field "usage" in [layer_state_buffer_data] *)

val layer_state_buffer_data_set_usage : layer_state_buffer_data -> int64 -> unit
  (** set field usage in layer_state_buffer_data *)

val make_transform : 
  ?dsdx:float ->
  ?dtdx:float ->
  ?dtdy:float ->
  ?dsdy:float ->
  ?tx:float ->
  ?ty:float ->
  unit ->
  transform
(** [make_transform … ()] is a builder for type [transform] *)

val copy_transform : transform -> transform

val transform_has_dsdx : transform -> bool
  (** presence of field "dsdx" in [transform] *)

val transform_set_dsdx : transform -> float -> unit
  (** set field dsdx in transform *)

val transform_has_dtdx : transform -> bool
  (** presence of field "dtdx" in [transform] *)

val transform_set_dtdx : transform -> float -> unit
  (** set field dtdx in transform *)

val transform_has_dtdy : transform -> bool
  (** presence of field "dtdy" in [transform] *)

val transform_set_dtdy : transform -> float -> unit
  (** set field dtdy in transform *)

val transform_has_dsdy : transform -> bool
  (** presence of field "dsdy" in [transform] *)

val transform_set_dsdy : transform -> float -> unit
  (** set field dsdy in transform *)

val transform_has_tx : transform -> bool
  (** presence of field "tx" in [transform] *)

val transform_set_tx : transform -> float -> unit
  (** set field tx in transform *)

val transform_has_ty : transform -> bool
  (** presence of field "ty" in [transform] *)

val transform_set_ty : transform -> float -> unit
  (** set field ty in transform *)

val make_layer_state_window_info : 
  ?layout_params_flags:int32 ->
  ?layout_params_type:int32 ->
  ?touchable_region:region_proto ->
  ?surface_inset:int32 ->
  ?focusable:bool ->
  ?has_wallpaper:bool ->
  ?global_scale_factor:float ->
  ?crop_layer_id:int32 ->
  ?replace_touchable_region_with_crop:bool ->
  ?touchable_region_crop:rect_proto ->
  ?transform:transform ->
  ?input_config:int32 ->
  unit ->
  layer_state_window_info
(** [make_layer_state_window_info … ()] is a builder for type [layer_state_window_info] *)

val copy_layer_state_window_info : layer_state_window_info -> layer_state_window_info

val layer_state_window_info_has_layout_params_flags : layer_state_window_info -> bool
  (** presence of field "layout_params_flags" in [layer_state_window_info] *)

val layer_state_window_info_set_layout_params_flags : layer_state_window_info -> int32 -> unit
  (** set field layout_params_flags in layer_state_window_info *)

val layer_state_window_info_has_layout_params_type : layer_state_window_info -> bool
  (** presence of field "layout_params_type" in [layer_state_window_info] *)

val layer_state_window_info_set_layout_params_type : layer_state_window_info -> int32 -> unit
  (** set field layout_params_type in layer_state_window_info *)

val layer_state_window_info_set_touchable_region : layer_state_window_info -> region_proto -> unit
  (** set field touchable_region in layer_state_window_info *)

val layer_state_window_info_has_surface_inset : layer_state_window_info -> bool
  (** presence of field "surface_inset" in [layer_state_window_info] *)

val layer_state_window_info_set_surface_inset : layer_state_window_info -> int32 -> unit
  (** set field surface_inset in layer_state_window_info *)

val layer_state_window_info_has_focusable : layer_state_window_info -> bool
  (** presence of field "focusable" in [layer_state_window_info] *)

val layer_state_window_info_set_focusable : layer_state_window_info -> bool -> unit
  (** set field focusable in layer_state_window_info *)

val layer_state_window_info_has_has_wallpaper : layer_state_window_info -> bool
  (** presence of field "has_wallpaper" in [layer_state_window_info] *)

val layer_state_window_info_set_has_wallpaper : layer_state_window_info -> bool -> unit
  (** set field has_wallpaper in layer_state_window_info *)

val layer_state_window_info_has_global_scale_factor : layer_state_window_info -> bool
  (** presence of field "global_scale_factor" in [layer_state_window_info] *)

val layer_state_window_info_set_global_scale_factor : layer_state_window_info -> float -> unit
  (** set field global_scale_factor in layer_state_window_info *)

val layer_state_window_info_has_crop_layer_id : layer_state_window_info -> bool
  (** presence of field "crop_layer_id" in [layer_state_window_info] *)

val layer_state_window_info_set_crop_layer_id : layer_state_window_info -> int32 -> unit
  (** set field crop_layer_id in layer_state_window_info *)

val layer_state_window_info_has_replace_touchable_region_with_crop : layer_state_window_info -> bool
  (** presence of field "replace_touchable_region_with_crop" in [layer_state_window_info] *)

val layer_state_window_info_set_replace_touchable_region_with_crop : layer_state_window_info -> bool -> unit
  (** set field replace_touchable_region_with_crop in layer_state_window_info *)

val layer_state_window_info_set_touchable_region_crop : layer_state_window_info -> rect_proto -> unit
  (** set field touchable_region_crop in layer_state_window_info *)

val layer_state_window_info_set_transform : layer_state_window_info -> transform -> unit
  (** set field transform in layer_state_window_info *)

val layer_state_window_info_has_input_config : layer_state_window_info -> bool
  (** presence of field "input_config" in [layer_state_window_info] *)

val layer_state_window_info_set_input_config : layer_state_window_info -> int32 -> unit
  (** set field input_config in layer_state_window_info *)

val make_layer_state_corner_radii : 
  ?tl:float ->
  ?tr:float ->
  ?bl:float ->
  ?br:float ->
  unit ->
  layer_state_corner_radii
(** [make_layer_state_corner_radii … ()] is a builder for type [layer_state_corner_radii] *)

val copy_layer_state_corner_radii : layer_state_corner_radii -> layer_state_corner_radii

val layer_state_corner_radii_has_tl : layer_state_corner_radii -> bool
  (** presence of field "tl" in [layer_state_corner_radii] *)

val layer_state_corner_radii_set_tl : layer_state_corner_radii -> float -> unit
  (** set field tl in layer_state_corner_radii *)

val layer_state_corner_radii_has_tr : layer_state_corner_radii -> bool
  (** presence of field "tr" in [layer_state_corner_radii] *)

val layer_state_corner_radii_set_tr : layer_state_corner_radii -> float -> unit
  (** set field tr in layer_state_corner_radii *)

val layer_state_corner_radii_has_bl : layer_state_corner_radii -> bool
  (** presence of field "bl" in [layer_state_corner_radii] *)

val layer_state_corner_radii_set_bl : layer_state_corner_radii -> float -> unit
  (** set field bl in layer_state_corner_radii *)

val layer_state_corner_radii_has_br : layer_state_corner_radii -> bool
  (** presence of field "br" in [layer_state_corner_radii] *)

val layer_state_corner_radii_set_br : layer_state_corner_radii -> float -> unit
  (** set field br in layer_state_corner_radii *)

val make_layer_state : 
  ?layer_id:int32 ->
  ?what:int64 ->
  ?x:float ->
  ?y:float ->
  ?z:int32 ->
  ?w:int32 ->
  ?h:int32 ->
  ?layer_stack:int32 ->
  ?flags:int32 ->
  ?mask:int32 ->
  ?matrix:layer_state_matrix22 ->
  ?corner_radius:float ->
  ?background_blur_radius:int32 ->
  ?parent_id:int32 ->
  ?relative_parent_id:int32 ->
  ?alpha:float ->
  ?color:layer_state_color3 ->
  ?transparent_region:region_proto ->
  ?transform:int32 ->
  ?transform_to_display_inverse:bool ->
  ?crop:rect_proto ->
  ?buffer_data:layer_state_buffer_data ->
  ?api:int32 ->
  ?has_sideband_stream:bool ->
  ?color_transform:color_transform_proto ->
  ?blur_regions:blur_region list ->
  ?window_info_handle:layer_state_window_info ->
  ?bg_color_alpha:float ->
  ?bg_color_dataspace:int32 ->
  ?color_space_agnostic:bool ->
  ?shadow_radius:float ->
  ?frame_rate_selection_priority:int32 ->
  ?frame_rate:float ->
  ?frame_rate_compatibility:int32 ->
  ?change_frame_rate_strategy:int32 ->
  ?fixed_transform_hint:int32 ->
  ?frame_number:int64 ->
  ?auto_refresh:bool ->
  ?is_trusted_overlay:bool ->
  ?buffer_crop:rect_proto ->
  ?destination_frame:rect_proto ->
  ?drop_input_mode:layer_state_drop_input_mode ->
  ?trusted_overlay:trusted_overlay ->
  ?background_blur_scale:float ->
  ?corner_radii:layer_state_corner_radii ->
  ?client_drawn_corner_radii:layer_state_corner_radii ->
  ?system_content_priority:int32 ->
  ?box_shadow_settings:box_shadow_settings ->
  ?border_settings:border_settings ->
  unit ->
  layer_state
(** [make_layer_state … ()] is a builder for type [layer_state] *)

val copy_layer_state : layer_state -> layer_state

val layer_state_has_layer_id : layer_state -> bool
  (** presence of field "layer_id" in [layer_state] *)

val layer_state_set_layer_id : layer_state -> int32 -> unit
  (** set field layer_id in layer_state *)

val layer_state_has_what : layer_state -> bool
  (** presence of field "what" in [layer_state] *)

val layer_state_set_what : layer_state -> int64 -> unit
  (** set field what in layer_state *)

val layer_state_has_x : layer_state -> bool
  (** presence of field "x" in [layer_state] *)

val layer_state_set_x : layer_state -> float -> unit
  (** set field x in layer_state *)

val layer_state_has_y : layer_state -> bool
  (** presence of field "y" in [layer_state] *)

val layer_state_set_y : layer_state -> float -> unit
  (** set field y in layer_state *)

val layer_state_has_z : layer_state -> bool
  (** presence of field "z" in [layer_state] *)

val layer_state_set_z : layer_state -> int32 -> unit
  (** set field z in layer_state *)

val layer_state_has_w : layer_state -> bool
  (** presence of field "w" in [layer_state] *)

val layer_state_set_w : layer_state -> int32 -> unit
  (** set field w in layer_state *)

val layer_state_has_h : layer_state -> bool
  (** presence of field "h" in [layer_state] *)

val layer_state_set_h : layer_state -> int32 -> unit
  (** set field h in layer_state *)

val layer_state_has_layer_stack : layer_state -> bool
  (** presence of field "layer_stack" in [layer_state] *)

val layer_state_set_layer_stack : layer_state -> int32 -> unit
  (** set field layer_stack in layer_state *)

val layer_state_has_flags : layer_state -> bool
  (** presence of field "flags" in [layer_state] *)

val layer_state_set_flags : layer_state -> int32 -> unit
  (** set field flags in layer_state *)

val layer_state_has_mask : layer_state -> bool
  (** presence of field "mask" in [layer_state] *)

val layer_state_set_mask : layer_state -> int32 -> unit
  (** set field mask in layer_state *)

val layer_state_set_matrix : layer_state -> layer_state_matrix22 -> unit
  (** set field matrix in layer_state *)

val layer_state_has_corner_radius : layer_state -> bool
  (** presence of field "corner_radius" in [layer_state] *)

val layer_state_set_corner_radius : layer_state -> float -> unit
  (** set field corner_radius in layer_state *)

val layer_state_has_background_blur_radius : layer_state -> bool
  (** presence of field "background_blur_radius" in [layer_state] *)

val layer_state_set_background_blur_radius : layer_state -> int32 -> unit
  (** set field background_blur_radius in layer_state *)

val layer_state_has_parent_id : layer_state -> bool
  (** presence of field "parent_id" in [layer_state] *)

val layer_state_set_parent_id : layer_state -> int32 -> unit
  (** set field parent_id in layer_state *)

val layer_state_has_relative_parent_id : layer_state -> bool
  (** presence of field "relative_parent_id" in [layer_state] *)

val layer_state_set_relative_parent_id : layer_state -> int32 -> unit
  (** set field relative_parent_id in layer_state *)

val layer_state_has_alpha : layer_state -> bool
  (** presence of field "alpha" in [layer_state] *)

val layer_state_set_alpha : layer_state -> float -> unit
  (** set field alpha in layer_state *)

val layer_state_set_color : layer_state -> layer_state_color3 -> unit
  (** set field color in layer_state *)

val layer_state_set_transparent_region : layer_state -> region_proto -> unit
  (** set field transparent_region in layer_state *)

val layer_state_has_transform : layer_state -> bool
  (** presence of field "transform" in [layer_state] *)

val layer_state_set_transform : layer_state -> int32 -> unit
  (** set field transform in layer_state *)

val layer_state_has_transform_to_display_inverse : layer_state -> bool
  (** presence of field "transform_to_display_inverse" in [layer_state] *)

val layer_state_set_transform_to_display_inverse : layer_state -> bool -> unit
  (** set field transform_to_display_inverse in layer_state *)

val layer_state_set_crop : layer_state -> rect_proto -> unit
  (** set field crop in layer_state *)

val layer_state_set_buffer_data : layer_state -> layer_state_buffer_data -> unit
  (** set field buffer_data in layer_state *)

val layer_state_has_api : layer_state -> bool
  (** presence of field "api" in [layer_state] *)

val layer_state_set_api : layer_state -> int32 -> unit
  (** set field api in layer_state *)

val layer_state_has_has_sideband_stream : layer_state -> bool
  (** presence of field "has_sideband_stream" in [layer_state] *)

val layer_state_set_has_sideband_stream : layer_state -> bool -> unit
  (** set field has_sideband_stream in layer_state *)

val layer_state_set_color_transform : layer_state -> color_transform_proto -> unit
  (** set field color_transform in layer_state *)

val layer_state_set_blur_regions : layer_state -> blur_region list -> unit
  (** set field blur_regions in layer_state *)

val layer_state_set_window_info_handle : layer_state -> layer_state_window_info -> unit
  (** set field window_info_handle in layer_state *)

val layer_state_has_bg_color_alpha : layer_state -> bool
  (** presence of field "bg_color_alpha" in [layer_state] *)

val layer_state_set_bg_color_alpha : layer_state -> float -> unit
  (** set field bg_color_alpha in layer_state *)

val layer_state_has_bg_color_dataspace : layer_state -> bool
  (** presence of field "bg_color_dataspace" in [layer_state] *)

val layer_state_set_bg_color_dataspace : layer_state -> int32 -> unit
  (** set field bg_color_dataspace in layer_state *)

val layer_state_has_color_space_agnostic : layer_state -> bool
  (** presence of field "color_space_agnostic" in [layer_state] *)

val layer_state_set_color_space_agnostic : layer_state -> bool -> unit
  (** set field color_space_agnostic in layer_state *)

val layer_state_has_shadow_radius : layer_state -> bool
  (** presence of field "shadow_radius" in [layer_state] *)

val layer_state_set_shadow_radius : layer_state -> float -> unit
  (** set field shadow_radius in layer_state *)

val layer_state_has_frame_rate_selection_priority : layer_state -> bool
  (** presence of field "frame_rate_selection_priority" in [layer_state] *)

val layer_state_set_frame_rate_selection_priority : layer_state -> int32 -> unit
  (** set field frame_rate_selection_priority in layer_state *)

val layer_state_has_frame_rate : layer_state -> bool
  (** presence of field "frame_rate" in [layer_state] *)

val layer_state_set_frame_rate : layer_state -> float -> unit
  (** set field frame_rate in layer_state *)

val layer_state_has_frame_rate_compatibility : layer_state -> bool
  (** presence of field "frame_rate_compatibility" in [layer_state] *)

val layer_state_set_frame_rate_compatibility : layer_state -> int32 -> unit
  (** set field frame_rate_compatibility in layer_state *)

val layer_state_has_change_frame_rate_strategy : layer_state -> bool
  (** presence of field "change_frame_rate_strategy" in [layer_state] *)

val layer_state_set_change_frame_rate_strategy : layer_state -> int32 -> unit
  (** set field change_frame_rate_strategy in layer_state *)

val layer_state_has_fixed_transform_hint : layer_state -> bool
  (** presence of field "fixed_transform_hint" in [layer_state] *)

val layer_state_set_fixed_transform_hint : layer_state -> int32 -> unit
  (** set field fixed_transform_hint in layer_state *)

val layer_state_has_frame_number : layer_state -> bool
  (** presence of field "frame_number" in [layer_state] *)

val layer_state_set_frame_number : layer_state -> int64 -> unit
  (** set field frame_number in layer_state *)

val layer_state_has_auto_refresh : layer_state -> bool
  (** presence of field "auto_refresh" in [layer_state] *)

val layer_state_set_auto_refresh : layer_state -> bool -> unit
  (** set field auto_refresh in layer_state *)

val layer_state_has_is_trusted_overlay : layer_state -> bool
  (** presence of field "is_trusted_overlay" in [layer_state] *)

val layer_state_set_is_trusted_overlay : layer_state -> bool -> unit
  (** set field is_trusted_overlay in layer_state *)

val layer_state_set_buffer_crop : layer_state -> rect_proto -> unit
  (** set field buffer_crop in layer_state *)

val layer_state_set_destination_frame : layer_state -> rect_proto -> unit
  (** set field destination_frame in layer_state *)

val layer_state_has_drop_input_mode : layer_state -> bool
  (** presence of field "drop_input_mode" in [layer_state] *)

val layer_state_set_drop_input_mode : layer_state -> layer_state_drop_input_mode -> unit
  (** set field drop_input_mode in layer_state *)

val layer_state_has_trusted_overlay : layer_state -> bool
  (** presence of field "trusted_overlay" in [layer_state] *)

val layer_state_set_trusted_overlay : layer_state -> trusted_overlay -> unit
  (** set field trusted_overlay in layer_state *)

val layer_state_has_background_blur_scale : layer_state -> bool
  (** presence of field "background_blur_scale" in [layer_state] *)

val layer_state_set_background_blur_scale : layer_state -> float -> unit
  (** set field background_blur_scale in layer_state *)

val layer_state_set_corner_radii : layer_state -> layer_state_corner_radii -> unit
  (** set field corner_radii in layer_state *)

val layer_state_set_client_drawn_corner_radii : layer_state -> layer_state_corner_radii -> unit
  (** set field client_drawn_corner_radii in layer_state *)

val layer_state_has_system_content_priority : layer_state -> bool
  (** presence of field "system_content_priority" in [layer_state] *)

val layer_state_set_system_content_priority : layer_state -> int32 -> unit
  (** set field system_content_priority in layer_state *)

val layer_state_set_box_shadow_settings : layer_state -> box_shadow_settings -> unit
  (** set field box_shadow_settings in layer_state *)

val layer_state_set_border_settings : layer_state -> border_settings -> unit
  (** set field border_settings in layer_state *)

val make_display_state : 
  ?id:int32 ->
  ?what:int32 ->
  ?flags:int32 ->
  ?layer_stack:int32 ->
  ?orientation:int32 ->
  ?layer_stack_space_rect:rect_proto ->
  ?oriented_display_space_rect:rect_proto ->
  ?width:int32 ->
  ?height:int32 ->
  unit ->
  display_state
(** [make_display_state … ()] is a builder for type [display_state] *)

val copy_display_state : display_state -> display_state

val display_state_has_id : display_state -> bool
  (** presence of field "id" in [display_state] *)

val display_state_set_id : display_state -> int32 -> unit
  (** set field id in display_state *)

val display_state_has_what : display_state -> bool
  (** presence of field "what" in [display_state] *)

val display_state_set_what : display_state -> int32 -> unit
  (** set field what in display_state *)

val display_state_has_flags : display_state -> bool
  (** presence of field "flags" in [display_state] *)

val display_state_set_flags : display_state -> int32 -> unit
  (** set field flags in display_state *)

val display_state_has_layer_stack : display_state -> bool
  (** presence of field "layer_stack" in [display_state] *)

val display_state_set_layer_stack : display_state -> int32 -> unit
  (** set field layer_stack in display_state *)

val display_state_has_orientation : display_state -> bool
  (** presence of field "orientation" in [display_state] *)

val display_state_set_orientation : display_state -> int32 -> unit
  (** set field orientation in display_state *)

val display_state_set_layer_stack_space_rect : display_state -> rect_proto -> unit
  (** set field layer_stack_space_rect in display_state *)

val display_state_set_oriented_display_space_rect : display_state -> rect_proto -> unit
  (** set field oriented_display_space_rect in display_state *)

val display_state_has_width : display_state -> bool
  (** presence of field "width" in [display_state] *)

val display_state_set_width : display_state -> int32 -> unit
  (** set field width in display_state *)

val display_state_has_height : display_state -> bool
  (** presence of field "height" in [display_state] *)

val display_state_set_height : display_state -> int32 -> unit
  (** set field height in display_state *)

val make_transaction_barrier : 
  ?barrier_token:string ->
  ?kind:int32 ->
  unit ->
  transaction_barrier
(** [make_transaction_barrier … ()] is a builder for type [transaction_barrier] *)

val copy_transaction_barrier : transaction_barrier -> transaction_barrier

val transaction_barrier_has_barrier_token : transaction_barrier -> bool
  (** presence of field "barrier_token" in [transaction_barrier] *)

val transaction_barrier_set_barrier_token : transaction_barrier -> string -> unit
  (** set field barrier_token in transaction_barrier *)

val transaction_barrier_has_kind : transaction_barrier -> bool
  (** presence of field "kind" in [transaction_barrier] *)

val transaction_barrier_set_kind : transaction_barrier -> int32 -> unit
  (** set field kind in transaction_barrier *)

val make_transaction_state : 
  ?pid:int32 ->
  ?uid:int32 ->
  ?vsync_id:int64 ->
  ?input_event_id:int32 ->
  ?post_time:int64 ->
  ?transaction_id:int64 ->
  ?layer_changes:layer_state list ->
  ?display_changes:display_state list ->
  ?merged_transaction_ids:int64 list ->
  ?apply_token:int64 ->
  ?transaction_barriers:transaction_barrier list ->
  unit ->
  transaction_state
(** [make_transaction_state … ()] is a builder for type [transaction_state] *)

val copy_transaction_state : transaction_state -> transaction_state

val transaction_state_has_pid : transaction_state -> bool
  (** presence of field "pid" in [transaction_state] *)

val transaction_state_set_pid : transaction_state -> int32 -> unit
  (** set field pid in transaction_state *)

val transaction_state_has_uid : transaction_state -> bool
  (** presence of field "uid" in [transaction_state] *)

val transaction_state_set_uid : transaction_state -> int32 -> unit
  (** set field uid in transaction_state *)

val transaction_state_has_vsync_id : transaction_state -> bool
  (** presence of field "vsync_id" in [transaction_state] *)

val transaction_state_set_vsync_id : transaction_state -> int64 -> unit
  (** set field vsync_id in transaction_state *)

val transaction_state_has_input_event_id : transaction_state -> bool
  (** presence of field "input_event_id" in [transaction_state] *)

val transaction_state_set_input_event_id : transaction_state -> int32 -> unit
  (** set field input_event_id in transaction_state *)

val transaction_state_has_post_time : transaction_state -> bool
  (** presence of field "post_time" in [transaction_state] *)

val transaction_state_set_post_time : transaction_state -> int64 -> unit
  (** set field post_time in transaction_state *)

val transaction_state_has_transaction_id : transaction_state -> bool
  (** presence of field "transaction_id" in [transaction_state] *)

val transaction_state_set_transaction_id : transaction_state -> int64 -> unit
  (** set field transaction_id in transaction_state *)

val transaction_state_set_layer_changes : transaction_state -> layer_state list -> unit
  (** set field layer_changes in transaction_state *)

val transaction_state_set_display_changes : transaction_state -> display_state list -> unit
  (** set field display_changes in transaction_state *)

val transaction_state_set_merged_transaction_ids : transaction_state -> int64 list -> unit
  (** set field merged_transaction_ids in transaction_state *)

val transaction_state_has_apply_token : transaction_state -> bool
  (** presence of field "apply_token" in [transaction_state] *)

val transaction_state_set_apply_token : transaction_state -> int64 -> unit
  (** set field apply_token in transaction_state *)

val transaction_state_set_transaction_barriers : transaction_state -> transaction_barrier list -> unit
  (** set field transaction_barriers in transaction_state *)

val make_layer_creation_args : 
  ?layer_id:int32 ->
  ?name:string ->
  ?flags:int32 ->
  ?parent_id:int32 ->
  ?mirror_from_id:int32 ->
  ?add_to_root:bool ->
  ?layer_stack_to_mirror:int32 ->
  unit ->
  layer_creation_args
(** [make_layer_creation_args … ()] is a builder for type [layer_creation_args] *)

val copy_layer_creation_args : layer_creation_args -> layer_creation_args

val layer_creation_args_has_layer_id : layer_creation_args -> bool
  (** presence of field "layer_id" in [layer_creation_args] *)

val layer_creation_args_set_layer_id : layer_creation_args -> int32 -> unit
  (** set field layer_id in layer_creation_args *)

val layer_creation_args_has_name : layer_creation_args -> bool
  (** presence of field "name" in [layer_creation_args] *)

val layer_creation_args_set_name : layer_creation_args -> string -> unit
  (** set field name in layer_creation_args *)

val layer_creation_args_has_flags : layer_creation_args -> bool
  (** presence of field "flags" in [layer_creation_args] *)

val layer_creation_args_set_flags : layer_creation_args -> int32 -> unit
  (** set field flags in layer_creation_args *)

val layer_creation_args_has_parent_id : layer_creation_args -> bool
  (** presence of field "parent_id" in [layer_creation_args] *)

val layer_creation_args_set_parent_id : layer_creation_args -> int32 -> unit
  (** set field parent_id in layer_creation_args *)

val layer_creation_args_has_mirror_from_id : layer_creation_args -> bool
  (** presence of field "mirror_from_id" in [layer_creation_args] *)

val layer_creation_args_set_mirror_from_id : layer_creation_args -> int32 -> unit
  (** set field mirror_from_id in layer_creation_args *)

val layer_creation_args_has_add_to_root : layer_creation_args -> bool
  (** presence of field "add_to_root" in [layer_creation_args] *)

val layer_creation_args_set_add_to_root : layer_creation_args -> bool -> unit
  (** set field add_to_root in layer_creation_args *)

val layer_creation_args_has_layer_stack_to_mirror : layer_creation_args -> bool
  (** presence of field "layer_stack_to_mirror" in [layer_creation_args] *)

val layer_creation_args_set_layer_stack_to_mirror : layer_creation_args -> int32 -> unit
  (** set field layer_stack_to_mirror in layer_creation_args *)

val make_display_info : 
  ?layer_stack:int32 ->
  ?display_id:int32 ->
  ?logical_width:int32 ->
  ?logical_height:int32 ->
  ?transform_inverse:transform ->
  ?transform:transform ->
  ?receives_input:bool ->
  ?is_secure:bool ->
  ?is_primary:bool ->
  ?is_virtual:bool ->
  ?rotation_flags:int32 ->
  ?transform_hint:int32 ->
  unit ->
  display_info
(** [make_display_info … ()] is a builder for type [display_info] *)

val copy_display_info : display_info -> display_info

val display_info_has_layer_stack : display_info -> bool
  (** presence of field "layer_stack" in [display_info] *)

val display_info_set_layer_stack : display_info -> int32 -> unit
  (** set field layer_stack in display_info *)

val display_info_has_display_id : display_info -> bool
  (** presence of field "display_id" in [display_info] *)

val display_info_set_display_id : display_info -> int32 -> unit
  (** set field display_id in display_info *)

val display_info_has_logical_width : display_info -> bool
  (** presence of field "logical_width" in [display_info] *)

val display_info_set_logical_width : display_info -> int32 -> unit
  (** set field logical_width in display_info *)

val display_info_has_logical_height : display_info -> bool
  (** presence of field "logical_height" in [display_info] *)

val display_info_set_logical_height : display_info -> int32 -> unit
  (** set field logical_height in display_info *)

val display_info_set_transform_inverse : display_info -> transform -> unit
  (** set field transform_inverse in display_info *)

val display_info_set_transform : display_info -> transform -> unit
  (** set field transform in display_info *)

val display_info_has_receives_input : display_info -> bool
  (** presence of field "receives_input" in [display_info] *)

val display_info_set_receives_input : display_info -> bool -> unit
  (** set field receives_input in display_info *)

val display_info_has_is_secure : display_info -> bool
  (** presence of field "is_secure" in [display_info] *)

val display_info_set_is_secure : display_info -> bool -> unit
  (** set field is_secure in display_info *)

val display_info_has_is_primary : display_info -> bool
  (** presence of field "is_primary" in [display_info] *)

val display_info_set_is_primary : display_info -> bool -> unit
  (** set field is_primary in display_info *)

val display_info_has_is_virtual : display_info -> bool
  (** presence of field "is_virtual" in [display_info] *)

val display_info_set_is_virtual : display_info -> bool -> unit
  (** set field is_virtual in display_info *)

val display_info_has_rotation_flags : display_info -> bool
  (** presence of field "rotation_flags" in [display_info] *)

val display_info_set_rotation_flags : display_info -> int32 -> unit
  (** set field rotation_flags in display_info *)

val display_info_has_transform_hint : display_info -> bool
  (** presence of field "transform_hint" in [display_info] *)

val display_info_set_transform_hint : display_info -> int32 -> unit
  (** set field transform_hint in display_info *)

val make_transaction_trace_entry : 
  ?elapsed_realtime_nanos:int64 ->
  ?vsync_id:int64 ->
  ?transactions:transaction_state list ->
  ?added_layers:layer_creation_args list ->
  ?destroyed_layers:int32 list ->
  ?added_displays:display_state list ->
  ?removed_displays:int32 list ->
  ?destroyed_layer_handles:int32 list ->
  ?displays_changed:bool ->
  ?displays:display_info list ->
  unit ->
  transaction_trace_entry
(** [make_transaction_trace_entry … ()] is a builder for type [transaction_trace_entry] *)

val copy_transaction_trace_entry : transaction_trace_entry -> transaction_trace_entry

val transaction_trace_entry_has_elapsed_realtime_nanos : transaction_trace_entry -> bool
  (** presence of field "elapsed_realtime_nanos" in [transaction_trace_entry] *)

val transaction_trace_entry_set_elapsed_realtime_nanos : transaction_trace_entry -> int64 -> unit
  (** set field elapsed_realtime_nanos in transaction_trace_entry *)

val transaction_trace_entry_has_vsync_id : transaction_trace_entry -> bool
  (** presence of field "vsync_id" in [transaction_trace_entry] *)

val transaction_trace_entry_set_vsync_id : transaction_trace_entry -> int64 -> unit
  (** set field vsync_id in transaction_trace_entry *)

val transaction_trace_entry_set_transactions : transaction_trace_entry -> transaction_state list -> unit
  (** set field transactions in transaction_trace_entry *)

val transaction_trace_entry_set_added_layers : transaction_trace_entry -> layer_creation_args list -> unit
  (** set field added_layers in transaction_trace_entry *)

val transaction_trace_entry_set_destroyed_layers : transaction_trace_entry -> int32 list -> unit
  (** set field destroyed_layers in transaction_trace_entry *)

val transaction_trace_entry_set_added_displays : transaction_trace_entry -> display_state list -> unit
  (** set field added_displays in transaction_trace_entry *)

val transaction_trace_entry_set_removed_displays : transaction_trace_entry -> int32 list -> unit
  (** set field removed_displays in transaction_trace_entry *)

val transaction_trace_entry_set_destroyed_layer_handles : transaction_trace_entry -> int32 list -> unit
  (** set field destroyed_layer_handles in transaction_trace_entry *)

val transaction_trace_entry_has_displays_changed : transaction_trace_entry -> bool
  (** presence of field "displays_changed" in [transaction_trace_entry] *)

val transaction_trace_entry_set_displays_changed : transaction_trace_entry -> bool -> unit
  (** set field displays_changed in transaction_trace_entry *)

val transaction_trace_entry_set_displays : transaction_trace_entry -> display_info list -> unit
  (** set field displays in transaction_trace_entry *)

val make_transaction_trace_file : 
  ?magic_number:int64 ->
  ?entry:transaction_trace_entry list ->
  ?real_to_elapsed_time_offset_nanos:int64 ->
  ?version:int32 ->
  unit ->
  transaction_trace_file
(** [make_transaction_trace_file … ()] is a builder for type [transaction_trace_file] *)

val copy_transaction_trace_file : transaction_trace_file -> transaction_trace_file

val transaction_trace_file_has_magic_number : transaction_trace_file -> bool
  (** presence of field "magic_number" in [transaction_trace_file] *)

val transaction_trace_file_set_magic_number : transaction_trace_file -> int64 -> unit
  (** set field magic_number in transaction_trace_file *)

val transaction_trace_file_set_entry : transaction_trace_file -> transaction_trace_entry list -> unit
  (** set field entry in transaction_trace_file *)

val transaction_trace_file_has_real_to_elapsed_time_offset_nanos : transaction_trace_file -> bool
  (** presence of field "real_to_elapsed_time_offset_nanos" in [transaction_trace_file] *)

val transaction_trace_file_set_real_to_elapsed_time_offset_nanos : transaction_trace_file -> int64 -> unit
  (** set field real_to_elapsed_time_offset_nanos in transaction_trace_file *)

val transaction_trace_file_has_version : transaction_trace_file -> bool
  (** presence of field "version" in [transaction_trace_file] *)

val transaction_trace_file_set_version : transaction_trace_file -> int32 -> unit
  (** set field version in transaction_trace_file *)

val make_chrome_benchmark_metadata : 
  ?benchmark_start_time_us:int64 ->
  ?story_run_time_us:int64 ->
  ?benchmark_name:string ->
  ?benchmark_description:string ->
  ?label:string ->
  ?story_name:string ->
  ?story_tags:string list ->
  ?story_run_index:int32 ->
  ?had_failures:bool ->
  unit ->
  chrome_benchmark_metadata
(** [make_chrome_benchmark_metadata … ()] is a builder for type [chrome_benchmark_metadata] *)

val copy_chrome_benchmark_metadata : chrome_benchmark_metadata -> chrome_benchmark_metadata

val chrome_benchmark_metadata_has_benchmark_start_time_us : chrome_benchmark_metadata -> bool
  (** presence of field "benchmark_start_time_us" in [chrome_benchmark_metadata] *)

val chrome_benchmark_metadata_set_benchmark_start_time_us : chrome_benchmark_metadata -> int64 -> unit
  (** set field benchmark_start_time_us in chrome_benchmark_metadata *)

val chrome_benchmark_metadata_has_story_run_time_us : chrome_benchmark_metadata -> bool
  (** presence of field "story_run_time_us" in [chrome_benchmark_metadata] *)

val chrome_benchmark_metadata_set_story_run_time_us : chrome_benchmark_metadata -> int64 -> unit
  (** set field story_run_time_us in chrome_benchmark_metadata *)

val chrome_benchmark_metadata_has_benchmark_name : chrome_benchmark_metadata -> bool
  (** presence of field "benchmark_name" in [chrome_benchmark_metadata] *)

val chrome_benchmark_metadata_set_benchmark_name : chrome_benchmark_metadata -> string -> unit
  (** set field benchmark_name in chrome_benchmark_metadata *)

val chrome_benchmark_metadata_has_benchmark_description : chrome_benchmark_metadata -> bool
  (** presence of field "benchmark_description" in [chrome_benchmark_metadata] *)

val chrome_benchmark_metadata_set_benchmark_description : chrome_benchmark_metadata -> string -> unit
  (** set field benchmark_description in chrome_benchmark_metadata *)

val chrome_benchmark_metadata_has_label : chrome_benchmark_metadata -> bool
  (** presence of field "label" in [chrome_benchmark_metadata] *)

val chrome_benchmark_metadata_set_label : chrome_benchmark_metadata -> string -> unit
  (** set field label in chrome_benchmark_metadata *)

val chrome_benchmark_metadata_has_story_name : chrome_benchmark_metadata -> bool
  (** presence of field "story_name" in [chrome_benchmark_metadata] *)

val chrome_benchmark_metadata_set_story_name : chrome_benchmark_metadata -> string -> unit
  (** set field story_name in chrome_benchmark_metadata *)

val chrome_benchmark_metadata_set_story_tags : chrome_benchmark_metadata -> string list -> unit
  (** set field story_tags in chrome_benchmark_metadata *)

val chrome_benchmark_metadata_has_story_run_index : chrome_benchmark_metadata -> bool
  (** presence of field "story_run_index" in [chrome_benchmark_metadata] *)

val chrome_benchmark_metadata_set_story_run_index : chrome_benchmark_metadata -> int32 -> unit
  (** set field story_run_index in chrome_benchmark_metadata *)

val chrome_benchmark_metadata_has_had_failures : chrome_benchmark_metadata -> bool
  (** presence of field "had_failures" in [chrome_benchmark_metadata] *)

val chrome_benchmark_metadata_set_had_failures : chrome_benchmark_metadata -> bool -> unit
  (** set field had_failures in chrome_benchmark_metadata *)

val make_chrome_metadata_packet_finch_hash : 
  ?name:int32 ->
  ?group:int32 ->
  unit ->
  chrome_metadata_packet_finch_hash
(** [make_chrome_metadata_packet_finch_hash … ()] is a builder for type [chrome_metadata_packet_finch_hash] *)

val copy_chrome_metadata_packet_finch_hash : chrome_metadata_packet_finch_hash -> chrome_metadata_packet_finch_hash

val chrome_metadata_packet_finch_hash_has_name : chrome_metadata_packet_finch_hash -> bool
  (** presence of field "name" in [chrome_metadata_packet_finch_hash] *)

val chrome_metadata_packet_finch_hash_set_name : chrome_metadata_packet_finch_hash -> int32 -> unit
  (** set field name in chrome_metadata_packet_finch_hash *)

val chrome_metadata_packet_finch_hash_has_group : chrome_metadata_packet_finch_hash -> bool
  (** presence of field "group" in [chrome_metadata_packet_finch_hash] *)

val chrome_metadata_packet_finch_hash_set_group : chrome_metadata_packet_finch_hash -> int32 -> unit
  (** set field group in chrome_metadata_packet_finch_hash *)

val make_background_tracing_metadata_trigger_rule_histogram_rule : 
  ?histogram_name_hash:int64 ->
  ?histogram_min_trigger:int64 ->
  ?histogram_max_trigger:int64 ->
  unit ->
  background_tracing_metadata_trigger_rule_histogram_rule
(** [make_background_tracing_metadata_trigger_rule_histogram_rule … ()] is a builder for type [background_tracing_metadata_trigger_rule_histogram_rule] *)

val copy_background_tracing_metadata_trigger_rule_histogram_rule : background_tracing_metadata_trigger_rule_histogram_rule -> background_tracing_metadata_trigger_rule_histogram_rule

val background_tracing_metadata_trigger_rule_histogram_rule_has_histogram_name_hash : background_tracing_metadata_trigger_rule_histogram_rule -> bool
  (** presence of field "histogram_name_hash" in [background_tracing_metadata_trigger_rule_histogram_rule] *)

val background_tracing_metadata_trigger_rule_histogram_rule_set_histogram_name_hash : background_tracing_metadata_trigger_rule_histogram_rule -> int64 -> unit
  (** set field histogram_name_hash in background_tracing_metadata_trigger_rule_histogram_rule *)

val background_tracing_metadata_trigger_rule_histogram_rule_has_histogram_min_trigger : background_tracing_metadata_trigger_rule_histogram_rule -> bool
  (** presence of field "histogram_min_trigger" in [background_tracing_metadata_trigger_rule_histogram_rule] *)

val background_tracing_metadata_trigger_rule_histogram_rule_set_histogram_min_trigger : background_tracing_metadata_trigger_rule_histogram_rule -> int64 -> unit
  (** set field histogram_min_trigger in background_tracing_metadata_trigger_rule_histogram_rule *)

val background_tracing_metadata_trigger_rule_histogram_rule_has_histogram_max_trigger : background_tracing_metadata_trigger_rule_histogram_rule -> bool
  (** presence of field "histogram_max_trigger" in [background_tracing_metadata_trigger_rule_histogram_rule] *)

val background_tracing_metadata_trigger_rule_histogram_rule_set_histogram_max_trigger : background_tracing_metadata_trigger_rule_histogram_rule -> int64 -> unit
  (** set field histogram_max_trigger in background_tracing_metadata_trigger_rule_histogram_rule *)

val make_background_tracing_metadata_trigger_rule_named_rule : 
  ?event_type:background_tracing_metadata_trigger_rule_named_rule_event_type ->
  ?content_trigger_name_hash:int64 ->
  unit ->
  background_tracing_metadata_trigger_rule_named_rule
(** [make_background_tracing_metadata_trigger_rule_named_rule … ()] is a builder for type [background_tracing_metadata_trigger_rule_named_rule] *)

val copy_background_tracing_metadata_trigger_rule_named_rule : background_tracing_metadata_trigger_rule_named_rule -> background_tracing_metadata_trigger_rule_named_rule

val background_tracing_metadata_trigger_rule_named_rule_has_event_type : background_tracing_metadata_trigger_rule_named_rule -> bool
  (** presence of field "event_type" in [background_tracing_metadata_trigger_rule_named_rule] *)

val background_tracing_metadata_trigger_rule_named_rule_set_event_type : background_tracing_metadata_trigger_rule_named_rule -> background_tracing_metadata_trigger_rule_named_rule_event_type -> unit
  (** set field event_type in background_tracing_metadata_trigger_rule_named_rule *)

val background_tracing_metadata_trigger_rule_named_rule_has_content_trigger_name_hash : background_tracing_metadata_trigger_rule_named_rule -> bool
  (** presence of field "content_trigger_name_hash" in [background_tracing_metadata_trigger_rule_named_rule] *)

val background_tracing_metadata_trigger_rule_named_rule_set_content_trigger_name_hash : background_tracing_metadata_trigger_rule_named_rule -> int64 -> unit
  (** set field content_trigger_name_hash in background_tracing_metadata_trigger_rule_named_rule *)

val make_background_tracing_metadata_trigger_rule : 
  ?trigger_type:background_tracing_metadata_trigger_rule_trigger_type ->
  ?histogram_rule:background_tracing_metadata_trigger_rule_histogram_rule ->
  ?named_rule:background_tracing_metadata_trigger_rule_named_rule ->
  ?name_hash:int32 ->
  unit ->
  background_tracing_metadata_trigger_rule
(** [make_background_tracing_metadata_trigger_rule … ()] is a builder for type [background_tracing_metadata_trigger_rule] *)

val copy_background_tracing_metadata_trigger_rule : background_tracing_metadata_trigger_rule -> background_tracing_metadata_trigger_rule

val background_tracing_metadata_trigger_rule_has_trigger_type : background_tracing_metadata_trigger_rule -> bool
  (** presence of field "trigger_type" in [background_tracing_metadata_trigger_rule] *)

val background_tracing_metadata_trigger_rule_set_trigger_type : background_tracing_metadata_trigger_rule -> background_tracing_metadata_trigger_rule_trigger_type -> unit
  (** set field trigger_type in background_tracing_metadata_trigger_rule *)

val background_tracing_metadata_trigger_rule_set_histogram_rule : background_tracing_metadata_trigger_rule -> background_tracing_metadata_trigger_rule_histogram_rule -> unit
  (** set field histogram_rule in background_tracing_metadata_trigger_rule *)

val background_tracing_metadata_trigger_rule_set_named_rule : background_tracing_metadata_trigger_rule -> background_tracing_metadata_trigger_rule_named_rule -> unit
  (** set field named_rule in background_tracing_metadata_trigger_rule *)

val background_tracing_metadata_trigger_rule_has_name_hash : background_tracing_metadata_trigger_rule -> bool
  (** presence of field "name_hash" in [background_tracing_metadata_trigger_rule] *)

val background_tracing_metadata_trigger_rule_set_name_hash : background_tracing_metadata_trigger_rule -> int32 -> unit
  (** set field name_hash in background_tracing_metadata_trigger_rule *)

val make_background_tracing_metadata : 
  ?triggered_rule:background_tracing_metadata_trigger_rule ->
  ?active_rules:background_tracing_metadata_trigger_rule list ->
  ?scenario_name_hash:int32 ->
  unit ->
  background_tracing_metadata
(** [make_background_tracing_metadata … ()] is a builder for type [background_tracing_metadata] *)

val copy_background_tracing_metadata : background_tracing_metadata -> background_tracing_metadata

val background_tracing_metadata_set_triggered_rule : background_tracing_metadata -> background_tracing_metadata_trigger_rule -> unit
  (** set field triggered_rule in background_tracing_metadata *)

val background_tracing_metadata_set_active_rules : background_tracing_metadata -> background_tracing_metadata_trigger_rule list -> unit
  (** set field active_rules in background_tracing_metadata *)

val background_tracing_metadata_has_scenario_name_hash : background_tracing_metadata -> bool
  (** presence of field "scenario_name_hash" in [background_tracing_metadata] *)

val background_tracing_metadata_set_scenario_name_hash : background_tracing_metadata -> int32 -> unit
  (** set field scenario_name_hash in background_tracing_metadata *)

val make_chrome_metadata_packet : 
  ?background_tracing_metadata:background_tracing_metadata ->
  ?chrome_version_code:int32 ->
  ?enabled_categories:string ->
  ?field_trial_hashes:chrome_metadata_packet_finch_hash list ->
  unit ->
  chrome_metadata_packet
(** [make_chrome_metadata_packet … ()] is a builder for type [chrome_metadata_packet] *)

val copy_chrome_metadata_packet : chrome_metadata_packet -> chrome_metadata_packet

val chrome_metadata_packet_set_background_tracing_metadata : chrome_metadata_packet -> background_tracing_metadata -> unit
  (** set field background_tracing_metadata in chrome_metadata_packet *)

val chrome_metadata_packet_has_chrome_version_code : chrome_metadata_packet -> bool
  (** presence of field "chrome_version_code" in [chrome_metadata_packet] *)

val chrome_metadata_packet_set_chrome_version_code : chrome_metadata_packet -> int32 -> unit
  (** set field chrome_version_code in chrome_metadata_packet *)

val chrome_metadata_packet_has_enabled_categories : chrome_metadata_packet -> bool
  (** presence of field "enabled_categories" in [chrome_metadata_packet] *)

val chrome_metadata_packet_set_enabled_categories : chrome_metadata_packet -> string -> unit
  (** set field enabled_categories in chrome_metadata_packet *)

val chrome_metadata_packet_set_field_trial_hashes : chrome_metadata_packet -> chrome_metadata_packet_finch_hash list -> unit
  (** set field field_trial_hashes in chrome_metadata_packet *)

val make_chrome_traced_value : 
  ?nested_type:chrome_traced_value_nested_type ->
  ?dict_keys:string list ->
  ?dict_values:chrome_traced_value list ->
  ?array_values:chrome_traced_value list ->
  ?int_value:int32 ->
  ?double_value:float ->
  ?bool_value:bool ->
  ?string_value:string ->
  unit ->
  chrome_traced_value
(** [make_chrome_traced_value … ()] is a builder for type [chrome_traced_value] *)

val copy_chrome_traced_value : chrome_traced_value -> chrome_traced_value

val chrome_traced_value_has_nested_type : chrome_traced_value -> bool
  (** presence of field "nested_type" in [chrome_traced_value] *)

val chrome_traced_value_set_nested_type : chrome_traced_value -> chrome_traced_value_nested_type -> unit
  (** set field nested_type in chrome_traced_value *)

val chrome_traced_value_set_dict_keys : chrome_traced_value -> string list -> unit
  (** set field dict_keys in chrome_traced_value *)

val chrome_traced_value_set_dict_values : chrome_traced_value -> chrome_traced_value list -> unit
  (** set field dict_values in chrome_traced_value *)

val chrome_traced_value_set_array_values : chrome_traced_value -> chrome_traced_value list -> unit
  (** set field array_values in chrome_traced_value *)

val chrome_traced_value_has_int_value : chrome_traced_value -> bool
  (** presence of field "int_value" in [chrome_traced_value] *)

val chrome_traced_value_set_int_value : chrome_traced_value -> int32 -> unit
  (** set field int_value in chrome_traced_value *)

val chrome_traced_value_has_double_value : chrome_traced_value -> bool
  (** presence of field "double_value" in [chrome_traced_value] *)

val chrome_traced_value_set_double_value : chrome_traced_value -> float -> unit
  (** set field double_value in chrome_traced_value *)

val chrome_traced_value_has_bool_value : chrome_traced_value -> bool
  (** presence of field "bool_value" in [chrome_traced_value] *)

val chrome_traced_value_set_bool_value : chrome_traced_value -> bool -> unit
  (** set field bool_value in chrome_traced_value *)

val chrome_traced_value_has_string_value : chrome_traced_value -> bool
  (** presence of field "string_value" in [chrome_traced_value] *)

val chrome_traced_value_set_string_value : chrome_traced_value -> string -> unit
  (** set field string_value in chrome_traced_value *)

val make_chrome_string_table_entry : 
  ?value:string ->
  ?index:int32 ->
  unit ->
  chrome_string_table_entry
(** [make_chrome_string_table_entry … ()] is a builder for type [chrome_string_table_entry] *)

val copy_chrome_string_table_entry : chrome_string_table_entry -> chrome_string_table_entry

val chrome_string_table_entry_has_value : chrome_string_table_entry -> bool
  (** presence of field "value" in [chrome_string_table_entry] *)

val chrome_string_table_entry_set_value : chrome_string_table_entry -> string -> unit
  (** set field value in chrome_string_table_entry *)

val chrome_string_table_entry_has_index : chrome_string_table_entry -> bool
  (** presence of field "index" in [chrome_string_table_entry] *)

val chrome_string_table_entry_set_index : chrome_string_table_entry -> int32 -> unit
  (** set field index in chrome_string_table_entry *)

val make_chrome_trace_event_arg : 
  ?name:string ->
  ?value:chrome_trace_event_arg_value ->
  ?name_index:int32 ->
  unit ->
  chrome_trace_event_arg
(** [make_chrome_trace_event_arg … ()] is a builder for type [chrome_trace_event_arg] *)

val copy_chrome_trace_event_arg : chrome_trace_event_arg -> chrome_trace_event_arg

val chrome_trace_event_arg_has_name : chrome_trace_event_arg -> bool
  (** presence of field "name" in [chrome_trace_event_arg] *)

val chrome_trace_event_arg_set_name : chrome_trace_event_arg -> string -> unit
  (** set field name in chrome_trace_event_arg *)

val chrome_trace_event_arg_set_value : chrome_trace_event_arg -> chrome_trace_event_arg_value -> unit
  (** set field value in chrome_trace_event_arg *)

val chrome_trace_event_arg_has_name_index : chrome_trace_event_arg -> bool
  (** presence of field "name_index" in [chrome_trace_event_arg] *)

val chrome_trace_event_arg_set_name_index : chrome_trace_event_arg -> int32 -> unit
  (** set field name_index in chrome_trace_event_arg *)

val make_chrome_trace_event : 
  ?name:string ->
  ?timestamp:int64 ->
  ?phase:int32 ->
  ?thread_id:int32 ->
  ?duration:int64 ->
  ?thread_duration:int64 ->
  ?scope:string ->
  ?id:int64 ->
  ?flags:int32 ->
  ?category_group_name:string ->
  ?process_id:int32 ->
  ?thread_timestamp:int64 ->
  ?bind_id:int64 ->
  ?args:chrome_trace_event_arg list ->
  ?name_index:int32 ->
  ?category_group_name_index:int32 ->
  unit ->
  chrome_trace_event
(** [make_chrome_trace_event … ()] is a builder for type [chrome_trace_event] *)

val copy_chrome_trace_event : chrome_trace_event -> chrome_trace_event

val chrome_trace_event_has_name : chrome_trace_event -> bool
  (** presence of field "name" in [chrome_trace_event] *)

val chrome_trace_event_set_name : chrome_trace_event -> string -> unit
  (** set field name in chrome_trace_event *)

val chrome_trace_event_has_timestamp : chrome_trace_event -> bool
  (** presence of field "timestamp" in [chrome_trace_event] *)

val chrome_trace_event_set_timestamp : chrome_trace_event -> int64 -> unit
  (** set field timestamp in chrome_trace_event *)

val chrome_trace_event_has_phase : chrome_trace_event -> bool
  (** presence of field "phase" in [chrome_trace_event] *)

val chrome_trace_event_set_phase : chrome_trace_event -> int32 -> unit
  (** set field phase in chrome_trace_event *)

val chrome_trace_event_has_thread_id : chrome_trace_event -> bool
  (** presence of field "thread_id" in [chrome_trace_event] *)

val chrome_trace_event_set_thread_id : chrome_trace_event -> int32 -> unit
  (** set field thread_id in chrome_trace_event *)

val chrome_trace_event_has_duration : chrome_trace_event -> bool
  (** presence of field "duration" in [chrome_trace_event] *)

val chrome_trace_event_set_duration : chrome_trace_event -> int64 -> unit
  (** set field duration in chrome_trace_event *)

val chrome_trace_event_has_thread_duration : chrome_trace_event -> bool
  (** presence of field "thread_duration" in [chrome_trace_event] *)

val chrome_trace_event_set_thread_duration : chrome_trace_event -> int64 -> unit
  (** set field thread_duration in chrome_trace_event *)

val chrome_trace_event_has_scope : chrome_trace_event -> bool
  (** presence of field "scope" in [chrome_trace_event] *)

val chrome_trace_event_set_scope : chrome_trace_event -> string -> unit
  (** set field scope in chrome_trace_event *)

val chrome_trace_event_has_id : chrome_trace_event -> bool
  (** presence of field "id" in [chrome_trace_event] *)

val chrome_trace_event_set_id : chrome_trace_event -> int64 -> unit
  (** set field id in chrome_trace_event *)

val chrome_trace_event_has_flags : chrome_trace_event -> bool
  (** presence of field "flags" in [chrome_trace_event] *)

val chrome_trace_event_set_flags : chrome_trace_event -> int32 -> unit
  (** set field flags in chrome_trace_event *)

val chrome_trace_event_has_category_group_name : chrome_trace_event -> bool
  (** presence of field "category_group_name" in [chrome_trace_event] *)

val chrome_trace_event_set_category_group_name : chrome_trace_event -> string -> unit
  (** set field category_group_name in chrome_trace_event *)

val chrome_trace_event_has_process_id : chrome_trace_event -> bool
  (** presence of field "process_id" in [chrome_trace_event] *)

val chrome_trace_event_set_process_id : chrome_trace_event -> int32 -> unit
  (** set field process_id in chrome_trace_event *)

val chrome_trace_event_has_thread_timestamp : chrome_trace_event -> bool
  (** presence of field "thread_timestamp" in [chrome_trace_event] *)

val chrome_trace_event_set_thread_timestamp : chrome_trace_event -> int64 -> unit
  (** set field thread_timestamp in chrome_trace_event *)

val chrome_trace_event_has_bind_id : chrome_trace_event -> bool
  (** presence of field "bind_id" in [chrome_trace_event] *)

val chrome_trace_event_set_bind_id : chrome_trace_event -> int64 -> unit
  (** set field bind_id in chrome_trace_event *)

val chrome_trace_event_set_args : chrome_trace_event -> chrome_trace_event_arg list -> unit
  (** set field args in chrome_trace_event *)

val chrome_trace_event_has_name_index : chrome_trace_event -> bool
  (** presence of field "name_index" in [chrome_trace_event] *)

val chrome_trace_event_set_name_index : chrome_trace_event -> int32 -> unit
  (** set field name_index in chrome_trace_event *)

val chrome_trace_event_has_category_group_name_index : chrome_trace_event -> bool
  (** presence of field "category_group_name_index" in [chrome_trace_event] *)

val chrome_trace_event_set_category_group_name_index : chrome_trace_event -> int32 -> unit
  (** set field category_group_name_index in chrome_trace_event *)

val make_chrome_metadata : 
  ?name:string ->
  ?value:chrome_metadata_value ->
  unit ->
  chrome_metadata
(** [make_chrome_metadata … ()] is a builder for type [chrome_metadata] *)

val copy_chrome_metadata : chrome_metadata -> chrome_metadata

val chrome_metadata_has_name : chrome_metadata -> bool
  (** presence of field "name" in [chrome_metadata] *)

val chrome_metadata_set_name : chrome_metadata -> string -> unit
  (** set field name in chrome_metadata *)

val chrome_metadata_set_value : chrome_metadata -> chrome_metadata_value -> unit
  (** set field value in chrome_metadata *)

val make_chrome_legacy_json_trace : 
  ?type_:chrome_legacy_json_trace_trace_type ->
  ?data:string ->
  unit ->
  chrome_legacy_json_trace
(** [make_chrome_legacy_json_trace … ()] is a builder for type [chrome_legacy_json_trace] *)

val copy_chrome_legacy_json_trace : chrome_legacy_json_trace -> chrome_legacy_json_trace

val chrome_legacy_json_trace_has_type_ : chrome_legacy_json_trace -> bool
  (** presence of field "type_" in [chrome_legacy_json_trace] *)

val chrome_legacy_json_trace_set_type_ : chrome_legacy_json_trace -> chrome_legacy_json_trace_trace_type -> unit
  (** set field type_ in chrome_legacy_json_trace *)

val chrome_legacy_json_trace_has_data : chrome_legacy_json_trace -> bool
  (** presence of field "data" in [chrome_legacy_json_trace] *)

val chrome_legacy_json_trace_set_data : chrome_legacy_json_trace -> string -> unit
  (** set field data in chrome_legacy_json_trace *)

val make_chrome_event_bundle : 
  ?trace_events:chrome_trace_event list ->
  ?metadata:chrome_metadata list ->
  ?legacy_ftrace_output:string list ->
  ?legacy_json_trace:chrome_legacy_json_trace list ->
  ?string_table:chrome_string_table_entry list ->
  unit ->
  chrome_event_bundle
(** [make_chrome_event_bundle … ()] is a builder for type [chrome_event_bundle] *)

val copy_chrome_event_bundle : chrome_event_bundle -> chrome_event_bundle

val chrome_event_bundle_set_trace_events : chrome_event_bundle -> chrome_trace_event list -> unit
  (** set field trace_events in chrome_event_bundle *)

val chrome_event_bundle_set_metadata : chrome_event_bundle -> chrome_metadata list -> unit
  (** set field metadata in chrome_event_bundle *)

val chrome_event_bundle_set_legacy_ftrace_output : chrome_event_bundle -> string list -> unit
  (** set field legacy_ftrace_output in chrome_event_bundle *)

val chrome_event_bundle_set_legacy_json_trace : chrome_event_bundle -> chrome_legacy_json_trace list -> unit
  (** set field legacy_json_trace in chrome_event_bundle *)

val chrome_event_bundle_set_string_table : chrome_event_bundle -> chrome_string_table_entry list -> unit
  (** set field string_table in chrome_event_bundle *)

val make_chrome_trigger : 
  ?trigger_name:string ->
  ?trigger_name_hash:int32 ->
  ?flow_id:int64 ->
  unit ->
  chrome_trigger
(** [make_chrome_trigger … ()] is a builder for type [chrome_trigger] *)

val copy_chrome_trigger : chrome_trigger -> chrome_trigger

val chrome_trigger_has_trigger_name : chrome_trigger -> bool
  (** presence of field "trigger_name" in [chrome_trigger] *)

val chrome_trigger_set_trigger_name : chrome_trigger -> string -> unit
  (** set field trigger_name in chrome_trigger *)

val chrome_trigger_has_trigger_name_hash : chrome_trigger -> bool
  (** presence of field "trigger_name_hash" in [chrome_trigger] *)

val chrome_trigger_set_trigger_name_hash : chrome_trigger -> int32 -> unit
  (** set field trigger_name_hash in chrome_trigger *)

val chrome_trigger_has_flow_id : chrome_trigger -> bool
  (** presence of field "flow_id" in [chrome_trigger] *)

val chrome_trigger_set_flow_id : chrome_trigger -> int64 -> unit
  (** set field flow_id in chrome_trigger *)

val make_interned_v8_string : 
  ?iid:int64 ->
  ?encoded_string:interned_v8_string_encoded_string ->
  unit ->
  interned_v8_string
(** [make_interned_v8_string … ()] is a builder for type [interned_v8_string] *)

val copy_interned_v8_string : interned_v8_string -> interned_v8_string

val interned_v8_string_has_iid : interned_v8_string -> bool
  (** presence of field "iid" in [interned_v8_string] *)

val interned_v8_string_set_iid : interned_v8_string -> int64 -> unit
  (** set field iid in interned_v8_string *)

val interned_v8_string_set_encoded_string : interned_v8_string -> interned_v8_string_encoded_string -> unit
  (** set field encoded_string in interned_v8_string *)

val make_interned_v8_js_script : 
  ?iid:int64 ->
  ?script_id:int32 ->
  ?type_:interned_v8_js_script_type ->
  ?name:v8_string ->
  ?source:v8_string ->
  unit ->
  interned_v8_js_script
(** [make_interned_v8_js_script … ()] is a builder for type [interned_v8_js_script] *)

val copy_interned_v8_js_script : interned_v8_js_script -> interned_v8_js_script

val interned_v8_js_script_has_iid : interned_v8_js_script -> bool
  (** presence of field "iid" in [interned_v8_js_script] *)

val interned_v8_js_script_set_iid : interned_v8_js_script -> int64 -> unit
  (** set field iid in interned_v8_js_script *)

val interned_v8_js_script_has_script_id : interned_v8_js_script -> bool
  (** presence of field "script_id" in [interned_v8_js_script] *)

val interned_v8_js_script_set_script_id : interned_v8_js_script -> int32 -> unit
  (** set field script_id in interned_v8_js_script *)

val interned_v8_js_script_has_type_ : interned_v8_js_script -> bool
  (** presence of field "type_" in [interned_v8_js_script] *)

val interned_v8_js_script_set_type_ : interned_v8_js_script -> interned_v8_js_script_type -> unit
  (** set field type_ in interned_v8_js_script *)

val interned_v8_js_script_set_name : interned_v8_js_script -> v8_string -> unit
  (** set field name in interned_v8_js_script *)

val interned_v8_js_script_set_source : interned_v8_js_script -> v8_string -> unit
  (** set field source in interned_v8_js_script *)

val make_interned_v8_wasm_script : 
  ?iid:int64 ->
  ?script_id:int32 ->
  ?url:string ->
  ?wire_bytes:bytes ->
  unit ->
  interned_v8_wasm_script
(** [make_interned_v8_wasm_script … ()] is a builder for type [interned_v8_wasm_script] *)

val copy_interned_v8_wasm_script : interned_v8_wasm_script -> interned_v8_wasm_script

val interned_v8_wasm_script_has_iid : interned_v8_wasm_script -> bool
  (** presence of field "iid" in [interned_v8_wasm_script] *)

val interned_v8_wasm_script_set_iid : interned_v8_wasm_script -> int64 -> unit
  (** set field iid in interned_v8_wasm_script *)

val interned_v8_wasm_script_has_script_id : interned_v8_wasm_script -> bool
  (** presence of field "script_id" in [interned_v8_wasm_script] *)

val interned_v8_wasm_script_set_script_id : interned_v8_wasm_script -> int32 -> unit
  (** set field script_id in interned_v8_wasm_script *)

val interned_v8_wasm_script_has_url : interned_v8_wasm_script -> bool
  (** presence of field "url" in [interned_v8_wasm_script] *)

val interned_v8_wasm_script_set_url : interned_v8_wasm_script -> string -> unit
  (** set field url in interned_v8_wasm_script *)

val interned_v8_wasm_script_has_wire_bytes : interned_v8_wasm_script -> bool
  (** presence of field "wire_bytes" in [interned_v8_wasm_script] *)

val interned_v8_wasm_script_set_wire_bytes : interned_v8_wasm_script -> bytes -> unit
  (** set field wire_bytes in interned_v8_wasm_script *)

val make_interned_v8_js_function : 
  ?iid:int64 ->
  ?v8_js_function_name_iid:int64 ->
  ?v8_js_script_iid:int64 ->
  ?is_toplevel:bool ->
  ?kind:interned_v8_js_function_kind ->
  ?byte_offset:int32 ->
  ?line:int32 ->
  ?column:int32 ->
  unit ->
  interned_v8_js_function
(** [make_interned_v8_js_function … ()] is a builder for type [interned_v8_js_function] *)

val copy_interned_v8_js_function : interned_v8_js_function -> interned_v8_js_function

val interned_v8_js_function_has_iid : interned_v8_js_function -> bool
  (** presence of field "iid" in [interned_v8_js_function] *)

val interned_v8_js_function_set_iid : interned_v8_js_function -> int64 -> unit
  (** set field iid in interned_v8_js_function *)

val interned_v8_js_function_has_v8_js_function_name_iid : interned_v8_js_function -> bool
  (** presence of field "v8_js_function_name_iid" in [interned_v8_js_function] *)

val interned_v8_js_function_set_v8_js_function_name_iid : interned_v8_js_function -> int64 -> unit
  (** set field v8_js_function_name_iid in interned_v8_js_function *)

val interned_v8_js_function_has_v8_js_script_iid : interned_v8_js_function -> bool
  (** presence of field "v8_js_script_iid" in [interned_v8_js_function] *)

val interned_v8_js_function_set_v8_js_script_iid : interned_v8_js_function -> int64 -> unit
  (** set field v8_js_script_iid in interned_v8_js_function *)

val interned_v8_js_function_has_is_toplevel : interned_v8_js_function -> bool
  (** presence of field "is_toplevel" in [interned_v8_js_function] *)

val interned_v8_js_function_set_is_toplevel : interned_v8_js_function -> bool -> unit
  (** set field is_toplevel in interned_v8_js_function *)

val interned_v8_js_function_has_kind : interned_v8_js_function -> bool
  (** presence of field "kind" in [interned_v8_js_function] *)

val interned_v8_js_function_set_kind : interned_v8_js_function -> interned_v8_js_function_kind -> unit
  (** set field kind in interned_v8_js_function *)

val interned_v8_js_function_has_byte_offset : interned_v8_js_function -> bool
  (** presence of field "byte_offset" in [interned_v8_js_function] *)

val interned_v8_js_function_set_byte_offset : interned_v8_js_function -> int32 -> unit
  (** set field byte_offset in interned_v8_js_function *)

val interned_v8_js_function_has_line : interned_v8_js_function -> bool
  (** presence of field "line" in [interned_v8_js_function] *)

val interned_v8_js_function_set_line : interned_v8_js_function -> int32 -> unit
  (** set field line in interned_v8_js_function *)

val interned_v8_js_function_has_column : interned_v8_js_function -> bool
  (** presence of field "column" in [interned_v8_js_function] *)

val interned_v8_js_function_set_column : interned_v8_js_function -> int32 -> unit
  (** set field column in interned_v8_js_function *)

val make_interned_v8_isolate_code_range : 
  ?base_address:int64 ->
  ?size:int64 ->
  ?embedded_blob_code_copy_start_address:int64 ->
  ?is_process_wide:bool ->
  unit ->
  interned_v8_isolate_code_range
(** [make_interned_v8_isolate_code_range … ()] is a builder for type [interned_v8_isolate_code_range] *)

val copy_interned_v8_isolate_code_range : interned_v8_isolate_code_range -> interned_v8_isolate_code_range

val interned_v8_isolate_code_range_has_base_address : interned_v8_isolate_code_range -> bool
  (** presence of field "base_address" in [interned_v8_isolate_code_range] *)

val interned_v8_isolate_code_range_set_base_address : interned_v8_isolate_code_range -> int64 -> unit
  (** set field base_address in interned_v8_isolate_code_range *)

val interned_v8_isolate_code_range_has_size : interned_v8_isolate_code_range -> bool
  (** presence of field "size" in [interned_v8_isolate_code_range] *)

val interned_v8_isolate_code_range_set_size : interned_v8_isolate_code_range -> int64 -> unit
  (** set field size in interned_v8_isolate_code_range *)

val interned_v8_isolate_code_range_has_embedded_blob_code_copy_start_address : interned_v8_isolate_code_range -> bool
  (** presence of field "embedded_blob_code_copy_start_address" in [interned_v8_isolate_code_range] *)

val interned_v8_isolate_code_range_set_embedded_blob_code_copy_start_address : interned_v8_isolate_code_range -> int64 -> unit
  (** set field embedded_blob_code_copy_start_address in interned_v8_isolate_code_range *)

val interned_v8_isolate_code_range_has_is_process_wide : interned_v8_isolate_code_range -> bool
  (** presence of field "is_process_wide" in [interned_v8_isolate_code_range] *)

val interned_v8_isolate_code_range_set_is_process_wide : interned_v8_isolate_code_range -> bool -> unit
  (** set field is_process_wide in interned_v8_isolate_code_range *)

val make_interned_v8_isolate : 
  ?iid:int64 ->
  ?pid:int32 ->
  ?isolate_id:int32 ->
  ?code_range:interned_v8_isolate_code_range ->
  ?embedded_blob_code_start_address:int64 ->
  ?embedded_blob_code_size:int64 ->
  unit ->
  interned_v8_isolate
(** [make_interned_v8_isolate … ()] is a builder for type [interned_v8_isolate] *)

val copy_interned_v8_isolate : interned_v8_isolate -> interned_v8_isolate

val interned_v8_isolate_has_iid : interned_v8_isolate -> bool
  (** presence of field "iid" in [interned_v8_isolate] *)

val interned_v8_isolate_set_iid : interned_v8_isolate -> int64 -> unit
  (** set field iid in interned_v8_isolate *)

val interned_v8_isolate_has_pid : interned_v8_isolate -> bool
  (** presence of field "pid" in [interned_v8_isolate] *)

val interned_v8_isolate_set_pid : interned_v8_isolate -> int32 -> unit
  (** set field pid in interned_v8_isolate *)

val interned_v8_isolate_has_isolate_id : interned_v8_isolate -> bool
  (** presence of field "isolate_id" in [interned_v8_isolate] *)

val interned_v8_isolate_set_isolate_id : interned_v8_isolate -> int32 -> unit
  (** set field isolate_id in interned_v8_isolate *)

val interned_v8_isolate_set_code_range : interned_v8_isolate -> interned_v8_isolate_code_range -> unit
  (** set field code_range in interned_v8_isolate *)

val interned_v8_isolate_has_embedded_blob_code_start_address : interned_v8_isolate -> bool
  (** presence of field "embedded_blob_code_start_address" in [interned_v8_isolate] *)

val interned_v8_isolate_set_embedded_blob_code_start_address : interned_v8_isolate -> int64 -> unit
  (** set field embedded_blob_code_start_address in interned_v8_isolate *)

val interned_v8_isolate_has_embedded_blob_code_size : interned_v8_isolate -> bool
  (** presence of field "embedded_blob_code_size" in [interned_v8_isolate] *)

val interned_v8_isolate_set_embedded_blob_code_size : interned_v8_isolate -> int64 -> unit
  (** set field embedded_blob_code_size in interned_v8_isolate *)

val make_v8_js_code : 
  ?v8_isolate_iid:int64 ->
  ?tid:int32 ->
  ?v8_js_function_iid:int64 ->
  ?tier:v8_js_code_tier ->
  ?instruction_start:int64 ->
  ?instruction_size_bytes:int64 ->
  ?instructions:v8_js_code_instructions ->
  unit ->
  v8_js_code
(** [make_v8_js_code … ()] is a builder for type [v8_js_code] *)

val copy_v8_js_code : v8_js_code -> v8_js_code

val v8_js_code_has_v8_isolate_iid : v8_js_code -> bool
  (** presence of field "v8_isolate_iid" in [v8_js_code] *)

val v8_js_code_set_v8_isolate_iid : v8_js_code -> int64 -> unit
  (** set field v8_isolate_iid in v8_js_code *)

val v8_js_code_has_tid : v8_js_code -> bool
  (** presence of field "tid" in [v8_js_code] *)

val v8_js_code_set_tid : v8_js_code -> int32 -> unit
  (** set field tid in v8_js_code *)

val v8_js_code_has_v8_js_function_iid : v8_js_code -> bool
  (** presence of field "v8_js_function_iid" in [v8_js_code] *)

val v8_js_code_set_v8_js_function_iid : v8_js_code -> int64 -> unit
  (** set field v8_js_function_iid in v8_js_code *)

val v8_js_code_has_tier : v8_js_code -> bool
  (** presence of field "tier" in [v8_js_code] *)

val v8_js_code_set_tier : v8_js_code -> v8_js_code_tier -> unit
  (** set field tier in v8_js_code *)

val v8_js_code_has_instruction_start : v8_js_code -> bool
  (** presence of field "instruction_start" in [v8_js_code] *)

val v8_js_code_set_instruction_start : v8_js_code -> int64 -> unit
  (** set field instruction_start in v8_js_code *)

val v8_js_code_has_instruction_size_bytes : v8_js_code -> bool
  (** presence of field "instruction_size_bytes" in [v8_js_code] *)

val v8_js_code_set_instruction_size_bytes : v8_js_code -> int64 -> unit
  (** set field instruction_size_bytes in v8_js_code *)

val v8_js_code_set_instructions : v8_js_code -> v8_js_code_instructions -> unit
  (** set field instructions in v8_js_code *)

val make_v8_internal_code : 
  ?v8_isolate_iid:int64 ->
  ?tid:int32 ->
  ?name:string ->
  ?type_:v8_internal_code_type ->
  ?builtin_id:int32 ->
  ?instruction_start:int64 ->
  ?instruction_size_bytes:int64 ->
  ?machine_code:bytes ->
  unit ->
  v8_internal_code
(** [make_v8_internal_code … ()] is a builder for type [v8_internal_code] *)

val copy_v8_internal_code : v8_internal_code -> v8_internal_code

val v8_internal_code_has_v8_isolate_iid : v8_internal_code -> bool
  (** presence of field "v8_isolate_iid" in [v8_internal_code] *)

val v8_internal_code_set_v8_isolate_iid : v8_internal_code -> int64 -> unit
  (** set field v8_isolate_iid in v8_internal_code *)

val v8_internal_code_has_tid : v8_internal_code -> bool
  (** presence of field "tid" in [v8_internal_code] *)

val v8_internal_code_set_tid : v8_internal_code -> int32 -> unit
  (** set field tid in v8_internal_code *)

val v8_internal_code_has_name : v8_internal_code -> bool
  (** presence of field "name" in [v8_internal_code] *)

val v8_internal_code_set_name : v8_internal_code -> string -> unit
  (** set field name in v8_internal_code *)

val v8_internal_code_has_type_ : v8_internal_code -> bool
  (** presence of field "type_" in [v8_internal_code] *)

val v8_internal_code_set_type_ : v8_internal_code -> v8_internal_code_type -> unit
  (** set field type_ in v8_internal_code *)

val v8_internal_code_has_builtin_id : v8_internal_code -> bool
  (** presence of field "builtin_id" in [v8_internal_code] *)

val v8_internal_code_set_builtin_id : v8_internal_code -> int32 -> unit
  (** set field builtin_id in v8_internal_code *)

val v8_internal_code_has_instruction_start : v8_internal_code -> bool
  (** presence of field "instruction_start" in [v8_internal_code] *)

val v8_internal_code_set_instruction_start : v8_internal_code -> int64 -> unit
  (** set field instruction_start in v8_internal_code *)

val v8_internal_code_has_instruction_size_bytes : v8_internal_code -> bool
  (** presence of field "instruction_size_bytes" in [v8_internal_code] *)

val v8_internal_code_set_instruction_size_bytes : v8_internal_code -> int64 -> unit
  (** set field instruction_size_bytes in v8_internal_code *)

val v8_internal_code_has_machine_code : v8_internal_code -> bool
  (** presence of field "machine_code" in [v8_internal_code] *)

val v8_internal_code_set_machine_code : v8_internal_code -> bytes -> unit
  (** set field machine_code in v8_internal_code *)

val make_v8_wasm_code : 
  ?v8_isolate_iid:int64 ->
  ?tid:int32 ->
  ?v8_wasm_script_iid:int64 ->
  ?function_name:string ->
  ?tier:v8_wasm_code_tier ->
  ?code_offset_in_module:int32 ->
  ?instruction_start:int64 ->
  ?instruction_size_bytes:int64 ->
  ?machine_code:bytes ->
  unit ->
  v8_wasm_code
(** [make_v8_wasm_code … ()] is a builder for type [v8_wasm_code] *)

val copy_v8_wasm_code : v8_wasm_code -> v8_wasm_code

val v8_wasm_code_has_v8_isolate_iid : v8_wasm_code -> bool
  (** presence of field "v8_isolate_iid" in [v8_wasm_code] *)

val v8_wasm_code_set_v8_isolate_iid : v8_wasm_code -> int64 -> unit
  (** set field v8_isolate_iid in v8_wasm_code *)

val v8_wasm_code_has_tid : v8_wasm_code -> bool
  (** presence of field "tid" in [v8_wasm_code] *)

val v8_wasm_code_set_tid : v8_wasm_code -> int32 -> unit
  (** set field tid in v8_wasm_code *)

val v8_wasm_code_has_v8_wasm_script_iid : v8_wasm_code -> bool
  (** presence of field "v8_wasm_script_iid" in [v8_wasm_code] *)

val v8_wasm_code_set_v8_wasm_script_iid : v8_wasm_code -> int64 -> unit
  (** set field v8_wasm_script_iid in v8_wasm_code *)

val v8_wasm_code_has_function_name : v8_wasm_code -> bool
  (** presence of field "function_name" in [v8_wasm_code] *)

val v8_wasm_code_set_function_name : v8_wasm_code -> string -> unit
  (** set field function_name in v8_wasm_code *)

val v8_wasm_code_has_tier : v8_wasm_code -> bool
  (** presence of field "tier" in [v8_wasm_code] *)

val v8_wasm_code_set_tier : v8_wasm_code -> v8_wasm_code_tier -> unit
  (** set field tier in v8_wasm_code *)

val v8_wasm_code_has_code_offset_in_module : v8_wasm_code -> bool
  (** presence of field "code_offset_in_module" in [v8_wasm_code] *)

val v8_wasm_code_set_code_offset_in_module : v8_wasm_code -> int32 -> unit
  (** set field code_offset_in_module in v8_wasm_code *)

val v8_wasm_code_has_instruction_start : v8_wasm_code -> bool
  (** presence of field "instruction_start" in [v8_wasm_code] *)

val v8_wasm_code_set_instruction_start : v8_wasm_code -> int64 -> unit
  (** set field instruction_start in v8_wasm_code *)

val v8_wasm_code_has_instruction_size_bytes : v8_wasm_code -> bool
  (** presence of field "instruction_size_bytes" in [v8_wasm_code] *)

val v8_wasm_code_set_instruction_size_bytes : v8_wasm_code -> int64 -> unit
  (** set field instruction_size_bytes in v8_wasm_code *)

val v8_wasm_code_has_machine_code : v8_wasm_code -> bool
  (** presence of field "machine_code" in [v8_wasm_code] *)

val v8_wasm_code_set_machine_code : v8_wasm_code -> bytes -> unit
  (** set field machine_code in v8_wasm_code *)

val make_v8_reg_exp_code : 
  ?v8_isolate_iid:int64 ->
  ?tid:int32 ->
  ?pattern:v8_string ->
  ?instruction_start:int64 ->
  ?instruction_size_bytes:int64 ->
  ?machine_code:bytes ->
  unit ->
  v8_reg_exp_code
(** [make_v8_reg_exp_code … ()] is a builder for type [v8_reg_exp_code] *)

val copy_v8_reg_exp_code : v8_reg_exp_code -> v8_reg_exp_code

val v8_reg_exp_code_has_v8_isolate_iid : v8_reg_exp_code -> bool
  (** presence of field "v8_isolate_iid" in [v8_reg_exp_code] *)

val v8_reg_exp_code_set_v8_isolate_iid : v8_reg_exp_code -> int64 -> unit
  (** set field v8_isolate_iid in v8_reg_exp_code *)

val v8_reg_exp_code_has_tid : v8_reg_exp_code -> bool
  (** presence of field "tid" in [v8_reg_exp_code] *)

val v8_reg_exp_code_set_tid : v8_reg_exp_code -> int32 -> unit
  (** set field tid in v8_reg_exp_code *)

val v8_reg_exp_code_set_pattern : v8_reg_exp_code -> v8_string -> unit
  (** set field pattern in v8_reg_exp_code *)

val v8_reg_exp_code_has_instruction_start : v8_reg_exp_code -> bool
  (** presence of field "instruction_start" in [v8_reg_exp_code] *)

val v8_reg_exp_code_set_instruction_start : v8_reg_exp_code -> int64 -> unit
  (** set field instruction_start in v8_reg_exp_code *)

val v8_reg_exp_code_has_instruction_size_bytes : v8_reg_exp_code -> bool
  (** presence of field "instruction_size_bytes" in [v8_reg_exp_code] *)

val v8_reg_exp_code_set_instruction_size_bytes : v8_reg_exp_code -> int64 -> unit
  (** set field instruction_size_bytes in v8_reg_exp_code *)

val v8_reg_exp_code_has_machine_code : v8_reg_exp_code -> bool
  (** presence of field "machine_code" in [v8_reg_exp_code] *)

val v8_reg_exp_code_set_machine_code : v8_reg_exp_code -> bytes -> unit
  (** set field machine_code in v8_reg_exp_code *)

val make_v8_code_move : 
  ?isolate_iid:int64 ->
  ?tid:int32 ->
  ?from_instruction_start_address:int64 ->
  ?to_instruction_start_address:int64 ->
  ?instruction_size_bytes:int64 ->
  ?to_instructions:v8_code_move_to_instructions ->
  unit ->
  v8_code_move
(** [make_v8_code_move … ()] is a builder for type [v8_code_move] *)

val copy_v8_code_move : v8_code_move -> v8_code_move

val v8_code_move_has_isolate_iid : v8_code_move -> bool
  (** presence of field "isolate_iid" in [v8_code_move] *)

val v8_code_move_set_isolate_iid : v8_code_move -> int64 -> unit
  (** set field isolate_iid in v8_code_move *)

val v8_code_move_has_tid : v8_code_move -> bool
  (** presence of field "tid" in [v8_code_move] *)

val v8_code_move_set_tid : v8_code_move -> int32 -> unit
  (** set field tid in v8_code_move *)

val v8_code_move_has_from_instruction_start_address : v8_code_move -> bool
  (** presence of field "from_instruction_start_address" in [v8_code_move] *)

val v8_code_move_set_from_instruction_start_address : v8_code_move -> int64 -> unit
  (** set field from_instruction_start_address in v8_code_move *)

val v8_code_move_has_to_instruction_start_address : v8_code_move -> bool
  (** presence of field "to_instruction_start_address" in [v8_code_move] *)

val v8_code_move_set_to_instruction_start_address : v8_code_move -> int64 -> unit
  (** set field to_instruction_start_address in v8_code_move *)

val v8_code_move_has_instruction_size_bytes : v8_code_move -> bool
  (** presence of field "instruction_size_bytes" in [v8_code_move] *)

val v8_code_move_set_instruction_size_bytes : v8_code_move -> int64 -> unit
  (** set field instruction_size_bytes in v8_code_move *)

val v8_code_move_set_to_instructions : v8_code_move -> v8_code_move_to_instructions -> unit
  (** set field to_instructions in v8_code_move *)

val make_v8_code_defaults : 
  ?tid:int32 ->
  unit ->
  v8_code_defaults
(** [make_v8_code_defaults … ()] is a builder for type [v8_code_defaults] *)

val copy_v8_code_defaults : v8_code_defaults -> v8_code_defaults

val v8_code_defaults_has_tid : v8_code_defaults -> bool
  (** presence of field "tid" in [v8_code_defaults] *)

val v8_code_defaults_set_tid : v8_code_defaults -> int32 -> unit
  (** set field tid in v8_code_defaults *)

val make_clock_snapshot_clock : 
  ?clock_id:int32 ->
  ?timestamp:int64 ->
  ?is_incremental:bool ->
  ?unit_multiplier_ns:int64 ->
  unit ->
  clock_snapshot_clock
(** [make_clock_snapshot_clock … ()] is a builder for type [clock_snapshot_clock] *)

val copy_clock_snapshot_clock : clock_snapshot_clock -> clock_snapshot_clock

val clock_snapshot_clock_has_clock_id : clock_snapshot_clock -> bool
  (** presence of field "clock_id" in [clock_snapshot_clock] *)

val clock_snapshot_clock_set_clock_id : clock_snapshot_clock -> int32 -> unit
  (** set field clock_id in clock_snapshot_clock *)

val clock_snapshot_clock_has_timestamp : clock_snapshot_clock -> bool
  (** presence of field "timestamp" in [clock_snapshot_clock] *)

val clock_snapshot_clock_set_timestamp : clock_snapshot_clock -> int64 -> unit
  (** set field timestamp in clock_snapshot_clock *)

val clock_snapshot_clock_has_is_incremental : clock_snapshot_clock -> bool
  (** presence of field "is_incremental" in [clock_snapshot_clock] *)

val clock_snapshot_clock_set_is_incremental : clock_snapshot_clock -> bool -> unit
  (** set field is_incremental in clock_snapshot_clock *)

val clock_snapshot_clock_has_unit_multiplier_ns : clock_snapshot_clock -> bool
  (** presence of field "unit_multiplier_ns" in [clock_snapshot_clock] *)

val clock_snapshot_clock_set_unit_multiplier_ns : clock_snapshot_clock -> int64 -> unit
  (** set field unit_multiplier_ns in clock_snapshot_clock *)

val make_clock_snapshot : 
  ?clocks:clock_snapshot_clock list ->
  ?primary_trace_clock:builtin_clock ->
  unit ->
  clock_snapshot
(** [make_clock_snapshot … ()] is a builder for type [clock_snapshot] *)

val copy_clock_snapshot : clock_snapshot -> clock_snapshot

val clock_snapshot_set_clocks : clock_snapshot -> clock_snapshot_clock list -> unit
  (** set field clocks in clock_snapshot *)

val clock_snapshot_has_primary_trace_clock : clock_snapshot -> bool
  (** presence of field "primary_trace_clock" in [clock_snapshot] *)

val clock_snapshot_set_primary_trace_clock : clock_snapshot -> builtin_clock -> unit
  (** set field primary_trace_clock in clock_snapshot *)

val make_cswitch_etw_event : 
  ?new_thread_id:int32 ->
  ?old_thread_id:int32 ->
  ?new_thread_priority:int32 ->
  ?old_thread_priority:int32 ->
  ?previous_c_state:int32 ->
  ?old_thread_wait_reason_enum_or_int:cswitch_etw_event_old_thread_wait_reason_enum_or_int ->
  ?old_thread_wait_mode_enum_or_int:cswitch_etw_event_old_thread_wait_mode_enum_or_int ->
  ?old_thread_state_enum_or_int:cswitch_etw_event_old_thread_state_enum_or_int ->
  ?old_thread_wait_ideal_processor:int32 ->
  ?new_thread_wait_time:int32 ->
  unit ->
  cswitch_etw_event
(** [make_cswitch_etw_event … ()] is a builder for type [cswitch_etw_event] *)

val copy_cswitch_etw_event : cswitch_etw_event -> cswitch_etw_event

val cswitch_etw_event_has_new_thread_id : cswitch_etw_event -> bool
  (** presence of field "new_thread_id" in [cswitch_etw_event] *)

val cswitch_etw_event_set_new_thread_id : cswitch_etw_event -> int32 -> unit
  (** set field new_thread_id in cswitch_etw_event *)

val cswitch_etw_event_has_old_thread_id : cswitch_etw_event -> bool
  (** presence of field "old_thread_id" in [cswitch_etw_event] *)

val cswitch_etw_event_set_old_thread_id : cswitch_etw_event -> int32 -> unit
  (** set field old_thread_id in cswitch_etw_event *)

val cswitch_etw_event_has_new_thread_priority : cswitch_etw_event -> bool
  (** presence of field "new_thread_priority" in [cswitch_etw_event] *)

val cswitch_etw_event_set_new_thread_priority : cswitch_etw_event -> int32 -> unit
  (** set field new_thread_priority in cswitch_etw_event *)

val cswitch_etw_event_has_old_thread_priority : cswitch_etw_event -> bool
  (** presence of field "old_thread_priority" in [cswitch_etw_event] *)

val cswitch_etw_event_set_old_thread_priority : cswitch_etw_event -> int32 -> unit
  (** set field old_thread_priority in cswitch_etw_event *)

val cswitch_etw_event_has_previous_c_state : cswitch_etw_event -> bool
  (** presence of field "previous_c_state" in [cswitch_etw_event] *)

val cswitch_etw_event_set_previous_c_state : cswitch_etw_event -> int32 -> unit
  (** set field previous_c_state in cswitch_etw_event *)

val cswitch_etw_event_set_old_thread_wait_reason_enum_or_int : cswitch_etw_event -> cswitch_etw_event_old_thread_wait_reason_enum_or_int -> unit
  (** set field old_thread_wait_reason_enum_or_int in cswitch_etw_event *)

val cswitch_etw_event_set_old_thread_wait_mode_enum_or_int : cswitch_etw_event -> cswitch_etw_event_old_thread_wait_mode_enum_or_int -> unit
  (** set field old_thread_wait_mode_enum_or_int in cswitch_etw_event *)

val cswitch_etw_event_set_old_thread_state_enum_or_int : cswitch_etw_event -> cswitch_etw_event_old_thread_state_enum_or_int -> unit
  (** set field old_thread_state_enum_or_int in cswitch_etw_event *)

val cswitch_etw_event_has_old_thread_wait_ideal_processor : cswitch_etw_event -> bool
  (** presence of field "old_thread_wait_ideal_processor" in [cswitch_etw_event] *)

val cswitch_etw_event_set_old_thread_wait_ideal_processor : cswitch_etw_event -> int32 -> unit
  (** set field old_thread_wait_ideal_processor in cswitch_etw_event *)

val cswitch_etw_event_has_new_thread_wait_time : cswitch_etw_event -> bool
  (** presence of field "new_thread_wait_time" in [cswitch_etw_event] *)

val cswitch_etw_event_set_new_thread_wait_time : cswitch_etw_event -> int32 -> unit
  (** set field new_thread_wait_time in cswitch_etw_event *)

val make_ready_thread_etw_event : 
  ?t_thread_id:int32 ->
  ?adjust_reason_enum_or_int:ready_thread_etw_event_adjust_reason_enum_or_int ->
  ?adjust_increment:int32 ->
  ?flag_enum_or_int:ready_thread_etw_event_flag_enum_or_int ->
  unit ->
  ready_thread_etw_event
(** [make_ready_thread_etw_event … ()] is a builder for type [ready_thread_etw_event] *)

val copy_ready_thread_etw_event : ready_thread_etw_event -> ready_thread_etw_event

val ready_thread_etw_event_has_t_thread_id : ready_thread_etw_event -> bool
  (** presence of field "t_thread_id" in [ready_thread_etw_event] *)

val ready_thread_etw_event_set_t_thread_id : ready_thread_etw_event -> int32 -> unit
  (** set field t_thread_id in ready_thread_etw_event *)

val ready_thread_etw_event_set_adjust_reason_enum_or_int : ready_thread_etw_event -> ready_thread_etw_event_adjust_reason_enum_or_int -> unit
  (** set field adjust_reason_enum_or_int in ready_thread_etw_event *)

val ready_thread_etw_event_has_adjust_increment : ready_thread_etw_event -> bool
  (** presence of field "adjust_increment" in [ready_thread_etw_event] *)

val ready_thread_etw_event_set_adjust_increment : ready_thread_etw_event -> int32 -> unit
  (** set field adjust_increment in ready_thread_etw_event *)

val ready_thread_etw_event_set_flag_enum_or_int : ready_thread_etw_event -> ready_thread_etw_event_flag_enum_or_int -> unit
  (** set field flag_enum_or_int in ready_thread_etw_event *)

val make_mem_info_etw_event : 
  ?priority_levels:int32 ->
  ?zero_page_count:int64 ->
  ?free_page_count:int64 ->
  ?modified_page_count:int64 ->
  ?modified_no_write_page_count:int64 ->
  ?bad_page_count:int64 ->
  ?standby_page_counts:int64 list ->
  ?repurposed_page_counts:int64 list ->
  ?modified_page_count_page_file:int64 ->
  ?paged_pool_page_count:int64 ->
  ?non_paged_pool_page_count:int64 ->
  ?mdl_page_count:int64 ->
  ?commit_page_count:int64 ->
  unit ->
  mem_info_etw_event
(** [make_mem_info_etw_event … ()] is a builder for type [mem_info_etw_event] *)

val copy_mem_info_etw_event : mem_info_etw_event -> mem_info_etw_event

val mem_info_etw_event_has_priority_levels : mem_info_etw_event -> bool
  (** presence of field "priority_levels" in [mem_info_etw_event] *)

val mem_info_etw_event_set_priority_levels : mem_info_etw_event -> int32 -> unit
  (** set field priority_levels in mem_info_etw_event *)

val mem_info_etw_event_has_zero_page_count : mem_info_etw_event -> bool
  (** presence of field "zero_page_count" in [mem_info_etw_event] *)

val mem_info_etw_event_set_zero_page_count : mem_info_etw_event -> int64 -> unit
  (** set field zero_page_count in mem_info_etw_event *)

val mem_info_etw_event_has_free_page_count : mem_info_etw_event -> bool
  (** presence of field "free_page_count" in [mem_info_etw_event] *)

val mem_info_etw_event_set_free_page_count : mem_info_etw_event -> int64 -> unit
  (** set field free_page_count in mem_info_etw_event *)

val mem_info_etw_event_has_modified_page_count : mem_info_etw_event -> bool
  (** presence of field "modified_page_count" in [mem_info_etw_event] *)

val mem_info_etw_event_set_modified_page_count : mem_info_etw_event -> int64 -> unit
  (** set field modified_page_count in mem_info_etw_event *)

val mem_info_etw_event_has_modified_no_write_page_count : mem_info_etw_event -> bool
  (** presence of field "modified_no_write_page_count" in [mem_info_etw_event] *)

val mem_info_etw_event_set_modified_no_write_page_count : mem_info_etw_event -> int64 -> unit
  (** set field modified_no_write_page_count in mem_info_etw_event *)

val mem_info_etw_event_has_bad_page_count : mem_info_etw_event -> bool
  (** presence of field "bad_page_count" in [mem_info_etw_event] *)

val mem_info_etw_event_set_bad_page_count : mem_info_etw_event -> int64 -> unit
  (** set field bad_page_count in mem_info_etw_event *)

val mem_info_etw_event_set_standby_page_counts : mem_info_etw_event -> int64 list -> unit
  (** set field standby_page_counts in mem_info_etw_event *)

val mem_info_etw_event_set_repurposed_page_counts : mem_info_etw_event -> int64 list -> unit
  (** set field repurposed_page_counts in mem_info_etw_event *)

val mem_info_etw_event_has_modified_page_count_page_file : mem_info_etw_event -> bool
  (** presence of field "modified_page_count_page_file" in [mem_info_etw_event] *)

val mem_info_etw_event_set_modified_page_count_page_file : mem_info_etw_event -> int64 -> unit
  (** set field modified_page_count_page_file in mem_info_etw_event *)

val mem_info_etw_event_has_paged_pool_page_count : mem_info_etw_event -> bool
  (** presence of field "paged_pool_page_count" in [mem_info_etw_event] *)

val mem_info_etw_event_set_paged_pool_page_count : mem_info_etw_event -> int64 -> unit
  (** set field paged_pool_page_count in mem_info_etw_event *)

val mem_info_etw_event_has_non_paged_pool_page_count : mem_info_etw_event -> bool
  (** presence of field "non_paged_pool_page_count" in [mem_info_etw_event] *)

val mem_info_etw_event_set_non_paged_pool_page_count : mem_info_etw_event -> int64 -> unit
  (** set field non_paged_pool_page_count in mem_info_etw_event *)

val mem_info_etw_event_has_mdl_page_count : mem_info_etw_event -> bool
  (** presence of field "mdl_page_count" in [mem_info_etw_event] *)

val mem_info_etw_event_set_mdl_page_count : mem_info_etw_event -> int64 -> unit
  (** set field mdl_page_count in mem_info_etw_event *)

val mem_info_etw_event_has_commit_page_count : mem_info_etw_event -> bool
  (** presence of field "commit_page_count" in [mem_info_etw_event] *)

val mem_info_etw_event_set_commit_page_count : mem_info_etw_event -> int64 -> unit
  (** set field commit_page_count in mem_info_etw_event *)

val make_file_io_create_etw_event : 
  ?irp_ptr:int64 ->
  ?file_object:int64 ->
  ?ttid:int32 ->
  ?create_options:int32 ->
  ?file_attributes:int32 ->
  ?share_access:int32 ->
  ?open_path:string ->
  unit ->
  file_io_create_etw_event
(** [make_file_io_create_etw_event … ()] is a builder for type [file_io_create_etw_event] *)

val copy_file_io_create_etw_event : file_io_create_etw_event -> file_io_create_etw_event

val file_io_create_etw_event_has_irp_ptr : file_io_create_etw_event -> bool
  (** presence of field "irp_ptr" in [file_io_create_etw_event] *)

val file_io_create_etw_event_set_irp_ptr : file_io_create_etw_event -> int64 -> unit
  (** set field irp_ptr in file_io_create_etw_event *)

val file_io_create_etw_event_has_file_object : file_io_create_etw_event -> bool
  (** presence of field "file_object" in [file_io_create_etw_event] *)

val file_io_create_etw_event_set_file_object : file_io_create_etw_event -> int64 -> unit
  (** set field file_object in file_io_create_etw_event *)

val file_io_create_etw_event_has_ttid : file_io_create_etw_event -> bool
  (** presence of field "ttid" in [file_io_create_etw_event] *)

val file_io_create_etw_event_set_ttid : file_io_create_etw_event -> int32 -> unit
  (** set field ttid in file_io_create_etw_event *)

val file_io_create_etw_event_has_create_options : file_io_create_etw_event -> bool
  (** presence of field "create_options" in [file_io_create_etw_event] *)

val file_io_create_etw_event_set_create_options : file_io_create_etw_event -> int32 -> unit
  (** set field create_options in file_io_create_etw_event *)

val file_io_create_etw_event_has_file_attributes : file_io_create_etw_event -> bool
  (** presence of field "file_attributes" in [file_io_create_etw_event] *)

val file_io_create_etw_event_set_file_attributes : file_io_create_etw_event -> int32 -> unit
  (** set field file_attributes in file_io_create_etw_event *)

val file_io_create_etw_event_has_share_access : file_io_create_etw_event -> bool
  (** presence of field "share_access" in [file_io_create_etw_event] *)

val file_io_create_etw_event_set_share_access : file_io_create_etw_event -> int32 -> unit
  (** set field share_access in file_io_create_etw_event *)

val file_io_create_etw_event_has_open_path : file_io_create_etw_event -> bool
  (** presence of field "open_path" in [file_io_create_etw_event] *)

val file_io_create_etw_event_set_open_path : file_io_create_etw_event -> string -> unit
  (** set field open_path in file_io_create_etw_event *)

val make_file_io_dir_enum_etw_event : 
  ?irp_ptr:int64 ->
  ?file_object:int64 ->
  ?file_key:int64 ->
  ?ttid:int32 ->
  ?length:int32 ->
  ?info_class:int32 ->
  ?file_index:int32 ->
  ?file_name:string ->
  unit ->
  file_io_dir_enum_etw_event
(** [make_file_io_dir_enum_etw_event … ()] is a builder for type [file_io_dir_enum_etw_event] *)

val copy_file_io_dir_enum_etw_event : file_io_dir_enum_etw_event -> file_io_dir_enum_etw_event

val file_io_dir_enum_etw_event_has_irp_ptr : file_io_dir_enum_etw_event -> bool
  (** presence of field "irp_ptr" in [file_io_dir_enum_etw_event] *)

val file_io_dir_enum_etw_event_set_irp_ptr : file_io_dir_enum_etw_event -> int64 -> unit
  (** set field irp_ptr in file_io_dir_enum_etw_event *)

val file_io_dir_enum_etw_event_has_file_object : file_io_dir_enum_etw_event -> bool
  (** presence of field "file_object" in [file_io_dir_enum_etw_event] *)

val file_io_dir_enum_etw_event_set_file_object : file_io_dir_enum_etw_event -> int64 -> unit
  (** set field file_object in file_io_dir_enum_etw_event *)

val file_io_dir_enum_etw_event_has_file_key : file_io_dir_enum_etw_event -> bool
  (** presence of field "file_key" in [file_io_dir_enum_etw_event] *)

val file_io_dir_enum_etw_event_set_file_key : file_io_dir_enum_etw_event -> int64 -> unit
  (** set field file_key in file_io_dir_enum_etw_event *)

val file_io_dir_enum_etw_event_has_ttid : file_io_dir_enum_etw_event -> bool
  (** presence of field "ttid" in [file_io_dir_enum_etw_event] *)

val file_io_dir_enum_etw_event_set_ttid : file_io_dir_enum_etw_event -> int32 -> unit
  (** set field ttid in file_io_dir_enum_etw_event *)

val file_io_dir_enum_etw_event_has_length : file_io_dir_enum_etw_event -> bool
  (** presence of field "length" in [file_io_dir_enum_etw_event] *)

val file_io_dir_enum_etw_event_set_length : file_io_dir_enum_etw_event -> int32 -> unit
  (** set field length in file_io_dir_enum_etw_event *)

val file_io_dir_enum_etw_event_has_info_class : file_io_dir_enum_etw_event -> bool
  (** presence of field "info_class" in [file_io_dir_enum_etw_event] *)

val file_io_dir_enum_etw_event_set_info_class : file_io_dir_enum_etw_event -> int32 -> unit
  (** set field info_class in file_io_dir_enum_etw_event *)

val file_io_dir_enum_etw_event_has_file_index : file_io_dir_enum_etw_event -> bool
  (** presence of field "file_index" in [file_io_dir_enum_etw_event] *)

val file_io_dir_enum_etw_event_set_file_index : file_io_dir_enum_etw_event -> int32 -> unit
  (** set field file_index in file_io_dir_enum_etw_event *)

val file_io_dir_enum_etw_event_has_file_name : file_io_dir_enum_etw_event -> bool
  (** presence of field "file_name" in [file_io_dir_enum_etw_event] *)

val file_io_dir_enum_etw_event_set_file_name : file_io_dir_enum_etw_event -> string -> unit
  (** set field file_name in file_io_dir_enum_etw_event *)

val make_file_io_info_etw_event : 
  ?irp_ptr:int64 ->
  ?file_object:int64 ->
  ?file_key:int64 ->
  ?extra_info:int64 ->
  ?ttid:int32 ->
  ?info_class:int32 ->
  unit ->
  file_io_info_etw_event
(** [make_file_io_info_etw_event … ()] is a builder for type [file_io_info_etw_event] *)

val copy_file_io_info_etw_event : file_io_info_etw_event -> file_io_info_etw_event

val file_io_info_etw_event_has_irp_ptr : file_io_info_etw_event -> bool
  (** presence of field "irp_ptr" in [file_io_info_etw_event] *)

val file_io_info_etw_event_set_irp_ptr : file_io_info_etw_event -> int64 -> unit
  (** set field irp_ptr in file_io_info_etw_event *)

val file_io_info_etw_event_has_file_object : file_io_info_etw_event -> bool
  (** presence of field "file_object" in [file_io_info_etw_event] *)

val file_io_info_etw_event_set_file_object : file_io_info_etw_event -> int64 -> unit
  (** set field file_object in file_io_info_etw_event *)

val file_io_info_etw_event_has_file_key : file_io_info_etw_event -> bool
  (** presence of field "file_key" in [file_io_info_etw_event] *)

val file_io_info_etw_event_set_file_key : file_io_info_etw_event -> int64 -> unit
  (** set field file_key in file_io_info_etw_event *)

val file_io_info_etw_event_has_extra_info : file_io_info_etw_event -> bool
  (** presence of field "extra_info" in [file_io_info_etw_event] *)

val file_io_info_etw_event_set_extra_info : file_io_info_etw_event -> int64 -> unit
  (** set field extra_info in file_io_info_etw_event *)

val file_io_info_etw_event_has_ttid : file_io_info_etw_event -> bool
  (** presence of field "ttid" in [file_io_info_etw_event] *)

val file_io_info_etw_event_set_ttid : file_io_info_etw_event -> int32 -> unit
  (** set field ttid in file_io_info_etw_event *)

val file_io_info_etw_event_has_info_class : file_io_info_etw_event -> bool
  (** presence of field "info_class" in [file_io_info_etw_event] *)

val file_io_info_etw_event_set_info_class : file_io_info_etw_event -> int32 -> unit
  (** set field info_class in file_io_info_etw_event *)

val make_file_io_read_write_etw_event : 
  ?offset:int64 ->
  ?irp_ptr:int64 ->
  ?file_object:int64 ->
  ?file_key:int64 ->
  ?ttid:int32 ->
  ?io_size:int32 ->
  ?io_flags:int32 ->
  unit ->
  file_io_read_write_etw_event
(** [make_file_io_read_write_etw_event … ()] is a builder for type [file_io_read_write_etw_event] *)

val copy_file_io_read_write_etw_event : file_io_read_write_etw_event -> file_io_read_write_etw_event

val file_io_read_write_etw_event_has_offset : file_io_read_write_etw_event -> bool
  (** presence of field "offset" in [file_io_read_write_etw_event] *)

val file_io_read_write_etw_event_set_offset : file_io_read_write_etw_event -> int64 -> unit
  (** set field offset in file_io_read_write_etw_event *)

val file_io_read_write_etw_event_has_irp_ptr : file_io_read_write_etw_event -> bool
  (** presence of field "irp_ptr" in [file_io_read_write_etw_event] *)

val file_io_read_write_etw_event_set_irp_ptr : file_io_read_write_etw_event -> int64 -> unit
  (** set field irp_ptr in file_io_read_write_etw_event *)

val file_io_read_write_etw_event_has_file_object : file_io_read_write_etw_event -> bool
  (** presence of field "file_object" in [file_io_read_write_etw_event] *)

val file_io_read_write_etw_event_set_file_object : file_io_read_write_etw_event -> int64 -> unit
  (** set field file_object in file_io_read_write_etw_event *)

val file_io_read_write_etw_event_has_file_key : file_io_read_write_etw_event -> bool
  (** presence of field "file_key" in [file_io_read_write_etw_event] *)

val file_io_read_write_etw_event_set_file_key : file_io_read_write_etw_event -> int64 -> unit
  (** set field file_key in file_io_read_write_etw_event *)

val file_io_read_write_etw_event_has_ttid : file_io_read_write_etw_event -> bool
  (** presence of field "ttid" in [file_io_read_write_etw_event] *)

val file_io_read_write_etw_event_set_ttid : file_io_read_write_etw_event -> int32 -> unit
  (** set field ttid in file_io_read_write_etw_event *)

val file_io_read_write_etw_event_has_io_size : file_io_read_write_etw_event -> bool
  (** presence of field "io_size" in [file_io_read_write_etw_event] *)

val file_io_read_write_etw_event_set_io_size : file_io_read_write_etw_event -> int32 -> unit
  (** set field io_size in file_io_read_write_etw_event *)

val file_io_read_write_etw_event_has_io_flags : file_io_read_write_etw_event -> bool
  (** presence of field "io_flags" in [file_io_read_write_etw_event] *)

val file_io_read_write_etw_event_set_io_flags : file_io_read_write_etw_event -> int32 -> unit
  (** set field io_flags in file_io_read_write_etw_event *)

val make_file_io_simple_op_etw_event : 
  ?irp_ptr:int64 ->
  ?file_object:int64 ->
  ?file_key:int64 ->
  ?ttid:int32 ->
  unit ->
  file_io_simple_op_etw_event
(** [make_file_io_simple_op_etw_event … ()] is a builder for type [file_io_simple_op_etw_event] *)

val copy_file_io_simple_op_etw_event : file_io_simple_op_etw_event -> file_io_simple_op_etw_event

val file_io_simple_op_etw_event_has_irp_ptr : file_io_simple_op_etw_event -> bool
  (** presence of field "irp_ptr" in [file_io_simple_op_etw_event] *)

val file_io_simple_op_etw_event_set_irp_ptr : file_io_simple_op_etw_event -> int64 -> unit
  (** set field irp_ptr in file_io_simple_op_etw_event *)

val file_io_simple_op_etw_event_has_file_object : file_io_simple_op_etw_event -> bool
  (** presence of field "file_object" in [file_io_simple_op_etw_event] *)

val file_io_simple_op_etw_event_set_file_object : file_io_simple_op_etw_event -> int64 -> unit
  (** set field file_object in file_io_simple_op_etw_event *)

val file_io_simple_op_etw_event_has_file_key : file_io_simple_op_etw_event -> bool
  (** presence of field "file_key" in [file_io_simple_op_etw_event] *)

val file_io_simple_op_etw_event_set_file_key : file_io_simple_op_etw_event -> int64 -> unit
  (** set field file_key in file_io_simple_op_etw_event *)

val file_io_simple_op_etw_event_has_ttid : file_io_simple_op_etw_event -> bool
  (** presence of field "ttid" in [file_io_simple_op_etw_event] *)

val file_io_simple_op_etw_event_set_ttid : file_io_simple_op_etw_event -> int32 -> unit
  (** set field ttid in file_io_simple_op_etw_event *)

val make_file_io_op_end_etw_event : 
  ?irp_ptr:int64 ->
  ?extra_info:int64 ->
  ?nt_status:int32 ->
  unit ->
  file_io_op_end_etw_event
(** [make_file_io_op_end_etw_event … ()] is a builder for type [file_io_op_end_etw_event] *)

val copy_file_io_op_end_etw_event : file_io_op_end_etw_event -> file_io_op_end_etw_event

val file_io_op_end_etw_event_has_irp_ptr : file_io_op_end_etw_event -> bool
  (** presence of field "irp_ptr" in [file_io_op_end_etw_event] *)

val file_io_op_end_etw_event_set_irp_ptr : file_io_op_end_etw_event -> int64 -> unit
  (** set field irp_ptr in file_io_op_end_etw_event *)

val file_io_op_end_etw_event_has_extra_info : file_io_op_end_etw_event -> bool
  (** presence of field "extra_info" in [file_io_op_end_etw_event] *)

val file_io_op_end_etw_event_set_extra_info : file_io_op_end_etw_event -> int64 -> unit
  (** set field extra_info in file_io_op_end_etw_event *)

val file_io_op_end_etw_event_has_nt_status : file_io_op_end_etw_event -> bool
  (** presence of field "nt_status" in [file_io_op_end_etw_event] *)

val file_io_op_end_etw_event_set_nt_status : file_io_op_end_etw_event -> int32 -> unit
  (** set field nt_status in file_io_op_end_etw_event *)

val make_etw_trace_event : 
  ?timestamp:int64 ->
  ?cpu:int32 ->
  ?thread_id:int32 ->
  ?event:etw_trace_event_event ->
  unit ->
  etw_trace_event
(** [make_etw_trace_event … ()] is a builder for type [etw_trace_event] *)

val copy_etw_trace_event : etw_trace_event -> etw_trace_event

val etw_trace_event_has_timestamp : etw_trace_event -> bool
  (** presence of field "timestamp" in [etw_trace_event] *)

val etw_trace_event_set_timestamp : etw_trace_event -> int64 -> unit
  (** set field timestamp in etw_trace_event *)

val etw_trace_event_has_cpu : etw_trace_event -> bool
  (** presence of field "cpu" in [etw_trace_event] *)

val etw_trace_event_set_cpu : etw_trace_event -> int32 -> unit
  (** set field cpu in etw_trace_event *)

val etw_trace_event_has_thread_id : etw_trace_event -> bool
  (** presence of field "thread_id" in [etw_trace_event] *)

val etw_trace_event_set_thread_id : etw_trace_event -> int32 -> unit
  (** set field thread_id in etw_trace_event *)

val etw_trace_event_set_event : etw_trace_event -> etw_trace_event_event -> unit
  (** set field event in etw_trace_event *)

val make_etw_trace_event_bundle : 
  ?cpu:int32 ->
  ?event:etw_trace_event list ->
  unit ->
  etw_trace_event_bundle
(** [make_etw_trace_event_bundle … ()] is a builder for type [etw_trace_event_bundle] *)

val copy_etw_trace_event_bundle : etw_trace_event_bundle -> etw_trace_event_bundle

val etw_trace_event_bundle_has_cpu : etw_trace_event_bundle -> bool
  (** presence of field "cpu" in [etw_trace_event_bundle] *)

val etw_trace_event_bundle_set_cpu : etw_trace_event_bundle -> int32 -> unit
  (** set field cpu in etw_trace_event_bundle *)

val etw_trace_event_bundle_set_event : etw_trace_event_bundle -> etw_trace_event list -> unit
  (** set field event in etw_trace_event_bundle *)

val make_evdev_event_input_event : 
  ?kernel_timestamp:int64 ->
  ?type_:int32 ->
  ?code:int32 ->
  ?value:int32 ->
  unit ->
  evdev_event_input_event
(** [make_evdev_event_input_event … ()] is a builder for type [evdev_event_input_event] *)

val copy_evdev_event_input_event : evdev_event_input_event -> evdev_event_input_event

val evdev_event_input_event_has_kernel_timestamp : evdev_event_input_event -> bool
  (** presence of field "kernel_timestamp" in [evdev_event_input_event] *)

val evdev_event_input_event_set_kernel_timestamp : evdev_event_input_event -> int64 -> unit
  (** set field kernel_timestamp in evdev_event_input_event *)

val evdev_event_input_event_has_type_ : evdev_event_input_event -> bool
  (** presence of field "type_" in [evdev_event_input_event] *)

val evdev_event_input_event_set_type_ : evdev_event_input_event -> int32 -> unit
  (** set field type_ in evdev_event_input_event *)

val evdev_event_input_event_has_code : evdev_event_input_event -> bool
  (** presence of field "code" in [evdev_event_input_event] *)

val evdev_event_input_event_set_code : evdev_event_input_event -> int32 -> unit
  (** set field code in evdev_event_input_event *)

val evdev_event_input_event_has_value : evdev_event_input_event -> bool
  (** presence of field "value" in [evdev_event_input_event] *)

val evdev_event_input_event_set_value : evdev_event_input_event -> int32 -> unit
  (** set field value in evdev_event_input_event *)

val make_evdev_event : 
  ?device_id:int32 ->
  ?event:evdev_event_event ->
  unit ->
  evdev_event
(** [make_evdev_event … ()] is a builder for type [evdev_event] *)

val copy_evdev_event : evdev_event -> evdev_event

val evdev_event_has_device_id : evdev_event -> bool
  (** presence of field "device_id" in [evdev_event] *)

val evdev_event_set_device_id : evdev_event -> int32 -> unit
  (** set field device_id in evdev_event *)

val evdev_event_set_event : evdev_event -> evdev_event_event -> unit
  (** set field event in evdev_event *)

val make_uninterpreted_option_name_part : 
  ?name_part:string ->
  ?is_extension:bool ->
  unit ->
  uninterpreted_option_name_part
(** [make_uninterpreted_option_name_part … ()] is a builder for type [uninterpreted_option_name_part] *)

val copy_uninterpreted_option_name_part : uninterpreted_option_name_part -> uninterpreted_option_name_part

val uninterpreted_option_name_part_has_name_part : uninterpreted_option_name_part -> bool
  (** presence of field "name_part" in [uninterpreted_option_name_part] *)

val uninterpreted_option_name_part_set_name_part : uninterpreted_option_name_part -> string -> unit
  (** set field name_part in uninterpreted_option_name_part *)

val uninterpreted_option_name_part_has_is_extension : uninterpreted_option_name_part -> bool
  (** presence of field "is_extension" in [uninterpreted_option_name_part] *)

val uninterpreted_option_name_part_set_is_extension : uninterpreted_option_name_part -> bool -> unit
  (** set field is_extension in uninterpreted_option_name_part *)

val make_uninterpreted_option : 
  ?name:uninterpreted_option_name_part list ->
  ?identifier_value:string ->
  ?positive_int_value:int64 ->
  ?negative_int_value:int64 ->
  ?double_value:float ->
  ?string_value:bytes ->
  ?aggregate_value:string ->
  unit ->
  uninterpreted_option
(** [make_uninterpreted_option … ()] is a builder for type [uninterpreted_option] *)

val copy_uninterpreted_option : uninterpreted_option -> uninterpreted_option

val uninterpreted_option_set_name : uninterpreted_option -> uninterpreted_option_name_part list -> unit
  (** set field name in uninterpreted_option *)

val uninterpreted_option_has_identifier_value : uninterpreted_option -> bool
  (** presence of field "identifier_value" in [uninterpreted_option] *)

val uninterpreted_option_set_identifier_value : uninterpreted_option -> string -> unit
  (** set field identifier_value in uninterpreted_option *)

val uninterpreted_option_has_positive_int_value : uninterpreted_option -> bool
  (** presence of field "positive_int_value" in [uninterpreted_option] *)

val uninterpreted_option_set_positive_int_value : uninterpreted_option -> int64 -> unit
  (** set field positive_int_value in uninterpreted_option *)

val uninterpreted_option_has_negative_int_value : uninterpreted_option -> bool
  (** presence of field "negative_int_value" in [uninterpreted_option] *)

val uninterpreted_option_set_negative_int_value : uninterpreted_option -> int64 -> unit
  (** set field negative_int_value in uninterpreted_option *)

val uninterpreted_option_has_double_value : uninterpreted_option -> bool
  (** presence of field "double_value" in [uninterpreted_option] *)

val uninterpreted_option_set_double_value : uninterpreted_option -> float -> unit
  (** set field double_value in uninterpreted_option *)

val uninterpreted_option_has_string_value : uninterpreted_option -> bool
  (** presence of field "string_value" in [uninterpreted_option] *)

val uninterpreted_option_set_string_value : uninterpreted_option -> bytes -> unit
  (** set field string_value in uninterpreted_option *)

val uninterpreted_option_has_aggregate_value : uninterpreted_option -> bool
  (** presence of field "aggregate_value" in [uninterpreted_option] *)

val uninterpreted_option_set_aggregate_value : uninterpreted_option -> string -> unit
  (** set field aggregate_value in uninterpreted_option *)

val make_field_options : 
  ?packed:bool ->
  ?uninterpreted_option:uninterpreted_option list ->
  unit ->
  field_options
(** [make_field_options … ()] is a builder for type [field_options] *)

val copy_field_options : field_options -> field_options

val field_options_has_packed : field_options -> bool
  (** presence of field "packed" in [field_options] *)

val field_options_set_packed : field_options -> bool -> unit
  (** set field packed in field_options *)

val field_options_set_uninterpreted_option : field_options -> uninterpreted_option list -> unit
  (** set field uninterpreted_option in field_options *)

val make_field_descriptor_proto : 
  ?name:string ->
  ?number:int32 ->
  ?label:field_descriptor_proto_label ->
  ?type_:field_descriptor_proto_type ->
  ?type_name:string ->
  ?extendee:string ->
  ?default_value:string ->
  ?options:field_options ->
  ?oneof_index:int32 ->
  unit ->
  field_descriptor_proto
(** [make_field_descriptor_proto … ()] is a builder for type [field_descriptor_proto] *)

val copy_field_descriptor_proto : field_descriptor_proto -> field_descriptor_proto

val field_descriptor_proto_has_name : field_descriptor_proto -> bool
  (** presence of field "name" in [field_descriptor_proto] *)

val field_descriptor_proto_set_name : field_descriptor_proto -> string -> unit
  (** set field name in field_descriptor_proto *)

val field_descriptor_proto_has_number : field_descriptor_proto -> bool
  (** presence of field "number" in [field_descriptor_proto] *)

val field_descriptor_proto_set_number : field_descriptor_proto -> int32 -> unit
  (** set field number in field_descriptor_proto *)

val field_descriptor_proto_has_label : field_descriptor_proto -> bool
  (** presence of field "label" in [field_descriptor_proto] *)

val field_descriptor_proto_set_label : field_descriptor_proto -> field_descriptor_proto_label -> unit
  (** set field label in field_descriptor_proto *)

val field_descriptor_proto_has_type_ : field_descriptor_proto -> bool
  (** presence of field "type_" in [field_descriptor_proto] *)

val field_descriptor_proto_set_type_ : field_descriptor_proto -> field_descriptor_proto_type -> unit
  (** set field type_ in field_descriptor_proto *)

val field_descriptor_proto_has_type_name : field_descriptor_proto -> bool
  (** presence of field "type_name" in [field_descriptor_proto] *)

val field_descriptor_proto_set_type_name : field_descriptor_proto -> string -> unit
  (** set field type_name in field_descriptor_proto *)

val field_descriptor_proto_has_extendee : field_descriptor_proto -> bool
  (** presence of field "extendee" in [field_descriptor_proto] *)

val field_descriptor_proto_set_extendee : field_descriptor_proto -> string -> unit
  (** set field extendee in field_descriptor_proto *)

val field_descriptor_proto_has_default_value : field_descriptor_proto -> bool
  (** presence of field "default_value" in [field_descriptor_proto] *)

val field_descriptor_proto_set_default_value : field_descriptor_proto -> string -> unit
  (** set field default_value in field_descriptor_proto *)

val field_descriptor_proto_set_options : field_descriptor_proto -> field_options -> unit
  (** set field options in field_descriptor_proto *)

val field_descriptor_proto_has_oneof_index : field_descriptor_proto -> bool
  (** presence of field "oneof_index" in [field_descriptor_proto] *)

val field_descriptor_proto_set_oneof_index : field_descriptor_proto -> int32 -> unit
  (** set field oneof_index in field_descriptor_proto *)

val make_enum_value_descriptor_proto : 
  ?name:string ->
  ?number:int32 ->
  unit ->
  enum_value_descriptor_proto
(** [make_enum_value_descriptor_proto … ()] is a builder for type [enum_value_descriptor_proto] *)

val copy_enum_value_descriptor_proto : enum_value_descriptor_proto -> enum_value_descriptor_proto

val enum_value_descriptor_proto_has_name : enum_value_descriptor_proto -> bool
  (** presence of field "name" in [enum_value_descriptor_proto] *)

val enum_value_descriptor_proto_set_name : enum_value_descriptor_proto -> string -> unit
  (** set field name in enum_value_descriptor_proto *)

val enum_value_descriptor_proto_has_number : enum_value_descriptor_proto -> bool
  (** presence of field "number" in [enum_value_descriptor_proto] *)

val enum_value_descriptor_proto_set_number : enum_value_descriptor_proto -> int32 -> unit
  (** set field number in enum_value_descriptor_proto *)

val make_enum_descriptor_proto : 
  ?name:string ->
  ?value:enum_value_descriptor_proto list ->
  ?reserved_name:string list ->
  unit ->
  enum_descriptor_proto
(** [make_enum_descriptor_proto … ()] is a builder for type [enum_descriptor_proto] *)

val copy_enum_descriptor_proto : enum_descriptor_proto -> enum_descriptor_proto

val enum_descriptor_proto_has_name : enum_descriptor_proto -> bool
  (** presence of field "name" in [enum_descriptor_proto] *)

val enum_descriptor_proto_set_name : enum_descriptor_proto -> string -> unit
  (** set field name in enum_descriptor_proto *)

val enum_descriptor_proto_set_value : enum_descriptor_proto -> enum_value_descriptor_proto list -> unit
  (** set field value in enum_descriptor_proto *)

val enum_descriptor_proto_set_reserved_name : enum_descriptor_proto -> string list -> unit
  (** set field reserved_name in enum_descriptor_proto *)

val make_oneof_descriptor_proto : 
  ?name:string ->
  ?options:unit ->
  unit ->
  oneof_descriptor_proto
(** [make_oneof_descriptor_proto … ()] is a builder for type [oneof_descriptor_proto] *)

val copy_oneof_descriptor_proto : oneof_descriptor_proto -> oneof_descriptor_proto

val oneof_descriptor_proto_has_name : oneof_descriptor_proto -> bool
  (** presence of field "name" in [oneof_descriptor_proto] *)

val oneof_descriptor_proto_set_name : oneof_descriptor_proto -> string -> unit
  (** set field name in oneof_descriptor_proto *)

val oneof_descriptor_proto_has_options : oneof_descriptor_proto -> bool
  (** presence of field "options" in [oneof_descriptor_proto] *)

val oneof_descriptor_proto_set_options : oneof_descriptor_proto -> unit -> unit
  (** set field options in oneof_descriptor_proto *)

val make_descriptor_proto_reserved_range : 
  ?start:int32 ->
  ?end_:int32 ->
  unit ->
  descriptor_proto_reserved_range
(** [make_descriptor_proto_reserved_range … ()] is a builder for type [descriptor_proto_reserved_range] *)

val copy_descriptor_proto_reserved_range : descriptor_proto_reserved_range -> descriptor_proto_reserved_range

val descriptor_proto_reserved_range_has_start : descriptor_proto_reserved_range -> bool
  (** presence of field "start" in [descriptor_proto_reserved_range] *)

val descriptor_proto_reserved_range_set_start : descriptor_proto_reserved_range -> int32 -> unit
  (** set field start in descriptor_proto_reserved_range *)

val descriptor_proto_reserved_range_has_end_ : descriptor_proto_reserved_range -> bool
  (** presence of field "end_" in [descriptor_proto_reserved_range] *)

val descriptor_proto_reserved_range_set_end_ : descriptor_proto_reserved_range -> int32 -> unit
  (** set field end_ in descriptor_proto_reserved_range *)

val make_descriptor_proto : 
  ?name:string ->
  ?field:field_descriptor_proto list ->
  ?extension:field_descriptor_proto list ->
  ?nested_type:descriptor_proto list ->
  ?enum_type:enum_descriptor_proto list ->
  ?oneof_decl:oneof_descriptor_proto list ->
  ?reserved_range:descriptor_proto_reserved_range list ->
  ?reserved_name:string list ->
  unit ->
  descriptor_proto
(** [make_descriptor_proto … ()] is a builder for type [descriptor_proto] *)

val copy_descriptor_proto : descriptor_proto -> descriptor_proto

val descriptor_proto_has_name : descriptor_proto -> bool
  (** presence of field "name" in [descriptor_proto] *)

val descriptor_proto_set_name : descriptor_proto -> string -> unit
  (** set field name in descriptor_proto *)

val descriptor_proto_set_field : descriptor_proto -> field_descriptor_proto list -> unit
  (** set field field in descriptor_proto *)

val descriptor_proto_set_extension : descriptor_proto -> field_descriptor_proto list -> unit
  (** set field extension in descriptor_proto *)

val descriptor_proto_set_nested_type : descriptor_proto -> descriptor_proto list -> unit
  (** set field nested_type in descriptor_proto *)

val descriptor_proto_set_enum_type : descriptor_proto -> enum_descriptor_proto list -> unit
  (** set field enum_type in descriptor_proto *)

val descriptor_proto_set_oneof_decl : descriptor_proto -> oneof_descriptor_proto list -> unit
  (** set field oneof_decl in descriptor_proto *)

val descriptor_proto_set_reserved_range : descriptor_proto -> descriptor_proto_reserved_range list -> unit
  (** set field reserved_range in descriptor_proto *)

val descriptor_proto_set_reserved_name : descriptor_proto -> string list -> unit
  (** set field reserved_name in descriptor_proto *)

val make_file_descriptor_proto : 
  ?name:string ->
  ?package:string ->
  ?dependency:string list ->
  ?public_dependency:int32 list ->
  ?weak_dependency:int32 list ->
  ?message_type:descriptor_proto list ->
  ?enum_type:enum_descriptor_proto list ->
  ?extension:field_descriptor_proto list ->
  unit ->
  file_descriptor_proto
(** [make_file_descriptor_proto … ()] is a builder for type [file_descriptor_proto] *)

val copy_file_descriptor_proto : file_descriptor_proto -> file_descriptor_proto

val file_descriptor_proto_has_name : file_descriptor_proto -> bool
  (** presence of field "name" in [file_descriptor_proto] *)

val file_descriptor_proto_set_name : file_descriptor_proto -> string -> unit
  (** set field name in file_descriptor_proto *)

val file_descriptor_proto_has_package : file_descriptor_proto -> bool
  (** presence of field "package" in [file_descriptor_proto] *)

val file_descriptor_proto_set_package : file_descriptor_proto -> string -> unit
  (** set field package in file_descriptor_proto *)

val file_descriptor_proto_set_dependency : file_descriptor_proto -> string list -> unit
  (** set field dependency in file_descriptor_proto *)

val file_descriptor_proto_set_public_dependency : file_descriptor_proto -> int32 list -> unit
  (** set field public_dependency in file_descriptor_proto *)

val file_descriptor_proto_set_weak_dependency : file_descriptor_proto -> int32 list -> unit
  (** set field weak_dependency in file_descriptor_proto *)

val file_descriptor_proto_set_message_type : file_descriptor_proto -> descriptor_proto list -> unit
  (** set field message_type in file_descriptor_proto *)

val file_descriptor_proto_set_enum_type : file_descriptor_proto -> enum_descriptor_proto list -> unit
  (** set field enum_type in file_descriptor_proto *)

val file_descriptor_proto_set_extension : file_descriptor_proto -> field_descriptor_proto list -> unit
  (** set field extension in file_descriptor_proto *)

val make_file_descriptor_set : 
  ?file:file_descriptor_proto list ->
  unit ->
  file_descriptor_set
(** [make_file_descriptor_set … ()] is a builder for type [file_descriptor_set] *)

val copy_file_descriptor_set : file_descriptor_set -> file_descriptor_set

val file_descriptor_set_set_file : file_descriptor_set -> file_descriptor_proto list -> unit
  (** set field file in file_descriptor_set *)

val make_extension_descriptor : 
  ?extension_set:file_descriptor_set ->
  unit ->
  extension_descriptor
(** [make_extension_descriptor … ()] is a builder for type [extension_descriptor] *)

val copy_extension_descriptor : extension_descriptor -> extension_descriptor

val extension_descriptor_set_extension_set : extension_descriptor -> file_descriptor_set -> unit
  (** set field extension_set in extension_descriptor *)

val make_inode_file_map_entry : 
  ?inode_number:int64 ->
  ?paths:string list ->
  ?type_:inode_file_map_entry_type ->
  unit ->
  inode_file_map_entry
(** [make_inode_file_map_entry … ()] is a builder for type [inode_file_map_entry] *)

val copy_inode_file_map_entry : inode_file_map_entry -> inode_file_map_entry

val inode_file_map_entry_has_inode_number : inode_file_map_entry -> bool
  (** presence of field "inode_number" in [inode_file_map_entry] *)

val inode_file_map_entry_set_inode_number : inode_file_map_entry -> int64 -> unit
  (** set field inode_number in inode_file_map_entry *)

val inode_file_map_entry_set_paths : inode_file_map_entry -> string list -> unit
  (** set field paths in inode_file_map_entry *)

val inode_file_map_entry_has_type_ : inode_file_map_entry -> bool
  (** presence of field "type_" in [inode_file_map_entry] *)

val inode_file_map_entry_set_type_ : inode_file_map_entry -> inode_file_map_entry_type -> unit
  (** set field type_ in inode_file_map_entry *)

val make_inode_file_map : 
  ?block_device_id:int64 ->
  ?mount_points:string list ->
  ?entries:inode_file_map_entry list ->
  unit ->
  inode_file_map
(** [make_inode_file_map … ()] is a builder for type [inode_file_map] *)

val copy_inode_file_map : inode_file_map -> inode_file_map

val inode_file_map_has_block_device_id : inode_file_map -> bool
  (** presence of field "block_device_id" in [inode_file_map] *)

val inode_file_map_set_block_device_id : inode_file_map -> int64 -> unit
  (** set field block_device_id in inode_file_map *)

val inode_file_map_set_mount_points : inode_file_map -> string list -> unit
  (** set field mount_points in inode_file_map *)

val inode_file_map_set_entries : inode_file_map -> inode_file_map_entry list -> unit
  (** set field entries in inode_file_map *)

val make_generic_kernel_cpu_frequency_event : 
  ?cpu:int32 ->
  ?freq_hz:int64 ->
  unit ->
  generic_kernel_cpu_frequency_event
(** [make_generic_kernel_cpu_frequency_event … ()] is a builder for type [generic_kernel_cpu_frequency_event] *)

val copy_generic_kernel_cpu_frequency_event : generic_kernel_cpu_frequency_event -> generic_kernel_cpu_frequency_event

val generic_kernel_cpu_frequency_event_has_cpu : generic_kernel_cpu_frequency_event -> bool
  (** presence of field "cpu" in [generic_kernel_cpu_frequency_event] *)

val generic_kernel_cpu_frequency_event_set_cpu : generic_kernel_cpu_frequency_event -> int32 -> unit
  (** set field cpu in generic_kernel_cpu_frequency_event *)

val generic_kernel_cpu_frequency_event_has_freq_hz : generic_kernel_cpu_frequency_event -> bool
  (** presence of field "freq_hz" in [generic_kernel_cpu_frequency_event] *)

val generic_kernel_cpu_frequency_event_set_freq_hz : generic_kernel_cpu_frequency_event -> int64 -> unit
  (** set field freq_hz in generic_kernel_cpu_frequency_event *)

val make_generic_kernel_task_state_event : 
  ?cpu:int32 ->
  ?comm:string ->
  ?tid:int64 ->
  ?state:generic_kernel_task_state_event_task_state_enum ->
  ?prio:int32 ->
  unit ->
  generic_kernel_task_state_event
(** [make_generic_kernel_task_state_event … ()] is a builder for type [generic_kernel_task_state_event] *)

val copy_generic_kernel_task_state_event : generic_kernel_task_state_event -> generic_kernel_task_state_event

val generic_kernel_task_state_event_has_cpu : generic_kernel_task_state_event -> bool
  (** presence of field "cpu" in [generic_kernel_task_state_event] *)

val generic_kernel_task_state_event_set_cpu : generic_kernel_task_state_event -> int32 -> unit
  (** set field cpu in generic_kernel_task_state_event *)

val generic_kernel_task_state_event_has_comm : generic_kernel_task_state_event -> bool
  (** presence of field "comm" in [generic_kernel_task_state_event] *)

val generic_kernel_task_state_event_set_comm : generic_kernel_task_state_event -> string -> unit
  (** set field comm in generic_kernel_task_state_event *)

val generic_kernel_task_state_event_has_tid : generic_kernel_task_state_event -> bool
  (** presence of field "tid" in [generic_kernel_task_state_event] *)

val generic_kernel_task_state_event_set_tid : generic_kernel_task_state_event -> int64 -> unit
  (** set field tid in generic_kernel_task_state_event *)

val generic_kernel_task_state_event_has_state : generic_kernel_task_state_event -> bool
  (** presence of field "state" in [generic_kernel_task_state_event] *)

val generic_kernel_task_state_event_set_state : generic_kernel_task_state_event -> generic_kernel_task_state_event_task_state_enum -> unit
  (** set field state in generic_kernel_task_state_event *)

val generic_kernel_task_state_event_has_prio : generic_kernel_task_state_event -> bool
  (** presence of field "prio" in [generic_kernel_task_state_event] *)

val generic_kernel_task_state_event_set_prio : generic_kernel_task_state_event -> int32 -> unit
  (** set field prio in generic_kernel_task_state_event *)

val make_generic_kernel_task_rename_event : 
  ?tid:int64 ->
  ?comm:string ->
  unit ->
  generic_kernel_task_rename_event
(** [make_generic_kernel_task_rename_event … ()] is a builder for type [generic_kernel_task_rename_event] *)

val copy_generic_kernel_task_rename_event : generic_kernel_task_rename_event -> generic_kernel_task_rename_event

val generic_kernel_task_rename_event_has_tid : generic_kernel_task_rename_event -> bool
  (** presence of field "tid" in [generic_kernel_task_rename_event] *)

val generic_kernel_task_rename_event_set_tid : generic_kernel_task_rename_event -> int64 -> unit
  (** set field tid in generic_kernel_task_rename_event *)

val generic_kernel_task_rename_event_has_comm : generic_kernel_task_rename_event -> bool
  (** presence of field "comm" in [generic_kernel_task_rename_event] *)

val generic_kernel_task_rename_event_set_comm : generic_kernel_task_rename_event -> string -> unit
  (** set field comm in generic_kernel_task_rename_event *)

val make_generic_kernel_process_tree_thread : 
  ?tid:int64 ->
  ?pid:int64 ->
  ?comm:string ->
  ?is_main_thread:bool ->
  unit ->
  generic_kernel_process_tree_thread
(** [make_generic_kernel_process_tree_thread … ()] is a builder for type [generic_kernel_process_tree_thread] *)

val copy_generic_kernel_process_tree_thread : generic_kernel_process_tree_thread -> generic_kernel_process_tree_thread

val generic_kernel_process_tree_thread_has_tid : generic_kernel_process_tree_thread -> bool
  (** presence of field "tid" in [generic_kernel_process_tree_thread] *)

val generic_kernel_process_tree_thread_set_tid : generic_kernel_process_tree_thread -> int64 -> unit
  (** set field tid in generic_kernel_process_tree_thread *)

val generic_kernel_process_tree_thread_has_pid : generic_kernel_process_tree_thread -> bool
  (** presence of field "pid" in [generic_kernel_process_tree_thread] *)

val generic_kernel_process_tree_thread_set_pid : generic_kernel_process_tree_thread -> int64 -> unit
  (** set field pid in generic_kernel_process_tree_thread *)

val generic_kernel_process_tree_thread_has_comm : generic_kernel_process_tree_thread -> bool
  (** presence of field "comm" in [generic_kernel_process_tree_thread] *)

val generic_kernel_process_tree_thread_set_comm : generic_kernel_process_tree_thread -> string -> unit
  (** set field comm in generic_kernel_process_tree_thread *)

val generic_kernel_process_tree_thread_has_is_main_thread : generic_kernel_process_tree_thread -> bool
  (** presence of field "is_main_thread" in [generic_kernel_process_tree_thread] *)

val generic_kernel_process_tree_thread_set_is_main_thread : generic_kernel_process_tree_thread -> bool -> unit
  (** set field is_main_thread in generic_kernel_process_tree_thread *)

val make_generic_kernel_process_tree_process : 
  ?pid:int64 ->
  ?ppid:int64 ->
  ?cmdline:string ->
  unit ->
  generic_kernel_process_tree_process
(** [make_generic_kernel_process_tree_process … ()] is a builder for type [generic_kernel_process_tree_process] *)

val copy_generic_kernel_process_tree_process : generic_kernel_process_tree_process -> generic_kernel_process_tree_process

val generic_kernel_process_tree_process_has_pid : generic_kernel_process_tree_process -> bool
  (** presence of field "pid" in [generic_kernel_process_tree_process] *)

val generic_kernel_process_tree_process_set_pid : generic_kernel_process_tree_process -> int64 -> unit
  (** set field pid in generic_kernel_process_tree_process *)

val generic_kernel_process_tree_process_has_ppid : generic_kernel_process_tree_process -> bool
  (** presence of field "ppid" in [generic_kernel_process_tree_process] *)

val generic_kernel_process_tree_process_set_ppid : generic_kernel_process_tree_process -> int64 -> unit
  (** set field ppid in generic_kernel_process_tree_process *)

val generic_kernel_process_tree_process_has_cmdline : generic_kernel_process_tree_process -> bool
  (** presence of field "cmdline" in [generic_kernel_process_tree_process] *)

val generic_kernel_process_tree_process_set_cmdline : generic_kernel_process_tree_process -> string -> unit
  (** set field cmdline in generic_kernel_process_tree_process *)

val make_generic_kernel_process_tree : 
  ?processes:generic_kernel_process_tree_process list ->
  ?threads:generic_kernel_process_tree_thread list ->
  unit ->
  generic_kernel_process_tree
(** [make_generic_kernel_process_tree … ()] is a builder for type [generic_kernel_process_tree] *)

val copy_generic_kernel_process_tree : generic_kernel_process_tree -> generic_kernel_process_tree

val generic_kernel_process_tree_set_processes : generic_kernel_process_tree -> generic_kernel_process_tree_process list -> unit
  (** set field processes in generic_kernel_process_tree *)

val generic_kernel_process_tree_set_threads : generic_kernel_process_tree -> generic_kernel_process_tree_thread list -> unit
  (** set field threads in generic_kernel_process_tree *)

val make_gpu_counter_event_gpu_counter : 
  ?counter_id:int32 ->
  ?value:gpu_counter_event_gpu_counter_value ->
  unit ->
  gpu_counter_event_gpu_counter
(** [make_gpu_counter_event_gpu_counter … ()] is a builder for type [gpu_counter_event_gpu_counter] *)

val copy_gpu_counter_event_gpu_counter : gpu_counter_event_gpu_counter -> gpu_counter_event_gpu_counter

val gpu_counter_event_gpu_counter_has_counter_id : gpu_counter_event_gpu_counter -> bool
  (** presence of field "counter_id" in [gpu_counter_event_gpu_counter] *)

val gpu_counter_event_gpu_counter_set_counter_id : gpu_counter_event_gpu_counter -> int32 -> unit
  (** set field counter_id in gpu_counter_event_gpu_counter *)

val gpu_counter_event_gpu_counter_set_value : gpu_counter_event_gpu_counter -> gpu_counter_event_gpu_counter_value -> unit
  (** set field value in gpu_counter_event_gpu_counter *)

val make_gpu_counter_event : 
  ?counter_descriptor:gpu_counter_descriptor ->
  ?counters:gpu_counter_event_gpu_counter list ->
  ?gpu_id:int32 ->
  unit ->
  gpu_counter_event
(** [make_gpu_counter_event … ()] is a builder for type [gpu_counter_event] *)

val copy_gpu_counter_event : gpu_counter_event -> gpu_counter_event

val gpu_counter_event_set_counter_descriptor : gpu_counter_event -> gpu_counter_descriptor -> unit
  (** set field counter_descriptor in gpu_counter_event *)

val gpu_counter_event_set_counters : gpu_counter_event -> gpu_counter_event_gpu_counter list -> unit
  (** set field counters in gpu_counter_event *)

val gpu_counter_event_has_gpu_id : gpu_counter_event -> bool
  (** presence of field "gpu_id" in [gpu_counter_event] *)

val gpu_counter_event_set_gpu_id : gpu_counter_event -> int32 -> unit
  (** set field gpu_id in gpu_counter_event *)

val make_gpu_log : 
  ?severity:gpu_log_severity ->
  ?tag:string ->
  ?log_message:string ->
  unit ->
  gpu_log
(** [make_gpu_log … ()] is a builder for type [gpu_log] *)

val copy_gpu_log : gpu_log -> gpu_log

val gpu_log_has_severity : gpu_log -> bool
  (** presence of field "severity" in [gpu_log] *)

val gpu_log_set_severity : gpu_log -> gpu_log_severity -> unit
  (** set field severity in gpu_log *)

val gpu_log_has_tag : gpu_log -> bool
  (** presence of field "tag" in [gpu_log] *)

val gpu_log_set_tag : gpu_log -> string -> unit
  (** set field tag in gpu_log *)

val gpu_log_has_log_message : gpu_log -> bool
  (** presence of field "log_message" in [gpu_log] *)

val gpu_log_set_log_message : gpu_log -> string -> unit
  (** set field log_message in gpu_log *)

val make_gpu_render_stage_event_extra_data : 
  ?name:string ->
  ?value:string ->
  unit ->
  gpu_render_stage_event_extra_data
(** [make_gpu_render_stage_event_extra_data … ()] is a builder for type [gpu_render_stage_event_extra_data] *)

val copy_gpu_render_stage_event_extra_data : gpu_render_stage_event_extra_data -> gpu_render_stage_event_extra_data

val gpu_render_stage_event_extra_data_has_name : gpu_render_stage_event_extra_data -> bool
  (** presence of field "name" in [gpu_render_stage_event_extra_data] *)

val gpu_render_stage_event_extra_data_set_name : gpu_render_stage_event_extra_data -> string -> unit
  (** set field name in gpu_render_stage_event_extra_data *)

val gpu_render_stage_event_extra_data_has_value : gpu_render_stage_event_extra_data -> bool
  (** presence of field "value" in [gpu_render_stage_event_extra_data] *)

val gpu_render_stage_event_extra_data_set_value : gpu_render_stage_event_extra_data -> string -> unit
  (** set field value in gpu_render_stage_event_extra_data *)

val make_gpu_render_stage_event_specifications_context_spec : 
  ?context:int64 ->
  ?pid:int32 ->
  unit ->
  gpu_render_stage_event_specifications_context_spec
(** [make_gpu_render_stage_event_specifications_context_spec … ()] is a builder for type [gpu_render_stage_event_specifications_context_spec] *)

val copy_gpu_render_stage_event_specifications_context_spec : gpu_render_stage_event_specifications_context_spec -> gpu_render_stage_event_specifications_context_spec

val gpu_render_stage_event_specifications_context_spec_has_context : gpu_render_stage_event_specifications_context_spec -> bool
  (** presence of field "context" in [gpu_render_stage_event_specifications_context_spec] *)

val gpu_render_stage_event_specifications_context_spec_set_context : gpu_render_stage_event_specifications_context_spec -> int64 -> unit
  (** set field context in gpu_render_stage_event_specifications_context_spec *)

val gpu_render_stage_event_specifications_context_spec_has_pid : gpu_render_stage_event_specifications_context_spec -> bool
  (** presence of field "pid" in [gpu_render_stage_event_specifications_context_spec] *)

val gpu_render_stage_event_specifications_context_spec_set_pid : gpu_render_stage_event_specifications_context_spec -> int32 -> unit
  (** set field pid in gpu_render_stage_event_specifications_context_spec *)

val make_gpu_render_stage_event_specifications_description : 
  ?name:string ->
  ?description:string ->
  unit ->
  gpu_render_stage_event_specifications_description
(** [make_gpu_render_stage_event_specifications_description … ()] is a builder for type [gpu_render_stage_event_specifications_description] *)

val copy_gpu_render_stage_event_specifications_description : gpu_render_stage_event_specifications_description -> gpu_render_stage_event_specifications_description

val gpu_render_stage_event_specifications_description_has_name : gpu_render_stage_event_specifications_description -> bool
  (** presence of field "name" in [gpu_render_stage_event_specifications_description] *)

val gpu_render_stage_event_specifications_description_set_name : gpu_render_stage_event_specifications_description -> string -> unit
  (** set field name in gpu_render_stage_event_specifications_description *)

val gpu_render_stage_event_specifications_description_has_description : gpu_render_stage_event_specifications_description -> bool
  (** presence of field "description" in [gpu_render_stage_event_specifications_description] *)

val gpu_render_stage_event_specifications_description_set_description : gpu_render_stage_event_specifications_description -> string -> unit
  (** set field description in gpu_render_stage_event_specifications_description *)

val make_gpu_render_stage_event_specifications : 
  ?context_spec:gpu_render_stage_event_specifications_context_spec ->
  ?hw_queue:gpu_render_stage_event_specifications_description list ->
  ?stage:gpu_render_stage_event_specifications_description list ->
  unit ->
  gpu_render_stage_event_specifications
(** [make_gpu_render_stage_event_specifications … ()] is a builder for type [gpu_render_stage_event_specifications] *)

val copy_gpu_render_stage_event_specifications : gpu_render_stage_event_specifications -> gpu_render_stage_event_specifications

val gpu_render_stage_event_specifications_set_context_spec : gpu_render_stage_event_specifications -> gpu_render_stage_event_specifications_context_spec -> unit
  (** set field context_spec in gpu_render_stage_event_specifications *)

val gpu_render_stage_event_specifications_set_hw_queue : gpu_render_stage_event_specifications -> gpu_render_stage_event_specifications_description list -> unit
  (** set field hw_queue in gpu_render_stage_event_specifications *)

val gpu_render_stage_event_specifications_set_stage : gpu_render_stage_event_specifications -> gpu_render_stage_event_specifications_description list -> unit
  (** set field stage in gpu_render_stage_event_specifications *)

val make_gpu_render_stage_event : 
  ?event_id:int64 ->
  ?duration:int64 ->
  ?hw_queue_iid:int64 ->
  ?stage_iid:int64 ->
  ?gpu_id:int32 ->
  ?context:int64 ->
  ?render_target_handle:int64 ->
  ?submission_id:int32 ->
  ?extra_data:gpu_render_stage_event_extra_data list ->
  ?render_pass_handle:int64 ->
  ?render_pass_instance_id:int64 ->
  ?render_subpass_index_mask:int64 list ->
  ?command_buffer_handle:int64 ->
  ?specifications:gpu_render_stage_event_specifications ->
  ?hw_queue_id:int32 ->
  ?stage_id:int32 ->
  unit ->
  gpu_render_stage_event
(** [make_gpu_render_stage_event … ()] is a builder for type [gpu_render_stage_event] *)

val copy_gpu_render_stage_event : gpu_render_stage_event -> gpu_render_stage_event

val gpu_render_stage_event_has_event_id : gpu_render_stage_event -> bool
  (** presence of field "event_id" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_event_id : gpu_render_stage_event -> int64 -> unit
  (** set field event_id in gpu_render_stage_event *)

val gpu_render_stage_event_has_duration : gpu_render_stage_event -> bool
  (** presence of field "duration" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_duration : gpu_render_stage_event -> int64 -> unit
  (** set field duration in gpu_render_stage_event *)

val gpu_render_stage_event_has_hw_queue_iid : gpu_render_stage_event -> bool
  (** presence of field "hw_queue_iid" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_hw_queue_iid : gpu_render_stage_event -> int64 -> unit
  (** set field hw_queue_iid in gpu_render_stage_event *)

val gpu_render_stage_event_has_stage_iid : gpu_render_stage_event -> bool
  (** presence of field "stage_iid" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_stage_iid : gpu_render_stage_event -> int64 -> unit
  (** set field stage_iid in gpu_render_stage_event *)

val gpu_render_stage_event_has_gpu_id : gpu_render_stage_event -> bool
  (** presence of field "gpu_id" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_gpu_id : gpu_render_stage_event -> int32 -> unit
  (** set field gpu_id in gpu_render_stage_event *)

val gpu_render_stage_event_has_context : gpu_render_stage_event -> bool
  (** presence of field "context" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_context : gpu_render_stage_event -> int64 -> unit
  (** set field context in gpu_render_stage_event *)

val gpu_render_stage_event_has_render_target_handle : gpu_render_stage_event -> bool
  (** presence of field "render_target_handle" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_render_target_handle : gpu_render_stage_event -> int64 -> unit
  (** set field render_target_handle in gpu_render_stage_event *)

val gpu_render_stage_event_has_submission_id : gpu_render_stage_event -> bool
  (** presence of field "submission_id" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_submission_id : gpu_render_stage_event -> int32 -> unit
  (** set field submission_id in gpu_render_stage_event *)

val gpu_render_stage_event_set_extra_data : gpu_render_stage_event -> gpu_render_stage_event_extra_data list -> unit
  (** set field extra_data in gpu_render_stage_event *)

val gpu_render_stage_event_has_render_pass_handle : gpu_render_stage_event -> bool
  (** presence of field "render_pass_handle" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_render_pass_handle : gpu_render_stage_event -> int64 -> unit
  (** set field render_pass_handle in gpu_render_stage_event *)

val gpu_render_stage_event_has_render_pass_instance_id : gpu_render_stage_event -> bool
  (** presence of field "render_pass_instance_id" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_render_pass_instance_id : gpu_render_stage_event -> int64 -> unit
  (** set field render_pass_instance_id in gpu_render_stage_event *)

val gpu_render_stage_event_set_render_subpass_index_mask : gpu_render_stage_event -> int64 list -> unit
  (** set field render_subpass_index_mask in gpu_render_stage_event *)

val gpu_render_stage_event_has_command_buffer_handle : gpu_render_stage_event -> bool
  (** presence of field "command_buffer_handle" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_command_buffer_handle : gpu_render_stage_event -> int64 -> unit
  (** set field command_buffer_handle in gpu_render_stage_event *)

val gpu_render_stage_event_set_specifications : gpu_render_stage_event -> gpu_render_stage_event_specifications -> unit
  (** set field specifications in gpu_render_stage_event *)

val gpu_render_stage_event_has_hw_queue_id : gpu_render_stage_event -> bool
  (** presence of field "hw_queue_id" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_hw_queue_id : gpu_render_stage_event -> int32 -> unit
  (** set field hw_queue_id in gpu_render_stage_event *)

val gpu_render_stage_event_has_stage_id : gpu_render_stage_event -> bool
  (** presence of field "stage_id" in [gpu_render_stage_event] *)

val gpu_render_stage_event_set_stage_id : gpu_render_stage_event -> int32 -> unit
  (** set field stage_id in gpu_render_stage_event *)

val make_interned_graphics_context : 
  ?iid:int64 ->
  ?pid:int32 ->
  ?api:interned_graphics_context_api ->
  unit ->
  interned_graphics_context
(** [make_interned_graphics_context … ()] is a builder for type [interned_graphics_context] *)

val copy_interned_graphics_context : interned_graphics_context -> interned_graphics_context

val interned_graphics_context_has_iid : interned_graphics_context -> bool
  (** presence of field "iid" in [interned_graphics_context] *)

val interned_graphics_context_set_iid : interned_graphics_context -> int64 -> unit
  (** set field iid in interned_graphics_context *)

val interned_graphics_context_has_pid : interned_graphics_context -> bool
  (** presence of field "pid" in [interned_graphics_context] *)

val interned_graphics_context_set_pid : interned_graphics_context -> int32 -> unit
  (** set field pid in interned_graphics_context *)

val interned_graphics_context_has_api : interned_graphics_context -> bool
  (** presence of field "api" in [interned_graphics_context] *)

val interned_graphics_context_set_api : interned_graphics_context -> interned_graphics_context_api -> unit
  (** set field api in interned_graphics_context *)

val make_interned_gpu_render_stage_specification : 
  ?iid:int64 ->
  ?name:string ->
  ?description:string ->
  ?category:interned_gpu_render_stage_specification_render_stage_category ->
  unit ->
  interned_gpu_render_stage_specification
(** [make_interned_gpu_render_stage_specification … ()] is a builder for type [interned_gpu_render_stage_specification] *)

val copy_interned_gpu_render_stage_specification : interned_gpu_render_stage_specification -> interned_gpu_render_stage_specification

val interned_gpu_render_stage_specification_has_iid : interned_gpu_render_stage_specification -> bool
  (** presence of field "iid" in [interned_gpu_render_stage_specification] *)

val interned_gpu_render_stage_specification_set_iid : interned_gpu_render_stage_specification -> int64 -> unit
  (** set field iid in interned_gpu_render_stage_specification *)

val interned_gpu_render_stage_specification_has_name : interned_gpu_render_stage_specification -> bool
  (** presence of field "name" in [interned_gpu_render_stage_specification] *)

val interned_gpu_render_stage_specification_set_name : interned_gpu_render_stage_specification -> string -> unit
  (** set field name in interned_gpu_render_stage_specification *)

val interned_gpu_render_stage_specification_has_description : interned_gpu_render_stage_specification -> bool
  (** presence of field "description" in [interned_gpu_render_stage_specification] *)

val interned_gpu_render_stage_specification_set_description : interned_gpu_render_stage_specification -> string -> unit
  (** set field description in interned_gpu_render_stage_specification *)

val interned_gpu_render_stage_specification_has_category : interned_gpu_render_stage_specification -> bool
  (** presence of field "category" in [interned_gpu_render_stage_specification] *)

val interned_gpu_render_stage_specification_set_category : interned_gpu_render_stage_specification -> interned_gpu_render_stage_specification_render_stage_category -> unit
  (** set field category in interned_gpu_render_stage_specification *)

val make_vulkan_api_event_vk_debug_utils_object_name : 
  ?pid:int32 ->
  ?vk_device:int64 ->
  ?object_type:int32 ->
  ?object_:int64 ->
  ?object_name:string ->
  unit ->
  vulkan_api_event_vk_debug_utils_object_name
(** [make_vulkan_api_event_vk_debug_utils_object_name … ()] is a builder for type [vulkan_api_event_vk_debug_utils_object_name] *)

val copy_vulkan_api_event_vk_debug_utils_object_name : vulkan_api_event_vk_debug_utils_object_name -> vulkan_api_event_vk_debug_utils_object_name

val vulkan_api_event_vk_debug_utils_object_name_has_pid : vulkan_api_event_vk_debug_utils_object_name -> bool
  (** presence of field "pid" in [vulkan_api_event_vk_debug_utils_object_name] *)

val vulkan_api_event_vk_debug_utils_object_name_set_pid : vulkan_api_event_vk_debug_utils_object_name -> int32 -> unit
  (** set field pid in vulkan_api_event_vk_debug_utils_object_name *)

val vulkan_api_event_vk_debug_utils_object_name_has_vk_device : vulkan_api_event_vk_debug_utils_object_name -> bool
  (** presence of field "vk_device" in [vulkan_api_event_vk_debug_utils_object_name] *)

val vulkan_api_event_vk_debug_utils_object_name_set_vk_device : vulkan_api_event_vk_debug_utils_object_name -> int64 -> unit
  (** set field vk_device in vulkan_api_event_vk_debug_utils_object_name *)

val vulkan_api_event_vk_debug_utils_object_name_has_object_type : vulkan_api_event_vk_debug_utils_object_name -> bool
  (** presence of field "object_type" in [vulkan_api_event_vk_debug_utils_object_name] *)

val vulkan_api_event_vk_debug_utils_object_name_set_object_type : vulkan_api_event_vk_debug_utils_object_name -> int32 -> unit
  (** set field object_type in vulkan_api_event_vk_debug_utils_object_name *)

val vulkan_api_event_vk_debug_utils_object_name_has_object_ : vulkan_api_event_vk_debug_utils_object_name -> bool
  (** presence of field "object_" in [vulkan_api_event_vk_debug_utils_object_name] *)

val vulkan_api_event_vk_debug_utils_object_name_set_object_ : vulkan_api_event_vk_debug_utils_object_name -> int64 -> unit
  (** set field object_ in vulkan_api_event_vk_debug_utils_object_name *)

val vulkan_api_event_vk_debug_utils_object_name_has_object_name : vulkan_api_event_vk_debug_utils_object_name -> bool
  (** presence of field "object_name" in [vulkan_api_event_vk_debug_utils_object_name] *)

val vulkan_api_event_vk_debug_utils_object_name_set_object_name : vulkan_api_event_vk_debug_utils_object_name -> string -> unit
  (** set field object_name in vulkan_api_event_vk_debug_utils_object_name *)

val make_vulkan_api_event_vk_queue_submit : 
  ?duration_ns:int64 ->
  ?pid:int32 ->
  ?tid:int32 ->
  ?vk_queue:int64 ->
  ?vk_command_buffers:int64 list ->
  ?submission_id:int32 ->
  unit ->
  vulkan_api_event_vk_queue_submit
(** [make_vulkan_api_event_vk_queue_submit … ()] is a builder for type [vulkan_api_event_vk_queue_submit] *)

val copy_vulkan_api_event_vk_queue_submit : vulkan_api_event_vk_queue_submit -> vulkan_api_event_vk_queue_submit

val vulkan_api_event_vk_queue_submit_has_duration_ns : vulkan_api_event_vk_queue_submit -> bool
  (** presence of field "duration_ns" in [vulkan_api_event_vk_queue_submit] *)

val vulkan_api_event_vk_queue_submit_set_duration_ns : vulkan_api_event_vk_queue_submit -> int64 -> unit
  (** set field duration_ns in vulkan_api_event_vk_queue_submit *)

val vulkan_api_event_vk_queue_submit_has_pid : vulkan_api_event_vk_queue_submit -> bool
  (** presence of field "pid" in [vulkan_api_event_vk_queue_submit] *)

val vulkan_api_event_vk_queue_submit_set_pid : vulkan_api_event_vk_queue_submit -> int32 -> unit
  (** set field pid in vulkan_api_event_vk_queue_submit *)

val vulkan_api_event_vk_queue_submit_has_tid : vulkan_api_event_vk_queue_submit -> bool
  (** presence of field "tid" in [vulkan_api_event_vk_queue_submit] *)

val vulkan_api_event_vk_queue_submit_set_tid : vulkan_api_event_vk_queue_submit -> int32 -> unit
  (** set field tid in vulkan_api_event_vk_queue_submit *)

val vulkan_api_event_vk_queue_submit_has_vk_queue : vulkan_api_event_vk_queue_submit -> bool
  (** presence of field "vk_queue" in [vulkan_api_event_vk_queue_submit] *)

val vulkan_api_event_vk_queue_submit_set_vk_queue : vulkan_api_event_vk_queue_submit -> int64 -> unit
  (** set field vk_queue in vulkan_api_event_vk_queue_submit *)

val vulkan_api_event_vk_queue_submit_set_vk_command_buffers : vulkan_api_event_vk_queue_submit -> int64 list -> unit
  (** set field vk_command_buffers in vulkan_api_event_vk_queue_submit *)

val vulkan_api_event_vk_queue_submit_has_submission_id : vulkan_api_event_vk_queue_submit -> bool
  (** presence of field "submission_id" in [vulkan_api_event_vk_queue_submit] *)

val vulkan_api_event_vk_queue_submit_set_submission_id : vulkan_api_event_vk_queue_submit -> int32 -> unit
  (** set field submission_id in vulkan_api_event_vk_queue_submit *)

val make_vulkan_memory_event_annotation : 
  ?key_iid:int64 ->
  ?value:vulkan_memory_event_annotation_value ->
  unit ->
  vulkan_memory_event_annotation
(** [make_vulkan_memory_event_annotation … ()] is a builder for type [vulkan_memory_event_annotation] *)

val copy_vulkan_memory_event_annotation : vulkan_memory_event_annotation -> vulkan_memory_event_annotation

val vulkan_memory_event_annotation_has_key_iid : vulkan_memory_event_annotation -> bool
  (** presence of field "key_iid" in [vulkan_memory_event_annotation] *)

val vulkan_memory_event_annotation_set_key_iid : vulkan_memory_event_annotation -> int64 -> unit
  (** set field key_iid in vulkan_memory_event_annotation *)

val vulkan_memory_event_annotation_set_value : vulkan_memory_event_annotation -> vulkan_memory_event_annotation_value -> unit
  (** set field value in vulkan_memory_event_annotation *)

val make_vulkan_memory_event : 
  ?source:vulkan_memory_event_source ->
  ?operation:vulkan_memory_event_operation ->
  ?timestamp:int64 ->
  ?pid:int32 ->
  ?memory_address:int64 ->
  ?memory_size:int64 ->
  ?caller_iid:int64 ->
  ?allocation_scope:vulkan_memory_event_allocation_scope ->
  ?annotations:vulkan_memory_event_annotation list ->
  ?device:int64 ->
  ?device_memory:int64 ->
  ?memory_type:int32 ->
  ?heap:int32 ->
  ?object_handle:int64 ->
  unit ->
  vulkan_memory_event
(** [make_vulkan_memory_event … ()] is a builder for type [vulkan_memory_event] *)

val copy_vulkan_memory_event : vulkan_memory_event -> vulkan_memory_event

val vulkan_memory_event_has_source : vulkan_memory_event -> bool
  (** presence of field "source" in [vulkan_memory_event] *)

val vulkan_memory_event_set_source : vulkan_memory_event -> vulkan_memory_event_source -> unit
  (** set field source in vulkan_memory_event *)

val vulkan_memory_event_has_operation : vulkan_memory_event -> bool
  (** presence of field "operation" in [vulkan_memory_event] *)

val vulkan_memory_event_set_operation : vulkan_memory_event -> vulkan_memory_event_operation -> unit
  (** set field operation in vulkan_memory_event *)

val vulkan_memory_event_has_timestamp : vulkan_memory_event -> bool
  (** presence of field "timestamp" in [vulkan_memory_event] *)

val vulkan_memory_event_set_timestamp : vulkan_memory_event -> int64 -> unit
  (** set field timestamp in vulkan_memory_event *)

val vulkan_memory_event_has_pid : vulkan_memory_event -> bool
  (** presence of field "pid" in [vulkan_memory_event] *)

val vulkan_memory_event_set_pid : vulkan_memory_event -> int32 -> unit
  (** set field pid in vulkan_memory_event *)

val vulkan_memory_event_has_memory_address : vulkan_memory_event -> bool
  (** presence of field "memory_address" in [vulkan_memory_event] *)

val vulkan_memory_event_set_memory_address : vulkan_memory_event -> int64 -> unit
  (** set field memory_address in vulkan_memory_event *)

val vulkan_memory_event_has_memory_size : vulkan_memory_event -> bool
  (** presence of field "memory_size" in [vulkan_memory_event] *)

val vulkan_memory_event_set_memory_size : vulkan_memory_event -> int64 -> unit
  (** set field memory_size in vulkan_memory_event *)

val vulkan_memory_event_has_caller_iid : vulkan_memory_event -> bool
  (** presence of field "caller_iid" in [vulkan_memory_event] *)

val vulkan_memory_event_set_caller_iid : vulkan_memory_event -> int64 -> unit
  (** set field caller_iid in vulkan_memory_event *)

val vulkan_memory_event_has_allocation_scope : vulkan_memory_event -> bool
  (** presence of field "allocation_scope" in [vulkan_memory_event] *)

val vulkan_memory_event_set_allocation_scope : vulkan_memory_event -> vulkan_memory_event_allocation_scope -> unit
  (** set field allocation_scope in vulkan_memory_event *)

val vulkan_memory_event_set_annotations : vulkan_memory_event -> vulkan_memory_event_annotation list -> unit
  (** set field annotations in vulkan_memory_event *)

val vulkan_memory_event_has_device : vulkan_memory_event -> bool
  (** presence of field "device" in [vulkan_memory_event] *)

val vulkan_memory_event_set_device : vulkan_memory_event -> int64 -> unit
  (** set field device in vulkan_memory_event *)

val vulkan_memory_event_has_device_memory : vulkan_memory_event -> bool
  (** presence of field "device_memory" in [vulkan_memory_event] *)

val vulkan_memory_event_set_device_memory : vulkan_memory_event -> int64 -> unit
  (** set field device_memory in vulkan_memory_event *)

val vulkan_memory_event_has_memory_type : vulkan_memory_event -> bool
  (** presence of field "memory_type" in [vulkan_memory_event] *)

val vulkan_memory_event_set_memory_type : vulkan_memory_event -> int32 -> unit
  (** set field memory_type in vulkan_memory_event *)

val vulkan_memory_event_has_heap : vulkan_memory_event -> bool
  (** presence of field "heap" in [vulkan_memory_event] *)

val vulkan_memory_event_set_heap : vulkan_memory_event -> int32 -> unit
  (** set field heap in vulkan_memory_event *)

val vulkan_memory_event_has_object_handle : vulkan_memory_event -> bool
  (** presence of field "object_handle" in [vulkan_memory_event] *)

val vulkan_memory_event_set_object_handle : vulkan_memory_event -> int64 -> unit
  (** set field object_handle in vulkan_memory_event *)

val make_interned_string : 
  ?iid:int64 ->
  ?str:bytes ->
  unit ->
  interned_string
(** [make_interned_string … ()] is a builder for type [interned_string] *)

val copy_interned_string : interned_string -> interned_string

val interned_string_has_iid : interned_string -> bool
  (** presence of field "iid" in [interned_string] *)

val interned_string_set_iid : interned_string -> int64 -> unit
  (** set field iid in interned_string *)

val interned_string_has_str : interned_string -> bool
  (** presence of field "str" in [interned_string] *)

val interned_string_set_str : interned_string -> bytes -> unit
  (** set field str in interned_string *)

val make_line : 
  ?function_name:string ->
  ?source_file_name:string ->
  ?line_number:int32 ->
  unit ->
  line
(** [make_line … ()] is a builder for type [line] *)

val copy_line : line -> line

val line_has_function_name : line -> bool
  (** presence of field "function_name" in [line] *)

val line_set_function_name : line -> string -> unit
  (** set field function_name in line *)

val line_has_source_file_name : line -> bool
  (** presence of field "source_file_name" in [line] *)

val line_set_source_file_name : line -> string -> unit
  (** set field source_file_name in line *)

val line_has_line_number : line -> bool
  (** presence of field "line_number" in [line] *)

val line_set_line_number : line -> int32 -> unit
  (** set field line_number in line *)

val make_address_symbols : 
  ?address:int64 ->
  ?lines:line list ->
  unit ->
  address_symbols
(** [make_address_symbols … ()] is a builder for type [address_symbols] *)

val copy_address_symbols : address_symbols -> address_symbols

val address_symbols_has_address : address_symbols -> bool
  (** presence of field "address" in [address_symbols] *)

val address_symbols_set_address : address_symbols -> int64 -> unit
  (** set field address in address_symbols *)

val address_symbols_set_lines : address_symbols -> line list -> unit
  (** set field lines in address_symbols *)

val make_module_symbols : 
  ?path:string ->
  ?build_id:string ->
  ?address_symbols:address_symbols list ->
  unit ->
  module_symbols
(** [make_module_symbols … ()] is a builder for type [module_symbols] *)

val copy_module_symbols : module_symbols -> module_symbols

val module_symbols_has_path : module_symbols -> bool
  (** presence of field "path" in [module_symbols] *)

val module_symbols_set_path : module_symbols -> string -> unit
  (** set field path in module_symbols *)

val module_symbols_has_build_id : module_symbols -> bool
  (** presence of field "build_id" in [module_symbols] *)

val module_symbols_set_build_id : module_symbols -> string -> unit
  (** set field build_id in module_symbols *)

val module_symbols_set_address_symbols : module_symbols -> address_symbols list -> unit
  (** set field address_symbols in module_symbols *)

val make_mapping : 
  ?iid:int64 ->
  ?build_id:int64 ->
  ?exact_offset:int64 ->
  ?start_offset:int64 ->
  ?start:int64 ->
  ?end_:int64 ->
  ?load_bias:int64 ->
  ?path_string_ids:int64 list ->
  unit ->
  mapping
(** [make_mapping … ()] is a builder for type [mapping] *)

val copy_mapping : mapping -> mapping

val mapping_has_iid : mapping -> bool
  (** presence of field "iid" in [mapping] *)

val mapping_set_iid : mapping -> int64 -> unit
  (** set field iid in mapping *)

val mapping_has_build_id : mapping -> bool
  (** presence of field "build_id" in [mapping] *)

val mapping_set_build_id : mapping -> int64 -> unit
  (** set field build_id in mapping *)

val mapping_has_exact_offset : mapping -> bool
  (** presence of field "exact_offset" in [mapping] *)

val mapping_set_exact_offset : mapping -> int64 -> unit
  (** set field exact_offset in mapping *)

val mapping_has_start_offset : mapping -> bool
  (** presence of field "start_offset" in [mapping] *)

val mapping_set_start_offset : mapping -> int64 -> unit
  (** set field start_offset in mapping *)

val mapping_has_start : mapping -> bool
  (** presence of field "start" in [mapping] *)

val mapping_set_start : mapping -> int64 -> unit
  (** set field start in mapping *)

val mapping_has_end_ : mapping -> bool
  (** presence of field "end_" in [mapping] *)

val mapping_set_end_ : mapping -> int64 -> unit
  (** set field end_ in mapping *)

val mapping_has_load_bias : mapping -> bool
  (** presence of field "load_bias" in [mapping] *)

val mapping_set_load_bias : mapping -> int64 -> unit
  (** set field load_bias in mapping *)

val mapping_set_path_string_ids : mapping -> int64 list -> unit
  (** set field path_string_ids in mapping *)

val make_frame : 
  ?iid:int64 ->
  ?function_name_id:int64 ->
  ?mapping_id:int64 ->
  ?rel_pc:int64 ->
  ?source_path_iid:int64 ->
  ?line_number:int32 ->
  unit ->
  frame
(** [make_frame … ()] is a builder for type [frame] *)

val copy_frame : frame -> frame

val frame_has_iid : frame -> bool
  (** presence of field "iid" in [frame] *)

val frame_set_iid : frame -> int64 -> unit
  (** set field iid in frame *)

val frame_has_function_name_id : frame -> bool
  (** presence of field "function_name_id" in [frame] *)

val frame_set_function_name_id : frame -> int64 -> unit
  (** set field function_name_id in frame *)

val frame_has_mapping_id : frame -> bool
  (** presence of field "mapping_id" in [frame] *)

val frame_set_mapping_id : frame -> int64 -> unit
  (** set field mapping_id in frame *)

val frame_has_rel_pc : frame -> bool
  (** presence of field "rel_pc" in [frame] *)

val frame_set_rel_pc : frame -> int64 -> unit
  (** set field rel_pc in frame *)

val frame_has_source_path_iid : frame -> bool
  (** presence of field "source_path_iid" in [frame] *)

val frame_set_source_path_iid : frame -> int64 -> unit
  (** set field source_path_iid in frame *)

val frame_has_line_number : frame -> bool
  (** presence of field "line_number" in [frame] *)

val frame_set_line_number : frame -> int32 -> unit
  (** set field line_number in frame *)

val make_callstack : 
  ?iid:int64 ->
  ?frame_ids:int64 list ->
  unit ->
  callstack
(** [make_callstack … ()] is a builder for type [callstack] *)

val copy_callstack : callstack -> callstack

val callstack_has_iid : callstack -> bool
  (** presence of field "iid" in [callstack] *)

val callstack_set_iid : callstack -> int64 -> unit
  (** set field iid in callstack *)

val callstack_set_frame_ids : callstack -> int64 list -> unit
  (** set field frame_ids in callstack *)

val make_histogram_name : 
  ?iid:int64 ->
  ?name:string ->
  unit ->
  histogram_name
(** [make_histogram_name … ()] is a builder for type [histogram_name] *)

val copy_histogram_name : histogram_name -> histogram_name

val histogram_name_has_iid : histogram_name -> bool
  (** presence of field "iid" in [histogram_name] *)

val histogram_name_set_iid : histogram_name -> int64 -> unit
  (** set field iid in histogram_name *)

val histogram_name_has_name : histogram_name -> bool
  (** presence of field "name" in [histogram_name] *)

val histogram_name_set_name : histogram_name -> string -> unit
  (** set field name in histogram_name *)

val make_chrome_histogram_sample : 
  ?name_hash:int64 ->
  ?name:string ->
  ?sample:int64 ->
  ?name_iid:int64 ->
  unit ->
  chrome_histogram_sample
(** [make_chrome_histogram_sample … ()] is a builder for type [chrome_histogram_sample] *)

val copy_chrome_histogram_sample : chrome_histogram_sample -> chrome_histogram_sample

val chrome_histogram_sample_has_name_hash : chrome_histogram_sample -> bool
  (** presence of field "name_hash" in [chrome_histogram_sample] *)

val chrome_histogram_sample_set_name_hash : chrome_histogram_sample -> int64 -> unit
  (** set field name_hash in chrome_histogram_sample *)

val chrome_histogram_sample_has_name : chrome_histogram_sample -> bool
  (** presence of field "name" in [chrome_histogram_sample] *)

val chrome_histogram_sample_set_name : chrome_histogram_sample -> string -> unit
  (** set field name in chrome_histogram_sample *)

val chrome_histogram_sample_has_sample : chrome_histogram_sample -> bool
  (** presence of field "sample" in [chrome_histogram_sample] *)

val chrome_histogram_sample_set_sample : chrome_histogram_sample -> int64 -> unit
  (** set field sample in chrome_histogram_sample *)

val chrome_histogram_sample_has_name_iid : chrome_histogram_sample -> bool
  (** presence of field "name_iid" in [chrome_histogram_sample] *)

val chrome_histogram_sample_set_name_iid : chrome_histogram_sample -> int64 -> unit
  (** set field name_iid in chrome_histogram_sample *)

val make_debug_annotation_nested_value : 
  ?nested_type:debug_annotation_nested_value_nested_type ->
  ?dict_keys:string list ->
  ?dict_values:debug_annotation_nested_value list ->
  ?array_values:debug_annotation_nested_value list ->
  ?int_value:int64 ->
  ?double_value:float ->
  ?bool_value:bool ->
  ?string_value:string ->
  unit ->
  debug_annotation_nested_value
(** [make_debug_annotation_nested_value … ()] is a builder for type [debug_annotation_nested_value] *)

val copy_debug_annotation_nested_value : debug_annotation_nested_value -> debug_annotation_nested_value

val debug_annotation_nested_value_has_nested_type : debug_annotation_nested_value -> bool
  (** presence of field "nested_type" in [debug_annotation_nested_value] *)

val debug_annotation_nested_value_set_nested_type : debug_annotation_nested_value -> debug_annotation_nested_value_nested_type -> unit
  (** set field nested_type in debug_annotation_nested_value *)

val debug_annotation_nested_value_set_dict_keys : debug_annotation_nested_value -> string list -> unit
  (** set field dict_keys in debug_annotation_nested_value *)

val debug_annotation_nested_value_set_dict_values : debug_annotation_nested_value -> debug_annotation_nested_value list -> unit
  (** set field dict_values in debug_annotation_nested_value *)

val debug_annotation_nested_value_set_array_values : debug_annotation_nested_value -> debug_annotation_nested_value list -> unit
  (** set field array_values in debug_annotation_nested_value *)

val debug_annotation_nested_value_has_int_value : debug_annotation_nested_value -> bool
  (** presence of field "int_value" in [debug_annotation_nested_value] *)

val debug_annotation_nested_value_set_int_value : debug_annotation_nested_value -> int64 -> unit
  (** set field int_value in debug_annotation_nested_value *)

val debug_annotation_nested_value_has_double_value : debug_annotation_nested_value -> bool
  (** presence of field "double_value" in [debug_annotation_nested_value] *)

val debug_annotation_nested_value_set_double_value : debug_annotation_nested_value -> float -> unit
  (** set field double_value in debug_annotation_nested_value *)

val debug_annotation_nested_value_has_bool_value : debug_annotation_nested_value -> bool
  (** presence of field "bool_value" in [debug_annotation_nested_value] *)

val debug_annotation_nested_value_set_bool_value : debug_annotation_nested_value -> bool -> unit
  (** set field bool_value in debug_annotation_nested_value *)

val debug_annotation_nested_value_has_string_value : debug_annotation_nested_value -> bool
  (** presence of field "string_value" in [debug_annotation_nested_value] *)

val debug_annotation_nested_value_set_string_value : debug_annotation_nested_value -> string -> unit
  (** set field string_value in debug_annotation_nested_value *)

val make_debug_annotation : 
  ?name_field:debug_annotation_name_field ->
  ?value:debug_annotation_value ->
  ?proto_type_descriptor:debug_annotation_proto_type_descriptor ->
  ?proto_value:bytes ->
  ?dict_entries:debug_annotation list ->
  ?array_values:debug_annotation list ->
  unit ->
  debug_annotation
(** [make_debug_annotation … ()] is a builder for type [debug_annotation] *)

val copy_debug_annotation : debug_annotation -> debug_annotation

val debug_annotation_set_name_field : debug_annotation -> debug_annotation_name_field -> unit
  (** set field name_field in debug_annotation *)

val debug_annotation_set_value : debug_annotation -> debug_annotation_value -> unit
  (** set field value in debug_annotation *)

val debug_annotation_set_proto_type_descriptor : debug_annotation -> debug_annotation_proto_type_descriptor -> unit
  (** set field proto_type_descriptor in debug_annotation *)

val debug_annotation_has_proto_value : debug_annotation -> bool
  (** presence of field "proto_value" in [debug_annotation] *)

val debug_annotation_set_proto_value : debug_annotation -> bytes -> unit
  (** set field proto_value in debug_annotation *)

val debug_annotation_set_dict_entries : debug_annotation -> debug_annotation list -> unit
  (** set field dict_entries in debug_annotation *)

val debug_annotation_set_array_values : debug_annotation -> debug_annotation list -> unit
  (** set field array_values in debug_annotation *)

val make_debug_annotation_name : 
  ?iid:int64 ->
  ?name:string ->
  unit ->
  debug_annotation_name
(** [make_debug_annotation_name … ()] is a builder for type [debug_annotation_name] *)

val copy_debug_annotation_name : debug_annotation_name -> debug_annotation_name

val debug_annotation_name_has_iid : debug_annotation_name -> bool
  (** presence of field "iid" in [debug_annotation_name] *)

val debug_annotation_name_set_iid : debug_annotation_name -> int64 -> unit
  (** set field iid in debug_annotation_name *)

val debug_annotation_name_has_name : debug_annotation_name -> bool
  (** presence of field "name" in [debug_annotation_name] *)

val debug_annotation_name_set_name : debug_annotation_name -> string -> unit
  (** set field name in debug_annotation_name *)

val make_debug_annotation_value_type_name : 
  ?iid:int64 ->
  ?name:string ->
  unit ->
  debug_annotation_value_type_name
(** [make_debug_annotation_value_type_name … ()] is a builder for type [debug_annotation_value_type_name] *)

val copy_debug_annotation_value_type_name : debug_annotation_value_type_name -> debug_annotation_value_type_name

val debug_annotation_value_type_name_has_iid : debug_annotation_value_type_name -> bool
  (** presence of field "iid" in [debug_annotation_value_type_name] *)

val debug_annotation_value_type_name_set_iid : debug_annotation_value_type_name -> int64 -> unit
  (** set field iid in debug_annotation_value_type_name *)

val debug_annotation_value_type_name_has_name : debug_annotation_value_type_name -> bool
  (** presence of field "name" in [debug_annotation_value_type_name] *)

val debug_annotation_value_type_name_set_name : debug_annotation_value_type_name -> string -> unit
  (** set field name in debug_annotation_value_type_name *)

val make_log_message : 
  ?source_location_iid:int64 ->
  ?body_iid:int64 ->
  ?prio:log_message_priority ->
  unit ->
  log_message
(** [make_log_message … ()] is a builder for type [log_message] *)

val copy_log_message : log_message -> log_message

val log_message_has_source_location_iid : log_message -> bool
  (** presence of field "source_location_iid" in [log_message] *)

val log_message_set_source_location_iid : log_message -> int64 -> unit
  (** set field source_location_iid in log_message *)

val log_message_has_body_iid : log_message -> bool
  (** presence of field "body_iid" in [log_message] *)

val log_message_set_body_iid : log_message -> int64 -> unit
  (** set field body_iid in log_message *)

val log_message_has_prio : log_message -> bool
  (** presence of field "prio" in [log_message] *)

val log_message_set_prio : log_message -> log_message_priority -> unit
  (** set field prio in log_message *)

val make_log_message_body : 
  ?iid:int64 ->
  ?body:string ->
  unit ->
  log_message_body
(** [make_log_message_body … ()] is a builder for type [log_message_body] *)

val copy_log_message_body : log_message_body -> log_message_body

val log_message_body_has_iid : log_message_body -> bool
  (** presence of field "iid" in [log_message_body] *)

val log_message_body_set_iid : log_message_body -> int64 -> unit
  (** set field iid in log_message_body *)

val log_message_body_has_body : log_message_body -> bool
  (** presence of field "body" in [log_message_body] *)

val log_message_body_set_body : log_message_body -> string -> unit
  (** set field body in log_message_body *)

val make_unsymbolized_source_location : 
  ?iid:int64 ->
  ?mapping_id:int64 ->
  ?rel_pc:int64 ->
  unit ->
  unsymbolized_source_location
(** [make_unsymbolized_source_location … ()] is a builder for type [unsymbolized_source_location] *)

val copy_unsymbolized_source_location : unsymbolized_source_location -> unsymbolized_source_location

val unsymbolized_source_location_has_iid : unsymbolized_source_location -> bool
  (** presence of field "iid" in [unsymbolized_source_location] *)

val unsymbolized_source_location_set_iid : unsymbolized_source_location -> int64 -> unit
  (** set field iid in unsymbolized_source_location *)

val unsymbolized_source_location_has_mapping_id : unsymbolized_source_location -> bool
  (** presence of field "mapping_id" in [unsymbolized_source_location] *)

val unsymbolized_source_location_set_mapping_id : unsymbolized_source_location -> int64 -> unit
  (** set field mapping_id in unsymbolized_source_location *)

val unsymbolized_source_location_has_rel_pc : unsymbolized_source_location -> bool
  (** presence of field "rel_pc" in [unsymbolized_source_location] *)

val unsymbolized_source_location_set_rel_pc : unsymbolized_source_location -> int64 -> unit
  (** set field rel_pc in unsymbolized_source_location *)

val make_source_location : 
  ?iid:int64 ->
  ?file_name:string ->
  ?function_name:string ->
  ?line_number:int32 ->
  unit ->
  source_location
(** [make_source_location … ()] is a builder for type [source_location] *)

val copy_source_location : source_location -> source_location

val source_location_has_iid : source_location -> bool
  (** presence of field "iid" in [source_location] *)

val source_location_set_iid : source_location -> int64 -> unit
  (** set field iid in source_location *)

val source_location_has_file_name : source_location -> bool
  (** presence of field "file_name" in [source_location] *)

val source_location_set_file_name : source_location -> string -> unit
  (** set field file_name in source_location *)

val source_location_has_function_name : source_location -> bool
  (** presence of field "function_name" in [source_location] *)

val source_location_set_function_name : source_location -> string -> unit
  (** set field function_name in source_location *)

val source_location_has_line_number : source_location -> bool
  (** presence of field "line_number" in [source_location] *)

val source_location_set_line_number : source_location -> int32 -> unit
  (** set field line_number in source_location *)

val make_chrome_active_processes : 
  ?pid:int32 list ->
  unit ->
  chrome_active_processes
(** [make_chrome_active_processes … ()] is a builder for type [chrome_active_processes] *)

val copy_chrome_active_processes : chrome_active_processes -> chrome_active_processes

val chrome_active_processes_set_pid : chrome_active_processes -> int32 list -> unit
  (** set field pid in chrome_active_processes *)

val make_chrome_application_state_info : 
  ?application_state:chrome_application_state_info_chrome_application_state ->
  unit ->
  chrome_application_state_info
(** [make_chrome_application_state_info … ()] is a builder for type [chrome_application_state_info] *)

val copy_chrome_application_state_info : chrome_application_state_info -> chrome_application_state_info

val chrome_application_state_info_has_application_state : chrome_application_state_info -> bool
  (** presence of field "application_state" in [chrome_application_state_info] *)

val chrome_application_state_info_set_application_state : chrome_application_state_info -> chrome_application_state_info_chrome_application_state -> unit
  (** set field application_state in chrome_application_state_info *)

val make_chrome_compositor_state_machine_major_state : 
  ?next_action:chrome_compositor_scheduler_action ->
  ?begin_impl_frame_state:chrome_compositor_state_machine_major_state_begin_impl_frame_state ->
  ?begin_main_frame_state:chrome_compositor_state_machine_major_state_begin_main_frame_state ->
  ?layer_tree_frame_sink_state:chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state ->
  ?forced_redraw_state:chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state ->
  unit ->
  chrome_compositor_state_machine_major_state
(** [make_chrome_compositor_state_machine_major_state … ()] is a builder for type [chrome_compositor_state_machine_major_state] *)

val copy_chrome_compositor_state_machine_major_state : chrome_compositor_state_machine_major_state -> chrome_compositor_state_machine_major_state

val chrome_compositor_state_machine_major_state_has_next_action : chrome_compositor_state_machine_major_state -> bool
  (** presence of field "next_action" in [chrome_compositor_state_machine_major_state] *)

val chrome_compositor_state_machine_major_state_set_next_action : chrome_compositor_state_machine_major_state -> chrome_compositor_scheduler_action -> unit
  (** set field next_action in chrome_compositor_state_machine_major_state *)

val chrome_compositor_state_machine_major_state_has_begin_impl_frame_state : chrome_compositor_state_machine_major_state -> bool
  (** presence of field "begin_impl_frame_state" in [chrome_compositor_state_machine_major_state] *)

val chrome_compositor_state_machine_major_state_set_begin_impl_frame_state : chrome_compositor_state_machine_major_state -> chrome_compositor_state_machine_major_state_begin_impl_frame_state -> unit
  (** set field begin_impl_frame_state in chrome_compositor_state_machine_major_state *)

val chrome_compositor_state_machine_major_state_has_begin_main_frame_state : chrome_compositor_state_machine_major_state -> bool
  (** presence of field "begin_main_frame_state" in [chrome_compositor_state_machine_major_state] *)

val chrome_compositor_state_machine_major_state_set_begin_main_frame_state : chrome_compositor_state_machine_major_state -> chrome_compositor_state_machine_major_state_begin_main_frame_state -> unit
  (** set field begin_main_frame_state in chrome_compositor_state_machine_major_state *)

val chrome_compositor_state_machine_major_state_has_layer_tree_frame_sink_state : chrome_compositor_state_machine_major_state -> bool
  (** presence of field "layer_tree_frame_sink_state" in [chrome_compositor_state_machine_major_state] *)

val chrome_compositor_state_machine_major_state_set_layer_tree_frame_sink_state : chrome_compositor_state_machine_major_state -> chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state -> unit
  (** set field layer_tree_frame_sink_state in chrome_compositor_state_machine_major_state *)

val chrome_compositor_state_machine_major_state_has_forced_redraw_state : chrome_compositor_state_machine_major_state -> bool
  (** presence of field "forced_redraw_state" in [chrome_compositor_state_machine_major_state] *)

val chrome_compositor_state_machine_major_state_set_forced_redraw_state : chrome_compositor_state_machine_major_state -> chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state -> unit
  (** set field forced_redraw_state in chrome_compositor_state_machine_major_state *)

val make_chrome_compositor_state_machine_minor_state : 
  ?commit_count:int32 ->
  ?current_frame_number:int32 ->
  ?last_frame_number_submit_performed:int32 ->
  ?last_frame_number_draw_performed:int32 ->
  ?last_frame_number_begin_main_frame_sent:int32 ->
  ?did_draw:bool ->
  ?did_send_begin_main_frame_for_current_frame:bool ->
  ?did_notify_begin_main_frame_not_expected_until:bool ->
  ?did_notify_begin_main_frame_not_expected_soon:bool ->
  ?wants_begin_main_frame_not_expected:bool ->
  ?did_commit_during_frame:bool ->
  ?did_invalidate_layer_tree_frame_sink:bool ->
  ?did_perform_impl_side_invalidaion:bool ->
  ?did_prepare_tiles:bool ->
  ?consecutive_checkerboard_animations:int32 ->
  ?pending_submit_frames:int32 ->
  ?submit_frames_with_current_layer_tree_frame_sink:int32 ->
  ?needs_redraw:bool ->
  ?needs_prepare_tiles:bool ->
  ?needs_begin_main_frame:bool ->
  ?needs_one_begin_impl_frame:bool ->
  ?visible:bool ->
  ?begin_frame_source_paused:bool ->
  ?can_draw:bool ->
  ?resourceless_draw:bool ->
  ?has_pending_tree:bool ->
  ?pending_tree_is_ready_for_activation:bool ->
  ?active_tree_needs_first_draw:bool ->
  ?active_tree_is_ready_to_draw:bool ->
  ?did_create_and_initialize_first_layer_tree_frame_sink:bool ->
  ?tree_priority:chrome_compositor_state_machine_minor_state_tree_priority ->
  ?scroll_handler_state:chrome_compositor_state_machine_minor_state_scroll_handler_state ->
  ?critical_begin_main_frame_to_activate_is_fast:bool ->
  ?main_thread_missed_last_deadline:bool ->
  ?video_needs_begin_frames:bool ->
  ?defer_begin_main_frame:bool ->
  ?last_commit_had_no_updates:bool ->
  ?did_draw_in_last_frame:bool ->
  ?did_submit_in_last_frame:bool ->
  ?needs_impl_side_invalidation:bool ->
  ?current_pending_tree_is_impl_side:bool ->
  ?previous_pending_tree_was_impl_side:bool ->
  ?processing_animation_worklets_for_active_tree:bool ->
  ?processing_animation_worklets_for_pending_tree:bool ->
  ?processing_paint_worklets_for_pending_tree:bool ->
  unit ->
  chrome_compositor_state_machine_minor_state
(** [make_chrome_compositor_state_machine_minor_state … ()] is a builder for type [chrome_compositor_state_machine_minor_state] *)

val copy_chrome_compositor_state_machine_minor_state : chrome_compositor_state_machine_minor_state -> chrome_compositor_state_machine_minor_state

val chrome_compositor_state_machine_minor_state_has_commit_count : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "commit_count" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_commit_count : chrome_compositor_state_machine_minor_state -> int32 -> unit
  (** set field commit_count in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_current_frame_number : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "current_frame_number" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_current_frame_number : chrome_compositor_state_machine_minor_state -> int32 -> unit
  (** set field current_frame_number in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_last_frame_number_submit_performed : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "last_frame_number_submit_performed" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_last_frame_number_submit_performed : chrome_compositor_state_machine_minor_state -> int32 -> unit
  (** set field last_frame_number_submit_performed in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_last_frame_number_draw_performed : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "last_frame_number_draw_performed" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_last_frame_number_draw_performed : chrome_compositor_state_machine_minor_state -> int32 -> unit
  (** set field last_frame_number_draw_performed in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_last_frame_number_begin_main_frame_sent : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "last_frame_number_begin_main_frame_sent" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_last_frame_number_begin_main_frame_sent : chrome_compositor_state_machine_minor_state -> int32 -> unit
  (** set field last_frame_number_begin_main_frame_sent in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_draw : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_draw" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_draw : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_draw in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_send_begin_main_frame_for_current_frame : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_send_begin_main_frame_for_current_frame" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_send_begin_main_frame_for_current_frame : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_send_begin_main_frame_for_current_frame in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_notify_begin_main_frame_not_expected_until : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_notify_begin_main_frame_not_expected_until" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_notify_begin_main_frame_not_expected_until : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_notify_begin_main_frame_not_expected_until in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_notify_begin_main_frame_not_expected_soon : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_notify_begin_main_frame_not_expected_soon" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_notify_begin_main_frame_not_expected_soon : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_notify_begin_main_frame_not_expected_soon in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_wants_begin_main_frame_not_expected : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "wants_begin_main_frame_not_expected" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_wants_begin_main_frame_not_expected : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field wants_begin_main_frame_not_expected in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_commit_during_frame : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_commit_during_frame" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_commit_during_frame : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_commit_during_frame in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_invalidate_layer_tree_frame_sink : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_invalidate_layer_tree_frame_sink" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_invalidate_layer_tree_frame_sink : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_invalidate_layer_tree_frame_sink in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_perform_impl_side_invalidaion : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_perform_impl_side_invalidaion" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_perform_impl_side_invalidaion : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_perform_impl_side_invalidaion in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_prepare_tiles : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_prepare_tiles" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_prepare_tiles : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_prepare_tiles in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_consecutive_checkerboard_animations : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "consecutive_checkerboard_animations" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_consecutive_checkerboard_animations : chrome_compositor_state_machine_minor_state -> int32 -> unit
  (** set field consecutive_checkerboard_animations in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_pending_submit_frames : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "pending_submit_frames" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_pending_submit_frames : chrome_compositor_state_machine_minor_state -> int32 -> unit
  (** set field pending_submit_frames in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_submit_frames_with_current_layer_tree_frame_sink : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "submit_frames_with_current_layer_tree_frame_sink" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_submit_frames_with_current_layer_tree_frame_sink : chrome_compositor_state_machine_minor_state -> int32 -> unit
  (** set field submit_frames_with_current_layer_tree_frame_sink in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_needs_redraw : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "needs_redraw" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_needs_redraw : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field needs_redraw in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_needs_prepare_tiles : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "needs_prepare_tiles" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_needs_prepare_tiles : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field needs_prepare_tiles in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_needs_begin_main_frame : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "needs_begin_main_frame" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_needs_begin_main_frame : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field needs_begin_main_frame in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_needs_one_begin_impl_frame : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "needs_one_begin_impl_frame" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_needs_one_begin_impl_frame : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field needs_one_begin_impl_frame in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_visible : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "visible" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_visible : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field visible in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_begin_frame_source_paused : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "begin_frame_source_paused" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_begin_frame_source_paused : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field begin_frame_source_paused in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_can_draw : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "can_draw" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_can_draw : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field can_draw in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_resourceless_draw : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "resourceless_draw" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_resourceless_draw : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field resourceless_draw in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_has_pending_tree : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "has_pending_tree" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_has_pending_tree : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field has_pending_tree in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_pending_tree_is_ready_for_activation : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "pending_tree_is_ready_for_activation" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_pending_tree_is_ready_for_activation : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field pending_tree_is_ready_for_activation in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_active_tree_needs_first_draw : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "active_tree_needs_first_draw" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_active_tree_needs_first_draw : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field active_tree_needs_first_draw in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_active_tree_is_ready_to_draw : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "active_tree_is_ready_to_draw" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_active_tree_is_ready_to_draw : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field active_tree_is_ready_to_draw in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_create_and_initialize_first_layer_tree_frame_sink : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_create_and_initialize_first_layer_tree_frame_sink" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_create_and_initialize_first_layer_tree_frame_sink : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_create_and_initialize_first_layer_tree_frame_sink in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_tree_priority : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "tree_priority" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_tree_priority : chrome_compositor_state_machine_minor_state -> chrome_compositor_state_machine_minor_state_tree_priority -> unit
  (** set field tree_priority in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_scroll_handler_state : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "scroll_handler_state" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_scroll_handler_state : chrome_compositor_state_machine_minor_state -> chrome_compositor_state_machine_minor_state_scroll_handler_state -> unit
  (** set field scroll_handler_state in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_critical_begin_main_frame_to_activate_is_fast : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "critical_begin_main_frame_to_activate_is_fast" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_critical_begin_main_frame_to_activate_is_fast : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field critical_begin_main_frame_to_activate_is_fast in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_main_thread_missed_last_deadline : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "main_thread_missed_last_deadline" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_main_thread_missed_last_deadline : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field main_thread_missed_last_deadline in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_video_needs_begin_frames : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "video_needs_begin_frames" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_video_needs_begin_frames : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field video_needs_begin_frames in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_defer_begin_main_frame : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "defer_begin_main_frame" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_defer_begin_main_frame : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field defer_begin_main_frame in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_last_commit_had_no_updates : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "last_commit_had_no_updates" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_last_commit_had_no_updates : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field last_commit_had_no_updates in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_draw_in_last_frame : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_draw_in_last_frame" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_draw_in_last_frame : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_draw_in_last_frame in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_did_submit_in_last_frame : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "did_submit_in_last_frame" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_did_submit_in_last_frame : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field did_submit_in_last_frame in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_needs_impl_side_invalidation : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "needs_impl_side_invalidation" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_needs_impl_side_invalidation : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field needs_impl_side_invalidation in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_current_pending_tree_is_impl_side : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "current_pending_tree_is_impl_side" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_current_pending_tree_is_impl_side : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field current_pending_tree_is_impl_side in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_previous_pending_tree_was_impl_side : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "previous_pending_tree_was_impl_side" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_previous_pending_tree_was_impl_side : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field previous_pending_tree_was_impl_side in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_processing_animation_worklets_for_active_tree : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "processing_animation_worklets_for_active_tree" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_processing_animation_worklets_for_active_tree : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field processing_animation_worklets_for_active_tree in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_processing_animation_worklets_for_pending_tree : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "processing_animation_worklets_for_pending_tree" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_processing_animation_worklets_for_pending_tree : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field processing_animation_worklets_for_pending_tree in chrome_compositor_state_machine_minor_state *)

val chrome_compositor_state_machine_minor_state_has_processing_paint_worklets_for_pending_tree : chrome_compositor_state_machine_minor_state -> bool
  (** presence of field "processing_paint_worklets_for_pending_tree" in [chrome_compositor_state_machine_minor_state] *)

val chrome_compositor_state_machine_minor_state_set_processing_paint_worklets_for_pending_tree : chrome_compositor_state_machine_minor_state -> bool -> unit
  (** set field processing_paint_worklets_for_pending_tree in chrome_compositor_state_machine_minor_state *)

val make_chrome_compositor_state_machine : 
  ?major_state:chrome_compositor_state_machine_major_state ->
  ?minor_state:chrome_compositor_state_machine_minor_state ->
  unit ->
  chrome_compositor_state_machine
(** [make_chrome_compositor_state_machine … ()] is a builder for type [chrome_compositor_state_machine] *)

val copy_chrome_compositor_state_machine : chrome_compositor_state_machine -> chrome_compositor_state_machine

val chrome_compositor_state_machine_set_major_state : chrome_compositor_state_machine -> chrome_compositor_state_machine_major_state -> unit
  (** set field major_state in chrome_compositor_state_machine *)

val chrome_compositor_state_machine_set_minor_state : chrome_compositor_state_machine -> chrome_compositor_state_machine_minor_state -> unit
  (** set field minor_state in chrome_compositor_state_machine *)

val make_begin_frame_args : 
  ?type_:begin_frame_args_begin_frame_args_type ->
  ?source_id:int64 ->
  ?sequence_number:int64 ->
  ?frame_time_us:int64 ->
  ?deadline_us:int64 ->
  ?interval_delta_us:int64 ->
  ?on_critical_path:bool ->
  ?animate_only:bool ->
  ?created_from:begin_frame_args_created_from ->
  ?frames_throttled_since_last:int64 ->
  unit ->
  begin_frame_args
(** [make_begin_frame_args … ()] is a builder for type [begin_frame_args] *)

val copy_begin_frame_args : begin_frame_args -> begin_frame_args

val begin_frame_args_has_type_ : begin_frame_args -> bool
  (** presence of field "type_" in [begin_frame_args] *)

val begin_frame_args_set_type_ : begin_frame_args -> begin_frame_args_begin_frame_args_type -> unit
  (** set field type_ in begin_frame_args *)

val begin_frame_args_has_source_id : begin_frame_args -> bool
  (** presence of field "source_id" in [begin_frame_args] *)

val begin_frame_args_set_source_id : begin_frame_args -> int64 -> unit
  (** set field source_id in begin_frame_args *)

val begin_frame_args_has_sequence_number : begin_frame_args -> bool
  (** presence of field "sequence_number" in [begin_frame_args] *)

val begin_frame_args_set_sequence_number : begin_frame_args -> int64 -> unit
  (** set field sequence_number in begin_frame_args *)

val begin_frame_args_has_frame_time_us : begin_frame_args -> bool
  (** presence of field "frame_time_us" in [begin_frame_args] *)

val begin_frame_args_set_frame_time_us : begin_frame_args -> int64 -> unit
  (** set field frame_time_us in begin_frame_args *)

val begin_frame_args_has_deadline_us : begin_frame_args -> bool
  (** presence of field "deadline_us" in [begin_frame_args] *)

val begin_frame_args_set_deadline_us : begin_frame_args -> int64 -> unit
  (** set field deadline_us in begin_frame_args *)

val begin_frame_args_has_interval_delta_us : begin_frame_args -> bool
  (** presence of field "interval_delta_us" in [begin_frame_args] *)

val begin_frame_args_set_interval_delta_us : begin_frame_args -> int64 -> unit
  (** set field interval_delta_us in begin_frame_args *)

val begin_frame_args_has_on_critical_path : begin_frame_args -> bool
  (** presence of field "on_critical_path" in [begin_frame_args] *)

val begin_frame_args_set_on_critical_path : begin_frame_args -> bool -> unit
  (** set field on_critical_path in begin_frame_args *)

val begin_frame_args_has_animate_only : begin_frame_args -> bool
  (** presence of field "animate_only" in [begin_frame_args] *)

val begin_frame_args_set_animate_only : begin_frame_args -> bool -> unit
  (** set field animate_only in begin_frame_args *)

val begin_frame_args_set_created_from : begin_frame_args -> begin_frame_args_created_from -> unit
  (** set field created_from in begin_frame_args *)

val begin_frame_args_has_frames_throttled_since_last : begin_frame_args -> bool
  (** presence of field "frames_throttled_since_last" in [begin_frame_args] *)

val begin_frame_args_set_frames_throttled_since_last : begin_frame_args -> int64 -> unit
  (** set field frames_throttled_since_last in begin_frame_args *)

val make_begin_impl_frame_args_timestamps_in_us : 
  ?interval_delta:int64 ->
  ?now_to_deadline_delta:int64 ->
  ?frame_time_to_now_delta:int64 ->
  ?frame_time_to_deadline_delta:int64 ->
  ?now:int64 ->
  ?frame_time:int64 ->
  ?deadline:int64 ->
  unit ->
  begin_impl_frame_args_timestamps_in_us
(** [make_begin_impl_frame_args_timestamps_in_us … ()] is a builder for type [begin_impl_frame_args_timestamps_in_us] *)

val copy_begin_impl_frame_args_timestamps_in_us : begin_impl_frame_args_timestamps_in_us -> begin_impl_frame_args_timestamps_in_us

val begin_impl_frame_args_timestamps_in_us_has_interval_delta : begin_impl_frame_args_timestamps_in_us -> bool
  (** presence of field "interval_delta" in [begin_impl_frame_args_timestamps_in_us] *)

val begin_impl_frame_args_timestamps_in_us_set_interval_delta : begin_impl_frame_args_timestamps_in_us -> int64 -> unit
  (** set field interval_delta in begin_impl_frame_args_timestamps_in_us *)

val begin_impl_frame_args_timestamps_in_us_has_now_to_deadline_delta : begin_impl_frame_args_timestamps_in_us -> bool
  (** presence of field "now_to_deadline_delta" in [begin_impl_frame_args_timestamps_in_us] *)

val begin_impl_frame_args_timestamps_in_us_set_now_to_deadline_delta : begin_impl_frame_args_timestamps_in_us -> int64 -> unit
  (** set field now_to_deadline_delta in begin_impl_frame_args_timestamps_in_us *)

val begin_impl_frame_args_timestamps_in_us_has_frame_time_to_now_delta : begin_impl_frame_args_timestamps_in_us -> bool
  (** presence of field "frame_time_to_now_delta" in [begin_impl_frame_args_timestamps_in_us] *)

val begin_impl_frame_args_timestamps_in_us_set_frame_time_to_now_delta : begin_impl_frame_args_timestamps_in_us -> int64 -> unit
  (** set field frame_time_to_now_delta in begin_impl_frame_args_timestamps_in_us *)

val begin_impl_frame_args_timestamps_in_us_has_frame_time_to_deadline_delta : begin_impl_frame_args_timestamps_in_us -> bool
  (** presence of field "frame_time_to_deadline_delta" in [begin_impl_frame_args_timestamps_in_us] *)

val begin_impl_frame_args_timestamps_in_us_set_frame_time_to_deadline_delta : begin_impl_frame_args_timestamps_in_us -> int64 -> unit
  (** set field frame_time_to_deadline_delta in begin_impl_frame_args_timestamps_in_us *)

val begin_impl_frame_args_timestamps_in_us_has_now : begin_impl_frame_args_timestamps_in_us -> bool
  (** presence of field "now" in [begin_impl_frame_args_timestamps_in_us] *)

val begin_impl_frame_args_timestamps_in_us_set_now : begin_impl_frame_args_timestamps_in_us -> int64 -> unit
  (** set field now in begin_impl_frame_args_timestamps_in_us *)

val begin_impl_frame_args_timestamps_in_us_has_frame_time : begin_impl_frame_args_timestamps_in_us -> bool
  (** presence of field "frame_time" in [begin_impl_frame_args_timestamps_in_us] *)

val begin_impl_frame_args_timestamps_in_us_set_frame_time : begin_impl_frame_args_timestamps_in_us -> int64 -> unit
  (** set field frame_time in begin_impl_frame_args_timestamps_in_us *)

val begin_impl_frame_args_timestamps_in_us_has_deadline : begin_impl_frame_args_timestamps_in_us -> bool
  (** presence of field "deadline" in [begin_impl_frame_args_timestamps_in_us] *)

val begin_impl_frame_args_timestamps_in_us_set_deadline : begin_impl_frame_args_timestamps_in_us -> int64 -> unit
  (** set field deadline in begin_impl_frame_args_timestamps_in_us *)

val make_begin_impl_frame_args : 
  ?updated_at_us:int64 ->
  ?finished_at_us:int64 ->
  ?state:begin_impl_frame_args_state ->
  ?args:begin_impl_frame_args_args ->
  ?timestamps_in_us:begin_impl_frame_args_timestamps_in_us ->
  unit ->
  begin_impl_frame_args
(** [make_begin_impl_frame_args … ()] is a builder for type [begin_impl_frame_args] *)

val copy_begin_impl_frame_args : begin_impl_frame_args -> begin_impl_frame_args

val begin_impl_frame_args_has_updated_at_us : begin_impl_frame_args -> bool
  (** presence of field "updated_at_us" in [begin_impl_frame_args] *)

val begin_impl_frame_args_set_updated_at_us : begin_impl_frame_args -> int64 -> unit
  (** set field updated_at_us in begin_impl_frame_args *)

val begin_impl_frame_args_has_finished_at_us : begin_impl_frame_args -> bool
  (** presence of field "finished_at_us" in [begin_impl_frame_args] *)

val begin_impl_frame_args_set_finished_at_us : begin_impl_frame_args -> int64 -> unit
  (** set field finished_at_us in begin_impl_frame_args *)

val begin_impl_frame_args_has_state : begin_impl_frame_args -> bool
  (** presence of field "state" in [begin_impl_frame_args] *)

val begin_impl_frame_args_set_state : begin_impl_frame_args -> begin_impl_frame_args_state -> unit
  (** set field state in begin_impl_frame_args *)

val begin_impl_frame_args_set_args : begin_impl_frame_args -> begin_impl_frame_args_args -> unit
  (** set field args in begin_impl_frame_args *)

val begin_impl_frame_args_set_timestamps_in_us : begin_impl_frame_args -> begin_impl_frame_args_timestamps_in_us -> unit
  (** set field timestamps_in_us in begin_impl_frame_args *)

val make_begin_frame_observer_state : 
  ?dropped_begin_frame_args:int64 ->
  ?last_begin_frame_args:begin_frame_args ->
  unit ->
  begin_frame_observer_state
(** [make_begin_frame_observer_state … ()] is a builder for type [begin_frame_observer_state] *)

val copy_begin_frame_observer_state : begin_frame_observer_state -> begin_frame_observer_state

val begin_frame_observer_state_has_dropped_begin_frame_args : begin_frame_observer_state -> bool
  (** presence of field "dropped_begin_frame_args" in [begin_frame_observer_state] *)

val begin_frame_observer_state_set_dropped_begin_frame_args : begin_frame_observer_state -> int64 -> unit
  (** set field dropped_begin_frame_args in begin_frame_observer_state *)

val begin_frame_observer_state_set_last_begin_frame_args : begin_frame_observer_state -> begin_frame_args -> unit
  (** set field last_begin_frame_args in begin_frame_observer_state *)

val make_begin_frame_source_state : 
  ?source_id:int32 ->
  ?paused:bool ->
  ?num_observers:int32 ->
  ?last_begin_frame_args:begin_frame_args ->
  unit ->
  begin_frame_source_state
(** [make_begin_frame_source_state … ()] is a builder for type [begin_frame_source_state] *)

val copy_begin_frame_source_state : begin_frame_source_state -> begin_frame_source_state

val begin_frame_source_state_has_source_id : begin_frame_source_state -> bool
  (** presence of field "source_id" in [begin_frame_source_state] *)

val begin_frame_source_state_set_source_id : begin_frame_source_state -> int32 -> unit
  (** set field source_id in begin_frame_source_state *)

val begin_frame_source_state_has_paused : begin_frame_source_state -> bool
  (** presence of field "paused" in [begin_frame_source_state] *)

val begin_frame_source_state_set_paused : begin_frame_source_state -> bool -> unit
  (** set field paused in begin_frame_source_state *)

val begin_frame_source_state_has_num_observers : begin_frame_source_state -> bool
  (** presence of field "num_observers" in [begin_frame_source_state] *)

val begin_frame_source_state_set_num_observers : begin_frame_source_state -> int32 -> unit
  (** set field num_observers in begin_frame_source_state *)

val begin_frame_source_state_set_last_begin_frame_args : begin_frame_source_state -> begin_frame_args -> unit
  (** set field last_begin_frame_args in begin_frame_source_state *)

val make_compositor_timing_history : 
  ?begin_main_frame_queue_critical_estimate_delta_us:int64 ->
  ?begin_main_frame_queue_not_critical_estimate_delta_us:int64 ->
  ?begin_main_frame_start_to_ready_to_commit_estimate_delta_us:int64 ->
  ?commit_to_ready_to_activate_estimate_delta_us:int64 ->
  ?prepare_tiles_estimate_delta_us:int64 ->
  ?activate_estimate_delta_us:int64 ->
  ?draw_estimate_delta_us:int64 ->
  unit ->
  compositor_timing_history
(** [make_compositor_timing_history … ()] is a builder for type [compositor_timing_history] *)

val copy_compositor_timing_history : compositor_timing_history -> compositor_timing_history

val compositor_timing_history_has_begin_main_frame_queue_critical_estimate_delta_us : compositor_timing_history -> bool
  (** presence of field "begin_main_frame_queue_critical_estimate_delta_us" in [compositor_timing_history] *)

val compositor_timing_history_set_begin_main_frame_queue_critical_estimate_delta_us : compositor_timing_history -> int64 -> unit
  (** set field begin_main_frame_queue_critical_estimate_delta_us in compositor_timing_history *)

val compositor_timing_history_has_begin_main_frame_queue_not_critical_estimate_delta_us : compositor_timing_history -> bool
  (** presence of field "begin_main_frame_queue_not_critical_estimate_delta_us" in [compositor_timing_history] *)

val compositor_timing_history_set_begin_main_frame_queue_not_critical_estimate_delta_us : compositor_timing_history -> int64 -> unit
  (** set field begin_main_frame_queue_not_critical_estimate_delta_us in compositor_timing_history *)

val compositor_timing_history_has_begin_main_frame_start_to_ready_to_commit_estimate_delta_us : compositor_timing_history -> bool
  (** presence of field "begin_main_frame_start_to_ready_to_commit_estimate_delta_us" in [compositor_timing_history] *)

val compositor_timing_history_set_begin_main_frame_start_to_ready_to_commit_estimate_delta_us : compositor_timing_history -> int64 -> unit
  (** set field begin_main_frame_start_to_ready_to_commit_estimate_delta_us in compositor_timing_history *)

val compositor_timing_history_has_commit_to_ready_to_activate_estimate_delta_us : compositor_timing_history -> bool
  (** presence of field "commit_to_ready_to_activate_estimate_delta_us" in [compositor_timing_history] *)

val compositor_timing_history_set_commit_to_ready_to_activate_estimate_delta_us : compositor_timing_history -> int64 -> unit
  (** set field commit_to_ready_to_activate_estimate_delta_us in compositor_timing_history *)

val compositor_timing_history_has_prepare_tiles_estimate_delta_us : compositor_timing_history -> bool
  (** presence of field "prepare_tiles_estimate_delta_us" in [compositor_timing_history] *)

val compositor_timing_history_set_prepare_tiles_estimate_delta_us : compositor_timing_history -> int64 -> unit
  (** set field prepare_tiles_estimate_delta_us in compositor_timing_history *)

val compositor_timing_history_has_activate_estimate_delta_us : compositor_timing_history -> bool
  (** presence of field "activate_estimate_delta_us" in [compositor_timing_history] *)

val compositor_timing_history_set_activate_estimate_delta_us : compositor_timing_history -> int64 -> unit
  (** set field activate_estimate_delta_us in compositor_timing_history *)

val compositor_timing_history_has_draw_estimate_delta_us : compositor_timing_history -> bool
  (** presence of field "draw_estimate_delta_us" in [compositor_timing_history] *)

val compositor_timing_history_set_draw_estimate_delta_us : compositor_timing_history -> int64 -> unit
  (** set field draw_estimate_delta_us in compositor_timing_history *)

val make_chrome_compositor_scheduler_state : 
  ?state_machine:chrome_compositor_state_machine ->
  ?observing_begin_frame_source:bool ->
  ?begin_impl_frame_deadline_task:bool ->
  ?pending_begin_frame_task:bool ->
  ?skipped_last_frame_missed_exceeded_deadline:bool ->
  ?inside_action:chrome_compositor_scheduler_action ->
  ?deadline_mode:chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode ->
  ?deadline_us:int64 ->
  ?deadline_scheduled_at_us:int64 ->
  ?now_us:int64 ->
  ?now_to_deadline_delta_us:int64 ->
  ?now_to_deadline_scheduled_at_delta_us:int64 ->
  ?begin_impl_frame_args:begin_impl_frame_args ->
  ?begin_frame_observer_state:begin_frame_observer_state ->
  ?begin_frame_source_state:begin_frame_source_state ->
  ?compositor_timing_history:compositor_timing_history ->
  unit ->
  chrome_compositor_scheduler_state
(** [make_chrome_compositor_scheduler_state … ()] is a builder for type [chrome_compositor_scheduler_state] *)

val copy_chrome_compositor_scheduler_state : chrome_compositor_scheduler_state -> chrome_compositor_scheduler_state

val chrome_compositor_scheduler_state_set_state_machine : chrome_compositor_scheduler_state -> chrome_compositor_state_machine -> unit
  (** set field state_machine in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_observing_begin_frame_source : chrome_compositor_scheduler_state -> bool
  (** presence of field "observing_begin_frame_source" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_observing_begin_frame_source : chrome_compositor_scheduler_state -> bool -> unit
  (** set field observing_begin_frame_source in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_begin_impl_frame_deadline_task : chrome_compositor_scheduler_state -> bool
  (** presence of field "begin_impl_frame_deadline_task" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_begin_impl_frame_deadline_task : chrome_compositor_scheduler_state -> bool -> unit
  (** set field begin_impl_frame_deadline_task in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_pending_begin_frame_task : chrome_compositor_scheduler_state -> bool
  (** presence of field "pending_begin_frame_task" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_pending_begin_frame_task : chrome_compositor_scheduler_state -> bool -> unit
  (** set field pending_begin_frame_task in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_skipped_last_frame_missed_exceeded_deadline : chrome_compositor_scheduler_state -> bool
  (** presence of field "skipped_last_frame_missed_exceeded_deadline" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_skipped_last_frame_missed_exceeded_deadline : chrome_compositor_scheduler_state -> bool -> unit
  (** set field skipped_last_frame_missed_exceeded_deadline in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_inside_action : chrome_compositor_scheduler_state -> bool
  (** presence of field "inside_action" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_inside_action : chrome_compositor_scheduler_state -> chrome_compositor_scheduler_action -> unit
  (** set field inside_action in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_deadline_mode : chrome_compositor_scheduler_state -> bool
  (** presence of field "deadline_mode" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_deadline_mode : chrome_compositor_scheduler_state -> chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode -> unit
  (** set field deadline_mode in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_deadline_us : chrome_compositor_scheduler_state -> bool
  (** presence of field "deadline_us" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_deadline_us : chrome_compositor_scheduler_state -> int64 -> unit
  (** set field deadline_us in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_deadline_scheduled_at_us : chrome_compositor_scheduler_state -> bool
  (** presence of field "deadline_scheduled_at_us" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_deadline_scheduled_at_us : chrome_compositor_scheduler_state -> int64 -> unit
  (** set field deadline_scheduled_at_us in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_now_us : chrome_compositor_scheduler_state -> bool
  (** presence of field "now_us" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_now_us : chrome_compositor_scheduler_state -> int64 -> unit
  (** set field now_us in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_now_to_deadline_delta_us : chrome_compositor_scheduler_state -> bool
  (** presence of field "now_to_deadline_delta_us" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_now_to_deadline_delta_us : chrome_compositor_scheduler_state -> int64 -> unit
  (** set field now_to_deadline_delta_us in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_has_now_to_deadline_scheduled_at_delta_us : chrome_compositor_scheduler_state -> bool
  (** presence of field "now_to_deadline_scheduled_at_delta_us" in [chrome_compositor_scheduler_state] *)

val chrome_compositor_scheduler_state_set_now_to_deadline_scheduled_at_delta_us : chrome_compositor_scheduler_state -> int64 -> unit
  (** set field now_to_deadline_scheduled_at_delta_us in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_set_begin_impl_frame_args : chrome_compositor_scheduler_state -> begin_impl_frame_args -> unit
  (** set field begin_impl_frame_args in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_set_begin_frame_observer_state : chrome_compositor_scheduler_state -> begin_frame_observer_state -> unit
  (** set field begin_frame_observer_state in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_set_begin_frame_source_state : chrome_compositor_scheduler_state -> begin_frame_source_state -> unit
  (** set field begin_frame_source_state in chrome_compositor_scheduler_state *)

val chrome_compositor_scheduler_state_set_compositor_timing_history : chrome_compositor_scheduler_state -> compositor_timing_history -> unit
  (** set field compositor_timing_history in chrome_compositor_scheduler_state *)

val make_chrome_content_settings_event_info : 
  ?number_of_exceptions:int32 ->
  unit ->
  chrome_content_settings_event_info
(** [make_chrome_content_settings_event_info … ()] is a builder for type [chrome_content_settings_event_info] *)

val copy_chrome_content_settings_event_info : chrome_content_settings_event_info -> chrome_content_settings_event_info

val chrome_content_settings_event_info_has_number_of_exceptions : chrome_content_settings_event_info -> bool
  (** presence of field "number_of_exceptions" in [chrome_content_settings_event_info] *)

val chrome_content_settings_event_info_set_number_of_exceptions : chrome_content_settings_event_info -> int32 -> unit
  (** set field number_of_exceptions in chrome_content_settings_event_info *)

val make_chrome_frame_reporter : 
  ?state:chrome_frame_reporter_state ->
  ?reason:chrome_frame_reporter_frame_drop_reason ->
  ?frame_source:int64 ->
  ?frame_sequence:int64 ->
  ?affects_smoothness:bool ->
  ?scroll_state:chrome_frame_reporter_scroll_state ->
  ?has_main_animation:bool ->
  ?has_compositor_animation:bool ->
  ?has_smooth_input_main:bool ->
  ?has_missing_content:bool ->
  ?layer_tree_host_id:int64 ->
  ?has_high_latency:bool ->
  ?frame_type:chrome_frame_reporter_frame_type ->
  ?high_latency_contribution_stage:string list ->
  ?checkerboarded_needs_raster:bool ->
  ?checkerboarded_needs_record:bool ->
  ?surface_frame_trace_id:int64 ->
  ?display_trace_id:int64 ->
  unit ->
  chrome_frame_reporter
(** [make_chrome_frame_reporter … ()] is a builder for type [chrome_frame_reporter] *)

val copy_chrome_frame_reporter : chrome_frame_reporter -> chrome_frame_reporter

val chrome_frame_reporter_has_state : chrome_frame_reporter -> bool
  (** presence of field "state" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_state : chrome_frame_reporter -> chrome_frame_reporter_state -> unit
  (** set field state in chrome_frame_reporter *)

val chrome_frame_reporter_has_reason : chrome_frame_reporter -> bool
  (** presence of field "reason" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_reason : chrome_frame_reporter -> chrome_frame_reporter_frame_drop_reason -> unit
  (** set field reason in chrome_frame_reporter *)

val chrome_frame_reporter_has_frame_source : chrome_frame_reporter -> bool
  (** presence of field "frame_source" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_frame_source : chrome_frame_reporter -> int64 -> unit
  (** set field frame_source in chrome_frame_reporter *)

val chrome_frame_reporter_has_frame_sequence : chrome_frame_reporter -> bool
  (** presence of field "frame_sequence" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_frame_sequence : chrome_frame_reporter -> int64 -> unit
  (** set field frame_sequence in chrome_frame_reporter *)

val chrome_frame_reporter_has_affects_smoothness : chrome_frame_reporter -> bool
  (** presence of field "affects_smoothness" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_affects_smoothness : chrome_frame_reporter -> bool -> unit
  (** set field affects_smoothness in chrome_frame_reporter *)

val chrome_frame_reporter_has_scroll_state : chrome_frame_reporter -> bool
  (** presence of field "scroll_state" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_scroll_state : chrome_frame_reporter -> chrome_frame_reporter_scroll_state -> unit
  (** set field scroll_state in chrome_frame_reporter *)

val chrome_frame_reporter_has_has_main_animation : chrome_frame_reporter -> bool
  (** presence of field "has_main_animation" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_has_main_animation : chrome_frame_reporter -> bool -> unit
  (** set field has_main_animation in chrome_frame_reporter *)

val chrome_frame_reporter_has_has_compositor_animation : chrome_frame_reporter -> bool
  (** presence of field "has_compositor_animation" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_has_compositor_animation : chrome_frame_reporter -> bool -> unit
  (** set field has_compositor_animation in chrome_frame_reporter *)

val chrome_frame_reporter_has_has_smooth_input_main : chrome_frame_reporter -> bool
  (** presence of field "has_smooth_input_main" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_has_smooth_input_main : chrome_frame_reporter -> bool -> unit
  (** set field has_smooth_input_main in chrome_frame_reporter *)

val chrome_frame_reporter_has_has_missing_content : chrome_frame_reporter -> bool
  (** presence of field "has_missing_content" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_has_missing_content : chrome_frame_reporter -> bool -> unit
  (** set field has_missing_content in chrome_frame_reporter *)

val chrome_frame_reporter_has_layer_tree_host_id : chrome_frame_reporter -> bool
  (** presence of field "layer_tree_host_id" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_layer_tree_host_id : chrome_frame_reporter -> int64 -> unit
  (** set field layer_tree_host_id in chrome_frame_reporter *)

val chrome_frame_reporter_has_has_high_latency : chrome_frame_reporter -> bool
  (** presence of field "has_high_latency" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_has_high_latency : chrome_frame_reporter -> bool -> unit
  (** set field has_high_latency in chrome_frame_reporter *)

val chrome_frame_reporter_has_frame_type : chrome_frame_reporter -> bool
  (** presence of field "frame_type" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_frame_type : chrome_frame_reporter -> chrome_frame_reporter_frame_type -> unit
  (** set field frame_type in chrome_frame_reporter *)

val chrome_frame_reporter_set_high_latency_contribution_stage : chrome_frame_reporter -> string list -> unit
  (** set field high_latency_contribution_stage in chrome_frame_reporter *)

val chrome_frame_reporter_has_checkerboarded_needs_raster : chrome_frame_reporter -> bool
  (** presence of field "checkerboarded_needs_raster" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_checkerboarded_needs_raster : chrome_frame_reporter -> bool -> unit
  (** set field checkerboarded_needs_raster in chrome_frame_reporter *)

val chrome_frame_reporter_has_checkerboarded_needs_record : chrome_frame_reporter -> bool
  (** presence of field "checkerboarded_needs_record" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_checkerboarded_needs_record : chrome_frame_reporter -> bool -> unit
  (** set field checkerboarded_needs_record in chrome_frame_reporter *)

val chrome_frame_reporter_has_surface_frame_trace_id : chrome_frame_reporter -> bool
  (** presence of field "surface_frame_trace_id" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_surface_frame_trace_id : chrome_frame_reporter -> int64 -> unit
  (** set field surface_frame_trace_id in chrome_frame_reporter *)

val chrome_frame_reporter_has_display_trace_id : chrome_frame_reporter -> bool
  (** presence of field "display_trace_id" in [chrome_frame_reporter] *)

val chrome_frame_reporter_set_display_trace_id : chrome_frame_reporter -> int64 -> unit
  (** set field display_trace_id in chrome_frame_reporter *)

val make_chrome_keyed_service : 
  ?name:string ->
  unit ->
  chrome_keyed_service
(** [make_chrome_keyed_service … ()] is a builder for type [chrome_keyed_service] *)

val copy_chrome_keyed_service : chrome_keyed_service -> chrome_keyed_service

val chrome_keyed_service_has_name : chrome_keyed_service -> bool
  (** presence of field "name" in [chrome_keyed_service] *)

val chrome_keyed_service_set_name : chrome_keyed_service -> string -> unit
  (** set field name in chrome_keyed_service *)

val make_chrome_latency_info_component_info : 
  ?component_type:chrome_latency_info_latency_component_type ->
  ?time_us:int64 ->
  unit ->
  chrome_latency_info_component_info
(** [make_chrome_latency_info_component_info … ()] is a builder for type [chrome_latency_info_component_info] *)

val copy_chrome_latency_info_component_info : chrome_latency_info_component_info -> chrome_latency_info_component_info

val chrome_latency_info_component_info_has_component_type : chrome_latency_info_component_info -> bool
  (** presence of field "component_type" in [chrome_latency_info_component_info] *)

val chrome_latency_info_component_info_set_component_type : chrome_latency_info_component_info -> chrome_latency_info_latency_component_type -> unit
  (** set field component_type in chrome_latency_info_component_info *)

val chrome_latency_info_component_info_has_time_us : chrome_latency_info_component_info -> bool
  (** presence of field "time_us" in [chrome_latency_info_component_info] *)

val chrome_latency_info_component_info_set_time_us : chrome_latency_info_component_info -> int64 -> unit
  (** set field time_us in chrome_latency_info_component_info *)

val make_chrome_latency_info : 
  ?trace_id:int64 ->
  ?step:chrome_latency_info_step ->
  ?frame_tree_node_id:int32 ->
  ?component_info:chrome_latency_info_component_info list ->
  ?is_coalesced:bool ->
  ?gesture_scroll_id:int64 ->
  ?touch_id:int64 ->
  ?input_type:chrome_latency_info_input_type ->
  unit ->
  chrome_latency_info
(** [make_chrome_latency_info … ()] is a builder for type [chrome_latency_info] *)

val copy_chrome_latency_info : chrome_latency_info -> chrome_latency_info

val chrome_latency_info_has_trace_id : chrome_latency_info -> bool
  (** presence of field "trace_id" in [chrome_latency_info] *)

val chrome_latency_info_set_trace_id : chrome_latency_info -> int64 -> unit
  (** set field trace_id in chrome_latency_info *)

val chrome_latency_info_has_step : chrome_latency_info -> bool
  (** presence of field "step" in [chrome_latency_info] *)

val chrome_latency_info_set_step : chrome_latency_info -> chrome_latency_info_step -> unit
  (** set field step in chrome_latency_info *)

val chrome_latency_info_has_frame_tree_node_id : chrome_latency_info -> bool
  (** presence of field "frame_tree_node_id" in [chrome_latency_info] *)

val chrome_latency_info_set_frame_tree_node_id : chrome_latency_info -> int32 -> unit
  (** set field frame_tree_node_id in chrome_latency_info *)

val chrome_latency_info_set_component_info : chrome_latency_info -> chrome_latency_info_component_info list -> unit
  (** set field component_info in chrome_latency_info *)

val chrome_latency_info_has_is_coalesced : chrome_latency_info -> bool
  (** presence of field "is_coalesced" in [chrome_latency_info] *)

val chrome_latency_info_set_is_coalesced : chrome_latency_info -> bool -> unit
  (** set field is_coalesced in chrome_latency_info *)

val chrome_latency_info_has_gesture_scroll_id : chrome_latency_info -> bool
  (** presence of field "gesture_scroll_id" in [chrome_latency_info] *)

val chrome_latency_info_set_gesture_scroll_id : chrome_latency_info -> int64 -> unit
  (** set field gesture_scroll_id in chrome_latency_info *)

val chrome_latency_info_has_touch_id : chrome_latency_info -> bool
  (** presence of field "touch_id" in [chrome_latency_info] *)

val chrome_latency_info_set_touch_id : chrome_latency_info -> int64 -> unit
  (** set field touch_id in chrome_latency_info *)

val chrome_latency_info_has_input_type : chrome_latency_info -> bool
  (** presence of field "input_type" in [chrome_latency_info] *)

val chrome_latency_info_set_input_type : chrome_latency_info -> chrome_latency_info_input_type -> unit
  (** set field input_type in chrome_latency_info *)

val make_chrome_legacy_ipc : 
  ?message_class:chrome_legacy_ipc_message_class ->
  ?message_line:int32 ->
  unit ->
  chrome_legacy_ipc
(** [make_chrome_legacy_ipc … ()] is a builder for type [chrome_legacy_ipc] *)

val copy_chrome_legacy_ipc : chrome_legacy_ipc -> chrome_legacy_ipc

val chrome_legacy_ipc_has_message_class : chrome_legacy_ipc -> bool
  (** presence of field "message_class" in [chrome_legacy_ipc] *)

val chrome_legacy_ipc_set_message_class : chrome_legacy_ipc -> chrome_legacy_ipc_message_class -> unit
  (** set field message_class in chrome_legacy_ipc *)

val chrome_legacy_ipc_has_message_line : chrome_legacy_ipc -> bool
  (** presence of field "message_line" in [chrome_legacy_ipc] *)

val chrome_legacy_ipc_set_message_line : chrome_legacy_ipc -> int32 -> unit
  (** set field message_line in chrome_legacy_ipc *)

val make_chrome_message_pump : 
  ?sent_messages_in_queue:bool ->
  ?io_handler_location_iid:int64 ->
  unit ->
  chrome_message_pump
(** [make_chrome_message_pump … ()] is a builder for type [chrome_message_pump] *)

val copy_chrome_message_pump : chrome_message_pump -> chrome_message_pump

val chrome_message_pump_has_sent_messages_in_queue : chrome_message_pump -> bool
  (** presence of field "sent_messages_in_queue" in [chrome_message_pump] *)

val chrome_message_pump_set_sent_messages_in_queue : chrome_message_pump -> bool -> unit
  (** set field sent_messages_in_queue in chrome_message_pump *)

val chrome_message_pump_has_io_handler_location_iid : chrome_message_pump -> bool
  (** presence of field "io_handler_location_iid" in [chrome_message_pump] *)

val chrome_message_pump_set_io_handler_location_iid : chrome_message_pump -> int64 -> unit
  (** set field io_handler_location_iid in chrome_message_pump *)

val make_chrome_mojo_event_info : 
  ?watcher_notify_interface_tag:string ->
  ?ipc_hash:int32 ->
  ?mojo_interface_tag:string ->
  ?mojo_interface_method_iid:int64 ->
  ?is_reply:bool ->
  ?payload_size:int64 ->
  ?data_num_bytes:int64 ->
  unit ->
  chrome_mojo_event_info
(** [make_chrome_mojo_event_info … ()] is a builder for type [chrome_mojo_event_info] *)

val copy_chrome_mojo_event_info : chrome_mojo_event_info -> chrome_mojo_event_info

val chrome_mojo_event_info_has_watcher_notify_interface_tag : chrome_mojo_event_info -> bool
  (** presence of field "watcher_notify_interface_tag" in [chrome_mojo_event_info] *)

val chrome_mojo_event_info_set_watcher_notify_interface_tag : chrome_mojo_event_info -> string -> unit
  (** set field watcher_notify_interface_tag in chrome_mojo_event_info *)

val chrome_mojo_event_info_has_ipc_hash : chrome_mojo_event_info -> bool
  (** presence of field "ipc_hash" in [chrome_mojo_event_info] *)

val chrome_mojo_event_info_set_ipc_hash : chrome_mojo_event_info -> int32 -> unit
  (** set field ipc_hash in chrome_mojo_event_info *)

val chrome_mojo_event_info_has_mojo_interface_tag : chrome_mojo_event_info -> bool
  (** presence of field "mojo_interface_tag" in [chrome_mojo_event_info] *)

val chrome_mojo_event_info_set_mojo_interface_tag : chrome_mojo_event_info -> string -> unit
  (** set field mojo_interface_tag in chrome_mojo_event_info *)

val chrome_mojo_event_info_has_mojo_interface_method_iid : chrome_mojo_event_info -> bool
  (** presence of field "mojo_interface_method_iid" in [chrome_mojo_event_info] *)

val chrome_mojo_event_info_set_mojo_interface_method_iid : chrome_mojo_event_info -> int64 -> unit
  (** set field mojo_interface_method_iid in chrome_mojo_event_info *)

val chrome_mojo_event_info_has_is_reply : chrome_mojo_event_info -> bool
  (** presence of field "is_reply" in [chrome_mojo_event_info] *)

val chrome_mojo_event_info_set_is_reply : chrome_mojo_event_info -> bool -> unit
  (** set field is_reply in chrome_mojo_event_info *)

val chrome_mojo_event_info_has_payload_size : chrome_mojo_event_info -> bool
  (** presence of field "payload_size" in [chrome_mojo_event_info] *)

val chrome_mojo_event_info_set_payload_size : chrome_mojo_event_info -> int64 -> unit
  (** set field payload_size in chrome_mojo_event_info *)

val chrome_mojo_event_info_has_data_num_bytes : chrome_mojo_event_info -> bool
  (** presence of field "data_num_bytes" in [chrome_mojo_event_info] *)

val chrome_mojo_event_info_set_data_num_bytes : chrome_mojo_event_info -> int64 -> unit
  (** set field data_num_bytes in chrome_mojo_event_info *)

val make_chrome_renderer_scheduler_state : 
  ?rail_mode:chrome_railmode ->
  ?is_backgrounded:bool ->
  ?is_hidden:bool ->
  unit ->
  chrome_renderer_scheduler_state
(** [make_chrome_renderer_scheduler_state … ()] is a builder for type [chrome_renderer_scheduler_state] *)

val copy_chrome_renderer_scheduler_state : chrome_renderer_scheduler_state -> chrome_renderer_scheduler_state

val chrome_renderer_scheduler_state_has_rail_mode : chrome_renderer_scheduler_state -> bool
  (** presence of field "rail_mode" in [chrome_renderer_scheduler_state] *)

val chrome_renderer_scheduler_state_set_rail_mode : chrome_renderer_scheduler_state -> chrome_railmode -> unit
  (** set field rail_mode in chrome_renderer_scheduler_state *)

val chrome_renderer_scheduler_state_has_is_backgrounded : chrome_renderer_scheduler_state -> bool
  (** presence of field "is_backgrounded" in [chrome_renderer_scheduler_state] *)

val chrome_renderer_scheduler_state_set_is_backgrounded : chrome_renderer_scheduler_state -> bool -> unit
  (** set field is_backgrounded in chrome_renderer_scheduler_state *)

val chrome_renderer_scheduler_state_has_is_hidden : chrome_renderer_scheduler_state -> bool
  (** presence of field "is_hidden" in [chrome_renderer_scheduler_state] *)

val chrome_renderer_scheduler_state_set_is_hidden : chrome_renderer_scheduler_state -> bool -> unit
  (** set field is_hidden in chrome_renderer_scheduler_state *)

val make_chrome_user_event : 
  ?action:string ->
  ?action_hash:int64 ->
  unit ->
  chrome_user_event
(** [make_chrome_user_event … ()] is a builder for type [chrome_user_event] *)

val copy_chrome_user_event : chrome_user_event -> chrome_user_event

val chrome_user_event_has_action : chrome_user_event -> bool
  (** presence of field "action" in [chrome_user_event] *)

val chrome_user_event_set_action : chrome_user_event -> string -> unit
  (** set field action in chrome_user_event *)

val chrome_user_event_has_action_hash : chrome_user_event -> bool
  (** presence of field "action_hash" in [chrome_user_event] *)

val chrome_user_event_set_action_hash : chrome_user_event -> int64 -> unit
  (** set field action_hash in chrome_user_event *)

val make_chrome_window_handle_event_info : 
  ?dpi:int32 ->
  ?message_id:int32 ->
  ?hwnd_ptr:int64 ->
  unit ->
  chrome_window_handle_event_info
(** [make_chrome_window_handle_event_info … ()] is a builder for type [chrome_window_handle_event_info] *)

val copy_chrome_window_handle_event_info : chrome_window_handle_event_info -> chrome_window_handle_event_info

val chrome_window_handle_event_info_has_dpi : chrome_window_handle_event_info -> bool
  (** presence of field "dpi" in [chrome_window_handle_event_info] *)

val chrome_window_handle_event_info_set_dpi : chrome_window_handle_event_info -> int32 -> unit
  (** set field dpi in chrome_window_handle_event_info *)

val chrome_window_handle_event_info_has_message_id : chrome_window_handle_event_info -> bool
  (** presence of field "message_id" in [chrome_window_handle_event_info] *)

val chrome_window_handle_event_info_set_message_id : chrome_window_handle_event_info -> int32 -> unit
  (** set field message_id in chrome_window_handle_event_info *)

val chrome_window_handle_event_info_has_hwnd_ptr : chrome_window_handle_event_info -> bool
  (** presence of field "hwnd_ptr" in [chrome_window_handle_event_info] *)

val chrome_window_handle_event_info_set_hwnd_ptr : chrome_window_handle_event_info -> int64 -> unit
  (** set field hwnd_ptr in chrome_window_handle_event_info *)

val make_screenshot : 
  ?jpg_image:bytes ->
  unit ->
  screenshot
(** [make_screenshot … ()] is a builder for type [screenshot] *)

val copy_screenshot : screenshot -> screenshot

val screenshot_has_jpg_image : screenshot -> bool
  (** presence of field "jpg_image" in [screenshot] *)

val screenshot_set_jpg_image : screenshot -> bytes -> unit
  (** set field jpg_image in screenshot *)

val make_task_execution : 
  ?posted_from_iid:int64 ->
  unit ->
  task_execution
(** [make_task_execution … ()] is a builder for type [task_execution] *)

val copy_task_execution : task_execution -> task_execution

val task_execution_has_posted_from_iid : task_execution -> bool
  (** presence of field "posted_from_iid" in [task_execution] *)

val task_execution_set_posted_from_iid : task_execution -> int64 -> unit
  (** set field posted_from_iid in task_execution *)

val make_track_event_callstack_frame : 
  ?function_name:string ->
  ?source_file:string ->
  ?line_number:int32 ->
  unit ->
  track_event_callstack_frame
(** [make_track_event_callstack_frame … ()] is a builder for type [track_event_callstack_frame] *)

val copy_track_event_callstack_frame : track_event_callstack_frame -> track_event_callstack_frame

val track_event_callstack_frame_has_function_name : track_event_callstack_frame -> bool
  (** presence of field "function_name" in [track_event_callstack_frame] *)

val track_event_callstack_frame_set_function_name : track_event_callstack_frame -> string -> unit
  (** set field function_name in track_event_callstack_frame *)

val track_event_callstack_frame_has_source_file : track_event_callstack_frame -> bool
  (** presence of field "source_file" in [track_event_callstack_frame] *)

val track_event_callstack_frame_set_source_file : track_event_callstack_frame -> string -> unit
  (** set field source_file in track_event_callstack_frame *)

val track_event_callstack_frame_has_line_number : track_event_callstack_frame -> bool
  (** presence of field "line_number" in [track_event_callstack_frame] *)

val track_event_callstack_frame_set_line_number : track_event_callstack_frame -> int32 -> unit
  (** set field line_number in track_event_callstack_frame *)

val make_track_event_callstack : 
  ?frames:track_event_callstack_frame list ->
  unit ->
  track_event_callstack
(** [make_track_event_callstack … ()] is a builder for type [track_event_callstack] *)

val copy_track_event_callstack : track_event_callstack -> track_event_callstack

val track_event_callstack_set_frames : track_event_callstack -> track_event_callstack_frame list -> unit
  (** set field frames in track_event_callstack *)

val make_track_event_legacy_event : 
  ?name_iid:int64 ->
  ?phase:int32 ->
  ?duration_us:int64 ->
  ?thread_duration_us:int64 ->
  ?thread_instruction_delta:int64 ->
  ?id:track_event_legacy_event_id ->
  ?id_scope:string ->
  ?use_async_tts:bool ->
  ?bind_id:int64 ->
  ?bind_to_enclosing:bool ->
  ?flow_direction:track_event_legacy_event_flow_direction ->
  ?instant_event_scope:track_event_legacy_event_instant_event_scope ->
  ?pid_override:int32 ->
  ?tid_override:int32 ->
  unit ->
  track_event_legacy_event
(** [make_track_event_legacy_event … ()] is a builder for type [track_event_legacy_event] *)

val copy_track_event_legacy_event : track_event_legacy_event -> track_event_legacy_event

val track_event_legacy_event_has_name_iid : track_event_legacy_event -> bool
  (** presence of field "name_iid" in [track_event_legacy_event] *)

val track_event_legacy_event_set_name_iid : track_event_legacy_event -> int64 -> unit
  (** set field name_iid in track_event_legacy_event *)

val track_event_legacy_event_has_phase : track_event_legacy_event -> bool
  (** presence of field "phase" in [track_event_legacy_event] *)

val track_event_legacy_event_set_phase : track_event_legacy_event -> int32 -> unit
  (** set field phase in track_event_legacy_event *)

val track_event_legacy_event_has_duration_us : track_event_legacy_event -> bool
  (** presence of field "duration_us" in [track_event_legacy_event] *)

val track_event_legacy_event_set_duration_us : track_event_legacy_event -> int64 -> unit
  (** set field duration_us in track_event_legacy_event *)

val track_event_legacy_event_has_thread_duration_us : track_event_legacy_event -> bool
  (** presence of field "thread_duration_us" in [track_event_legacy_event] *)

val track_event_legacy_event_set_thread_duration_us : track_event_legacy_event -> int64 -> unit
  (** set field thread_duration_us in track_event_legacy_event *)

val track_event_legacy_event_has_thread_instruction_delta : track_event_legacy_event -> bool
  (** presence of field "thread_instruction_delta" in [track_event_legacy_event] *)

val track_event_legacy_event_set_thread_instruction_delta : track_event_legacy_event -> int64 -> unit
  (** set field thread_instruction_delta in track_event_legacy_event *)

val track_event_legacy_event_set_id : track_event_legacy_event -> track_event_legacy_event_id -> unit
  (** set field id in track_event_legacy_event *)

val track_event_legacy_event_has_id_scope : track_event_legacy_event -> bool
  (** presence of field "id_scope" in [track_event_legacy_event] *)

val track_event_legacy_event_set_id_scope : track_event_legacy_event -> string -> unit
  (** set field id_scope in track_event_legacy_event *)

val track_event_legacy_event_has_use_async_tts : track_event_legacy_event -> bool
  (** presence of field "use_async_tts" in [track_event_legacy_event] *)

val track_event_legacy_event_set_use_async_tts : track_event_legacy_event -> bool -> unit
  (** set field use_async_tts in track_event_legacy_event *)

val track_event_legacy_event_has_bind_id : track_event_legacy_event -> bool
  (** presence of field "bind_id" in [track_event_legacy_event] *)

val track_event_legacy_event_set_bind_id : track_event_legacy_event -> int64 -> unit
  (** set field bind_id in track_event_legacy_event *)

val track_event_legacy_event_has_bind_to_enclosing : track_event_legacy_event -> bool
  (** presence of field "bind_to_enclosing" in [track_event_legacy_event] *)

val track_event_legacy_event_set_bind_to_enclosing : track_event_legacy_event -> bool -> unit
  (** set field bind_to_enclosing in track_event_legacy_event *)

val track_event_legacy_event_has_flow_direction : track_event_legacy_event -> bool
  (** presence of field "flow_direction" in [track_event_legacy_event] *)

val track_event_legacy_event_set_flow_direction : track_event_legacy_event -> track_event_legacy_event_flow_direction -> unit
  (** set field flow_direction in track_event_legacy_event *)

val track_event_legacy_event_has_instant_event_scope : track_event_legacy_event -> bool
  (** presence of field "instant_event_scope" in [track_event_legacy_event] *)

val track_event_legacy_event_set_instant_event_scope : track_event_legacy_event -> track_event_legacy_event_instant_event_scope -> unit
  (** set field instant_event_scope in track_event_legacy_event *)

val track_event_legacy_event_has_pid_override : track_event_legacy_event -> bool
  (** presence of field "pid_override" in [track_event_legacy_event] *)

val track_event_legacy_event_set_pid_override : track_event_legacy_event -> int32 -> unit
  (** set field pid_override in track_event_legacy_event *)

val track_event_legacy_event_has_tid_override : track_event_legacy_event -> bool
  (** presence of field "tid_override" in [track_event_legacy_event] *)

val track_event_legacy_event_set_tid_override : track_event_legacy_event -> int32 -> unit
  (** set field tid_override in track_event_legacy_event *)

val make_track_event : 
  ?category_iids:int64 list ->
  ?categories:string list ->
  ?name_field:track_event_name_field ->
  ?type_:track_event_type ->
  ?track_uuid:int64 ->
  ?counter_value_field:track_event_counter_value_field ->
  ?extra_counter_track_uuids:int64 list ->
  ?extra_counter_values:int64 list ->
  ?extra_double_counter_track_uuids:int64 list ->
  ?extra_double_counter_values:float list ->
  ?flow_ids_old:int64 list ->
  ?flow_ids:int64 list ->
  ?terminating_flow_ids_old:int64 list ->
  ?terminating_flow_ids:int64 list ->
  ?correlation_id_field:track_event_correlation_id_field ->
  ?callstack_field:track_event_callstack_field ->
  ?debug_annotations:debug_annotation list ->
  ?task_execution:task_execution ->
  ?log_message:log_message ->
  ?cc_scheduler_state:chrome_compositor_scheduler_state ->
  ?chrome_user_event:chrome_user_event ->
  ?chrome_keyed_service:chrome_keyed_service ->
  ?chrome_legacy_ipc:chrome_legacy_ipc ->
  ?chrome_histogram_sample:chrome_histogram_sample ->
  ?chrome_latency_info:chrome_latency_info ->
  ?chrome_frame_reporter:chrome_frame_reporter ->
  ?chrome_application_state_info:chrome_application_state_info ->
  ?chrome_renderer_scheduler_state:chrome_renderer_scheduler_state ->
  ?chrome_window_handle_event_info:chrome_window_handle_event_info ->
  ?chrome_content_settings_event_info:chrome_content_settings_event_info ->
  ?chrome_active_processes:chrome_active_processes ->
  ?screenshot:screenshot ->
  ?source_location_field:track_event_source_location_field ->
  ?chrome_message_pump:chrome_message_pump ->
  ?chrome_mojo_event_info:chrome_mojo_event_info ->
  ?timestamp:track_event_timestamp ->
  ?thread_time:track_event_thread_time ->
  ?thread_instruction_count:track_event_thread_instruction_count ->
  ?legacy_event:track_event_legacy_event ->
  unit ->
  track_event
(** [make_track_event … ()] is a builder for type [track_event] *)

val copy_track_event : track_event -> track_event

val track_event_set_category_iids : track_event -> int64 list -> unit
  (** set field category_iids in track_event *)

val track_event_set_categories : track_event -> string list -> unit
  (** set field categories in track_event *)

val track_event_set_name_field : track_event -> track_event_name_field -> unit
  (** set field name_field in track_event *)

val track_event_has_type_ : track_event -> bool
  (** presence of field "type_" in [track_event] *)

val track_event_set_type_ : track_event -> track_event_type -> unit
  (** set field type_ in track_event *)

val track_event_has_track_uuid : track_event -> bool
  (** presence of field "track_uuid" in [track_event] *)

val track_event_set_track_uuid : track_event -> int64 -> unit
  (** set field track_uuid in track_event *)

val track_event_set_counter_value_field : track_event -> track_event_counter_value_field -> unit
  (** set field counter_value_field in track_event *)

val track_event_set_extra_counter_track_uuids : track_event -> int64 list -> unit
  (** set field extra_counter_track_uuids in track_event *)

val track_event_set_extra_counter_values : track_event -> int64 list -> unit
  (** set field extra_counter_values in track_event *)

val track_event_set_extra_double_counter_track_uuids : track_event -> int64 list -> unit
  (** set field extra_double_counter_track_uuids in track_event *)

val track_event_set_extra_double_counter_values : track_event -> float list -> unit
  (** set field extra_double_counter_values in track_event *)

val track_event_set_flow_ids_old : track_event -> int64 list -> unit
  (** set field flow_ids_old in track_event *)

val track_event_set_flow_ids : track_event -> int64 list -> unit
  (** set field flow_ids in track_event *)

val track_event_set_terminating_flow_ids_old : track_event -> int64 list -> unit
  (** set field terminating_flow_ids_old in track_event *)

val track_event_set_terminating_flow_ids : track_event -> int64 list -> unit
  (** set field terminating_flow_ids in track_event *)

val track_event_set_correlation_id_field : track_event -> track_event_correlation_id_field -> unit
  (** set field correlation_id_field in track_event *)

val track_event_set_callstack_field : track_event -> track_event_callstack_field -> unit
  (** set field callstack_field in track_event *)

val track_event_set_debug_annotations : track_event -> debug_annotation list -> unit
  (** set field debug_annotations in track_event *)

val track_event_set_task_execution : track_event -> task_execution -> unit
  (** set field task_execution in track_event *)

val track_event_set_log_message : track_event -> log_message -> unit
  (** set field log_message in track_event *)

val track_event_set_cc_scheduler_state : track_event -> chrome_compositor_scheduler_state -> unit
  (** set field cc_scheduler_state in track_event *)

val track_event_set_chrome_user_event : track_event -> chrome_user_event -> unit
  (** set field chrome_user_event in track_event *)

val track_event_set_chrome_keyed_service : track_event -> chrome_keyed_service -> unit
  (** set field chrome_keyed_service in track_event *)

val track_event_set_chrome_legacy_ipc : track_event -> chrome_legacy_ipc -> unit
  (** set field chrome_legacy_ipc in track_event *)

val track_event_set_chrome_histogram_sample : track_event -> chrome_histogram_sample -> unit
  (** set field chrome_histogram_sample in track_event *)

val track_event_set_chrome_latency_info : track_event -> chrome_latency_info -> unit
  (** set field chrome_latency_info in track_event *)

val track_event_set_chrome_frame_reporter : track_event -> chrome_frame_reporter -> unit
  (** set field chrome_frame_reporter in track_event *)

val track_event_set_chrome_application_state_info : track_event -> chrome_application_state_info -> unit
  (** set field chrome_application_state_info in track_event *)

val track_event_set_chrome_renderer_scheduler_state : track_event -> chrome_renderer_scheduler_state -> unit
  (** set field chrome_renderer_scheduler_state in track_event *)

val track_event_set_chrome_window_handle_event_info : track_event -> chrome_window_handle_event_info -> unit
  (** set field chrome_window_handle_event_info in track_event *)

val track_event_set_chrome_content_settings_event_info : track_event -> chrome_content_settings_event_info -> unit
  (** set field chrome_content_settings_event_info in track_event *)

val track_event_set_chrome_active_processes : track_event -> chrome_active_processes -> unit
  (** set field chrome_active_processes in track_event *)

val track_event_set_screenshot : track_event -> screenshot -> unit
  (** set field screenshot in track_event *)

val track_event_set_source_location_field : track_event -> track_event_source_location_field -> unit
  (** set field source_location_field in track_event *)

val track_event_set_chrome_message_pump : track_event -> chrome_message_pump -> unit
  (** set field chrome_message_pump in track_event *)

val track_event_set_chrome_mojo_event_info : track_event -> chrome_mojo_event_info -> unit
  (** set field chrome_mojo_event_info in track_event *)

val track_event_set_timestamp : track_event -> track_event_timestamp -> unit
  (** set field timestamp in track_event *)

val track_event_set_thread_time : track_event -> track_event_thread_time -> unit
  (** set field thread_time in track_event *)

val track_event_set_thread_instruction_count : track_event -> track_event_thread_instruction_count -> unit
  (** set field thread_instruction_count in track_event *)

val track_event_set_legacy_event : track_event -> track_event_legacy_event -> unit
  (** set field legacy_event in track_event *)

val make_track_event_defaults : 
  ?track_uuid:int64 ->
  ?extra_counter_track_uuids:int64 list ->
  ?extra_double_counter_track_uuids:int64 list ->
  unit ->
  track_event_defaults
(** [make_track_event_defaults … ()] is a builder for type [track_event_defaults] *)

val copy_track_event_defaults : track_event_defaults -> track_event_defaults

val track_event_defaults_has_track_uuid : track_event_defaults -> bool
  (** presence of field "track_uuid" in [track_event_defaults] *)

val track_event_defaults_set_track_uuid : track_event_defaults -> int64 -> unit
  (** set field track_uuid in track_event_defaults *)

val track_event_defaults_set_extra_counter_track_uuids : track_event_defaults -> int64 list -> unit
  (** set field extra_counter_track_uuids in track_event_defaults *)

val track_event_defaults_set_extra_double_counter_track_uuids : track_event_defaults -> int64 list -> unit
  (** set field extra_double_counter_track_uuids in track_event_defaults *)

val make_event_category : 
  ?iid:int64 ->
  ?name:string ->
  unit ->
  event_category
(** [make_event_category … ()] is a builder for type [event_category] *)

val copy_event_category : event_category -> event_category

val event_category_has_iid : event_category -> bool
  (** presence of field "iid" in [event_category] *)

val event_category_set_iid : event_category -> int64 -> unit
  (** set field iid in event_category *)

val event_category_has_name : event_category -> bool
  (** presence of field "name" in [event_category] *)

val event_category_set_name : event_category -> string -> unit
  (** set field name in event_category *)

val make_event_name : 
  ?iid:int64 ->
  ?name:string ->
  unit ->
  event_name
(** [make_event_name … ()] is a builder for type [event_name] *)

val copy_event_name : event_name -> event_name

val event_name_has_iid : event_name -> bool
  (** presence of field "iid" in [event_name] *)

val event_name_set_iid : event_name -> int64 -> unit
  (** set field iid in event_name *)

val event_name_has_name : event_name -> bool
  (** presence of field "name" in [event_name] *)

val event_name_set_name : event_name -> string -> unit
  (** set field name in event_name *)

val make_interned_data : 
  ?event_categories:event_category list ->
  ?event_names:event_name list ->
  ?debug_annotation_names:debug_annotation_name list ->
  ?debug_annotation_value_type_names:debug_annotation_value_type_name list ->
  ?source_locations:source_location list ->
  ?unsymbolized_source_locations:unsymbolized_source_location list ->
  ?log_message_body:log_message_body list ->
  ?histogram_names:histogram_name list ->
  ?build_ids:interned_string list ->
  ?mapping_paths:interned_string list ->
  ?source_paths:interned_string list ->
  ?function_names:interned_string list ->
  ?mappings:mapping list ->
  ?frames:frame list ->
  ?callstacks:callstack list ->
  ?vulkan_memory_keys:interned_string list ->
  ?graphics_contexts:interned_graphics_context list ->
  ?gpu_specifications:interned_gpu_render_stage_specification list ->
  ?kernel_symbols:interned_string list ->
  ?debug_annotation_string_values:interned_string list ->
  ?v8_js_function_name:interned_v8_string list ->
  ?v8_js_function:interned_v8_js_function list ->
  ?v8_js_script:interned_v8_js_script list ->
  ?v8_wasm_script:interned_v8_wasm_script list ->
  ?v8_isolate:interned_v8_isolate list ->
  ?protolog_string_args:interned_string list ->
  ?protolog_stacktrace:interned_string list ->
  ?viewcapture_package_name:interned_string list ->
  ?viewcapture_window_name:interned_string list ->
  ?viewcapture_view_id:interned_string list ->
  ?viewcapture_class_name:interned_string list ->
  ?correlation_id_str:interned_string list ->
  unit ->
  interned_data
(** [make_interned_data … ()] is a builder for type [interned_data] *)

val copy_interned_data : interned_data -> interned_data

val interned_data_set_event_categories : interned_data -> event_category list -> unit
  (** set field event_categories in interned_data *)

val interned_data_set_event_names : interned_data -> event_name list -> unit
  (** set field event_names in interned_data *)

val interned_data_set_debug_annotation_names : interned_data -> debug_annotation_name list -> unit
  (** set field debug_annotation_names in interned_data *)

val interned_data_set_debug_annotation_value_type_names : interned_data -> debug_annotation_value_type_name list -> unit
  (** set field debug_annotation_value_type_names in interned_data *)

val interned_data_set_source_locations : interned_data -> source_location list -> unit
  (** set field source_locations in interned_data *)

val interned_data_set_unsymbolized_source_locations : interned_data -> unsymbolized_source_location list -> unit
  (** set field unsymbolized_source_locations in interned_data *)

val interned_data_set_log_message_body : interned_data -> log_message_body list -> unit
  (** set field log_message_body in interned_data *)

val interned_data_set_histogram_names : interned_data -> histogram_name list -> unit
  (** set field histogram_names in interned_data *)

val interned_data_set_build_ids : interned_data -> interned_string list -> unit
  (** set field build_ids in interned_data *)

val interned_data_set_mapping_paths : interned_data -> interned_string list -> unit
  (** set field mapping_paths in interned_data *)

val interned_data_set_source_paths : interned_data -> interned_string list -> unit
  (** set field source_paths in interned_data *)

val interned_data_set_function_names : interned_data -> interned_string list -> unit
  (** set field function_names in interned_data *)

val interned_data_set_mappings : interned_data -> mapping list -> unit
  (** set field mappings in interned_data *)

val interned_data_set_frames : interned_data -> frame list -> unit
  (** set field frames in interned_data *)

val interned_data_set_callstacks : interned_data -> callstack list -> unit
  (** set field callstacks in interned_data *)

val interned_data_set_vulkan_memory_keys : interned_data -> interned_string list -> unit
  (** set field vulkan_memory_keys in interned_data *)

val interned_data_set_graphics_contexts : interned_data -> interned_graphics_context list -> unit
  (** set field graphics_contexts in interned_data *)

val interned_data_set_gpu_specifications : interned_data -> interned_gpu_render_stage_specification list -> unit
  (** set field gpu_specifications in interned_data *)

val interned_data_set_kernel_symbols : interned_data -> interned_string list -> unit
  (** set field kernel_symbols in interned_data *)

val interned_data_set_debug_annotation_string_values : interned_data -> interned_string list -> unit
  (** set field debug_annotation_string_values in interned_data *)

val interned_data_set_v8_js_function_name : interned_data -> interned_v8_string list -> unit
  (** set field v8_js_function_name in interned_data *)

val interned_data_set_v8_js_function : interned_data -> interned_v8_js_function list -> unit
  (** set field v8_js_function in interned_data *)

val interned_data_set_v8_js_script : interned_data -> interned_v8_js_script list -> unit
  (** set field v8_js_script in interned_data *)

val interned_data_set_v8_wasm_script : interned_data -> interned_v8_wasm_script list -> unit
  (** set field v8_wasm_script in interned_data *)

val interned_data_set_v8_isolate : interned_data -> interned_v8_isolate list -> unit
  (** set field v8_isolate in interned_data *)

val interned_data_set_protolog_string_args : interned_data -> interned_string list -> unit
  (** set field protolog_string_args in interned_data *)

val interned_data_set_protolog_stacktrace : interned_data -> interned_string list -> unit
  (** set field protolog_stacktrace in interned_data *)

val interned_data_set_viewcapture_package_name : interned_data -> interned_string list -> unit
  (** set field viewcapture_package_name in interned_data *)

val interned_data_set_viewcapture_window_name : interned_data -> interned_string list -> unit
  (** set field viewcapture_window_name in interned_data *)

val interned_data_set_viewcapture_view_id : interned_data -> interned_string list -> unit
  (** set field viewcapture_view_id in interned_data *)

val interned_data_set_viewcapture_class_name : interned_data -> interned_string list -> unit
  (** set field viewcapture_class_name in interned_data *)

val interned_data_set_correlation_id_str : interned_data -> interned_string list -> unit
  (** set field correlation_id_str in interned_data *)

val make_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry : 
  ?name:string ->
  ?units:memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units ->
  ?value_uint64:int64 ->
  ?value_string:string ->
  unit ->
  memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry
(** [make_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry … ()] is a builder for type [memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry] *)

val copy_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry

val memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_has_name : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> bool
  (** presence of field "name" in [memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry] *)

val memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_set_name : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> string -> unit
  (** set field name in memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry *)

val memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_has_units : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> bool
  (** presence of field "units" in [memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry] *)

val memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_set_units : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units -> unit
  (** set field units in memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry *)

val memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_has_value_uint64 : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> bool
  (** presence of field "value_uint64" in [memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry] *)

val memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_set_value_uint64 : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> int64 -> unit
  (** set field value_uint64 in memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry *)

val memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_has_value_string : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> bool
  (** presence of field "value_string" in [memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry] *)

val memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_set_value_string : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> string -> unit
  (** set field value_string in memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry *)

val make_memory_tracker_snapshot_process_snapshot_memory_node : 
  ?id:int64 ->
  ?absolute_name:string ->
  ?weak:bool ->
  ?size_bytes:int64 ->
  ?entries:memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry list ->
  unit ->
  memory_tracker_snapshot_process_snapshot_memory_node
(** [make_memory_tracker_snapshot_process_snapshot_memory_node … ()] is a builder for type [memory_tracker_snapshot_process_snapshot_memory_node] *)

val copy_memory_tracker_snapshot_process_snapshot_memory_node : memory_tracker_snapshot_process_snapshot_memory_node -> memory_tracker_snapshot_process_snapshot_memory_node

val memory_tracker_snapshot_process_snapshot_memory_node_has_id : memory_tracker_snapshot_process_snapshot_memory_node -> bool
  (** presence of field "id" in [memory_tracker_snapshot_process_snapshot_memory_node] *)

val memory_tracker_snapshot_process_snapshot_memory_node_set_id : memory_tracker_snapshot_process_snapshot_memory_node -> int64 -> unit
  (** set field id in memory_tracker_snapshot_process_snapshot_memory_node *)

val memory_tracker_snapshot_process_snapshot_memory_node_has_absolute_name : memory_tracker_snapshot_process_snapshot_memory_node -> bool
  (** presence of field "absolute_name" in [memory_tracker_snapshot_process_snapshot_memory_node] *)

val memory_tracker_snapshot_process_snapshot_memory_node_set_absolute_name : memory_tracker_snapshot_process_snapshot_memory_node -> string -> unit
  (** set field absolute_name in memory_tracker_snapshot_process_snapshot_memory_node *)

val memory_tracker_snapshot_process_snapshot_memory_node_has_weak : memory_tracker_snapshot_process_snapshot_memory_node -> bool
  (** presence of field "weak" in [memory_tracker_snapshot_process_snapshot_memory_node] *)

val memory_tracker_snapshot_process_snapshot_memory_node_set_weak : memory_tracker_snapshot_process_snapshot_memory_node -> bool -> unit
  (** set field weak in memory_tracker_snapshot_process_snapshot_memory_node *)

val memory_tracker_snapshot_process_snapshot_memory_node_has_size_bytes : memory_tracker_snapshot_process_snapshot_memory_node -> bool
  (** presence of field "size_bytes" in [memory_tracker_snapshot_process_snapshot_memory_node] *)

val memory_tracker_snapshot_process_snapshot_memory_node_set_size_bytes : memory_tracker_snapshot_process_snapshot_memory_node -> int64 -> unit
  (** set field size_bytes in memory_tracker_snapshot_process_snapshot_memory_node *)

val memory_tracker_snapshot_process_snapshot_memory_node_set_entries : memory_tracker_snapshot_process_snapshot_memory_node -> memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry list -> unit
  (** set field entries in memory_tracker_snapshot_process_snapshot_memory_node *)

val make_memory_tracker_snapshot_process_snapshot_memory_edge : 
  ?source_id:int64 ->
  ?target_id:int64 ->
  ?importance:int32 ->
  ?overridable:bool ->
  unit ->
  memory_tracker_snapshot_process_snapshot_memory_edge
(** [make_memory_tracker_snapshot_process_snapshot_memory_edge … ()] is a builder for type [memory_tracker_snapshot_process_snapshot_memory_edge] *)

val copy_memory_tracker_snapshot_process_snapshot_memory_edge : memory_tracker_snapshot_process_snapshot_memory_edge -> memory_tracker_snapshot_process_snapshot_memory_edge

val memory_tracker_snapshot_process_snapshot_memory_edge_has_source_id : memory_tracker_snapshot_process_snapshot_memory_edge -> bool
  (** presence of field "source_id" in [memory_tracker_snapshot_process_snapshot_memory_edge] *)

val memory_tracker_snapshot_process_snapshot_memory_edge_set_source_id : memory_tracker_snapshot_process_snapshot_memory_edge -> int64 -> unit
  (** set field source_id in memory_tracker_snapshot_process_snapshot_memory_edge *)

val memory_tracker_snapshot_process_snapshot_memory_edge_has_target_id : memory_tracker_snapshot_process_snapshot_memory_edge -> bool
  (** presence of field "target_id" in [memory_tracker_snapshot_process_snapshot_memory_edge] *)

val memory_tracker_snapshot_process_snapshot_memory_edge_set_target_id : memory_tracker_snapshot_process_snapshot_memory_edge -> int64 -> unit
  (** set field target_id in memory_tracker_snapshot_process_snapshot_memory_edge *)

val memory_tracker_snapshot_process_snapshot_memory_edge_has_importance : memory_tracker_snapshot_process_snapshot_memory_edge -> bool
  (** presence of field "importance" in [memory_tracker_snapshot_process_snapshot_memory_edge] *)

val memory_tracker_snapshot_process_snapshot_memory_edge_set_importance : memory_tracker_snapshot_process_snapshot_memory_edge -> int32 -> unit
  (** set field importance in memory_tracker_snapshot_process_snapshot_memory_edge *)

val memory_tracker_snapshot_process_snapshot_memory_edge_has_overridable : memory_tracker_snapshot_process_snapshot_memory_edge -> bool
  (** presence of field "overridable" in [memory_tracker_snapshot_process_snapshot_memory_edge] *)

val memory_tracker_snapshot_process_snapshot_memory_edge_set_overridable : memory_tracker_snapshot_process_snapshot_memory_edge -> bool -> unit
  (** set field overridable in memory_tracker_snapshot_process_snapshot_memory_edge *)

val make_memory_tracker_snapshot_process_snapshot : 
  ?pid:int32 ->
  ?allocator_dumps:memory_tracker_snapshot_process_snapshot_memory_node list ->
  ?memory_edges:memory_tracker_snapshot_process_snapshot_memory_edge list ->
  unit ->
  memory_tracker_snapshot_process_snapshot
(** [make_memory_tracker_snapshot_process_snapshot … ()] is a builder for type [memory_tracker_snapshot_process_snapshot] *)

val copy_memory_tracker_snapshot_process_snapshot : memory_tracker_snapshot_process_snapshot -> memory_tracker_snapshot_process_snapshot

val memory_tracker_snapshot_process_snapshot_has_pid : memory_tracker_snapshot_process_snapshot -> bool
  (** presence of field "pid" in [memory_tracker_snapshot_process_snapshot] *)

val memory_tracker_snapshot_process_snapshot_set_pid : memory_tracker_snapshot_process_snapshot -> int32 -> unit
  (** set field pid in memory_tracker_snapshot_process_snapshot *)

val memory_tracker_snapshot_process_snapshot_set_allocator_dumps : memory_tracker_snapshot_process_snapshot -> memory_tracker_snapshot_process_snapshot_memory_node list -> unit
  (** set field allocator_dumps in memory_tracker_snapshot_process_snapshot *)

val memory_tracker_snapshot_process_snapshot_set_memory_edges : memory_tracker_snapshot_process_snapshot -> memory_tracker_snapshot_process_snapshot_memory_edge list -> unit
  (** set field memory_edges in memory_tracker_snapshot_process_snapshot *)

val make_memory_tracker_snapshot : 
  ?global_dump_id:int64 ->
  ?level_of_detail:memory_tracker_snapshot_level_of_detail ->
  ?process_memory_dumps:memory_tracker_snapshot_process_snapshot list ->
  unit ->
  memory_tracker_snapshot
(** [make_memory_tracker_snapshot … ()] is a builder for type [memory_tracker_snapshot] *)

val copy_memory_tracker_snapshot : memory_tracker_snapshot -> memory_tracker_snapshot

val memory_tracker_snapshot_has_global_dump_id : memory_tracker_snapshot -> bool
  (** presence of field "global_dump_id" in [memory_tracker_snapshot] *)

val memory_tracker_snapshot_set_global_dump_id : memory_tracker_snapshot -> int64 -> unit
  (** set field global_dump_id in memory_tracker_snapshot *)

val memory_tracker_snapshot_has_level_of_detail : memory_tracker_snapshot -> bool
  (** presence of field "level_of_detail" in [memory_tracker_snapshot] *)

val memory_tracker_snapshot_set_level_of_detail : memory_tracker_snapshot -> memory_tracker_snapshot_level_of_detail -> unit
  (** set field level_of_detail in memory_tracker_snapshot *)

val memory_tracker_snapshot_set_process_memory_dumps : memory_tracker_snapshot -> memory_tracker_snapshot_process_snapshot list -> unit
  (** set field process_memory_dumps in memory_tracker_snapshot *)

val make_perfetto_metatrace_arg : 
  ?key_or_interned_key:perfetto_metatrace_arg_key_or_interned_key ->
  ?value_or_interned_value:perfetto_metatrace_arg_value_or_interned_value ->
  unit ->
  perfetto_metatrace_arg
(** [make_perfetto_metatrace_arg … ()] is a builder for type [perfetto_metatrace_arg] *)

val copy_perfetto_metatrace_arg : perfetto_metatrace_arg -> perfetto_metatrace_arg

val perfetto_metatrace_arg_set_key_or_interned_key : perfetto_metatrace_arg -> perfetto_metatrace_arg_key_or_interned_key -> unit
  (** set field key_or_interned_key in perfetto_metatrace_arg *)

val perfetto_metatrace_arg_set_value_or_interned_value : perfetto_metatrace_arg -> perfetto_metatrace_arg_value_or_interned_value -> unit
  (** set field value_or_interned_value in perfetto_metatrace_arg *)

val make_perfetto_metatrace_interned_string : 
  ?iid:int64 ->
  ?value:string ->
  unit ->
  perfetto_metatrace_interned_string
(** [make_perfetto_metatrace_interned_string … ()] is a builder for type [perfetto_metatrace_interned_string] *)

val copy_perfetto_metatrace_interned_string : perfetto_metatrace_interned_string -> perfetto_metatrace_interned_string

val perfetto_metatrace_interned_string_has_iid : perfetto_metatrace_interned_string -> bool
  (** presence of field "iid" in [perfetto_metatrace_interned_string] *)

val perfetto_metatrace_interned_string_set_iid : perfetto_metatrace_interned_string -> int64 -> unit
  (** set field iid in perfetto_metatrace_interned_string *)

val perfetto_metatrace_interned_string_has_value : perfetto_metatrace_interned_string -> bool
  (** presence of field "value" in [perfetto_metatrace_interned_string] *)

val perfetto_metatrace_interned_string_set_value : perfetto_metatrace_interned_string -> string -> unit
  (** set field value in perfetto_metatrace_interned_string *)

val make_perfetto_metatrace : 
  ?record_type:perfetto_metatrace_record_type ->
  ?event_duration_ns:int64 ->
  ?counter_value:int32 ->
  ?thread_id:int32 ->
  ?has_overruns:bool ->
  ?args:perfetto_metatrace_arg list ->
  ?interned_strings:perfetto_metatrace_interned_string list ->
  unit ->
  perfetto_metatrace
(** [make_perfetto_metatrace … ()] is a builder for type [perfetto_metatrace] *)

val copy_perfetto_metatrace : perfetto_metatrace -> perfetto_metatrace

val perfetto_metatrace_set_record_type : perfetto_metatrace -> perfetto_metatrace_record_type -> unit
  (** set field record_type in perfetto_metatrace *)

val perfetto_metatrace_has_event_duration_ns : perfetto_metatrace -> bool
  (** presence of field "event_duration_ns" in [perfetto_metatrace] *)

val perfetto_metatrace_set_event_duration_ns : perfetto_metatrace -> int64 -> unit
  (** set field event_duration_ns in perfetto_metatrace *)

val perfetto_metatrace_has_counter_value : perfetto_metatrace -> bool
  (** presence of field "counter_value" in [perfetto_metatrace] *)

val perfetto_metatrace_set_counter_value : perfetto_metatrace -> int32 -> unit
  (** set field counter_value in perfetto_metatrace *)

val perfetto_metatrace_has_thread_id : perfetto_metatrace -> bool
  (** presence of field "thread_id" in [perfetto_metatrace] *)

val perfetto_metatrace_set_thread_id : perfetto_metatrace -> int32 -> unit
  (** set field thread_id in perfetto_metatrace *)

val perfetto_metatrace_has_has_overruns : perfetto_metatrace -> bool
  (** presence of field "has_overruns" in [perfetto_metatrace] *)

val perfetto_metatrace_set_has_overruns : perfetto_metatrace -> bool -> unit
  (** set field has_overruns in perfetto_metatrace *)

val perfetto_metatrace_set_args : perfetto_metatrace -> perfetto_metatrace_arg list -> unit
  (** set field args in perfetto_metatrace *)

val perfetto_metatrace_set_interned_strings : perfetto_metatrace -> perfetto_metatrace_interned_string list -> unit
  (** set field interned_strings in perfetto_metatrace *)

val make_tracing_service_event_data_sources_data_source : 
  ?producer_name:string ->
  ?data_source_name:string ->
  unit ->
  tracing_service_event_data_sources_data_source
(** [make_tracing_service_event_data_sources_data_source … ()] is a builder for type [tracing_service_event_data_sources_data_source] *)

val copy_tracing_service_event_data_sources_data_source : tracing_service_event_data_sources_data_source -> tracing_service_event_data_sources_data_source

val tracing_service_event_data_sources_data_source_has_producer_name : tracing_service_event_data_sources_data_source -> bool
  (** presence of field "producer_name" in [tracing_service_event_data_sources_data_source] *)

val tracing_service_event_data_sources_data_source_set_producer_name : tracing_service_event_data_sources_data_source -> string -> unit
  (** set field producer_name in tracing_service_event_data_sources_data_source *)

val tracing_service_event_data_sources_data_source_has_data_source_name : tracing_service_event_data_sources_data_source -> bool
  (** presence of field "data_source_name" in [tracing_service_event_data_sources_data_source] *)

val tracing_service_event_data_sources_data_source_set_data_source_name : tracing_service_event_data_sources_data_source -> string -> unit
  (** set field data_source_name in tracing_service_event_data_sources_data_source *)

val make_tracing_service_event_data_sources : 
  ?data_source:tracing_service_event_data_sources_data_source list ->
  unit ->
  tracing_service_event_data_sources
(** [make_tracing_service_event_data_sources … ()] is a builder for type [tracing_service_event_data_sources] *)

val copy_tracing_service_event_data_sources : tracing_service_event_data_sources -> tracing_service_event_data_sources

val tracing_service_event_data_sources_set_data_source : tracing_service_event_data_sources -> tracing_service_event_data_sources_data_source list -> unit
  (** set field data_source in tracing_service_event_data_sources *)

val make_android_energy_consumer : 
  ?energy_consumer_id:int32 ->
  ?ordinal:int32 ->
  ?type_:string ->
  ?name:string ->
  unit ->
  android_energy_consumer
(** [make_android_energy_consumer … ()] is a builder for type [android_energy_consumer] *)

val copy_android_energy_consumer : android_energy_consumer -> android_energy_consumer

val android_energy_consumer_has_energy_consumer_id : android_energy_consumer -> bool
  (** presence of field "energy_consumer_id" in [android_energy_consumer] *)

val android_energy_consumer_set_energy_consumer_id : android_energy_consumer -> int32 -> unit
  (** set field energy_consumer_id in android_energy_consumer *)

val android_energy_consumer_has_ordinal : android_energy_consumer -> bool
  (** presence of field "ordinal" in [android_energy_consumer] *)

val android_energy_consumer_set_ordinal : android_energy_consumer -> int32 -> unit
  (** set field ordinal in android_energy_consumer *)

val android_energy_consumer_has_type_ : android_energy_consumer -> bool
  (** presence of field "type_" in [android_energy_consumer] *)

val android_energy_consumer_set_type_ : android_energy_consumer -> string -> unit
  (** set field type_ in android_energy_consumer *)

val android_energy_consumer_has_name : android_energy_consumer -> bool
  (** presence of field "name" in [android_energy_consumer] *)

val android_energy_consumer_set_name : android_energy_consumer -> string -> unit
  (** set field name in android_energy_consumer *)

val make_android_energy_consumer_descriptor : 
  ?energy_consumers:android_energy_consumer list ->
  unit ->
  android_energy_consumer_descriptor
(** [make_android_energy_consumer_descriptor … ()] is a builder for type [android_energy_consumer_descriptor] *)

val copy_android_energy_consumer_descriptor : android_energy_consumer_descriptor -> android_energy_consumer_descriptor

val android_energy_consumer_descriptor_set_energy_consumers : android_energy_consumer_descriptor -> android_energy_consumer list -> unit
  (** set field energy_consumers in android_energy_consumer_descriptor *)

val make_android_energy_estimation_breakdown_energy_uid_breakdown : 
  ?uid:int32 ->
  ?energy_uws:int64 ->
  unit ->
  android_energy_estimation_breakdown_energy_uid_breakdown
(** [make_android_energy_estimation_breakdown_energy_uid_breakdown … ()] is a builder for type [android_energy_estimation_breakdown_energy_uid_breakdown] *)

val copy_android_energy_estimation_breakdown_energy_uid_breakdown : android_energy_estimation_breakdown_energy_uid_breakdown -> android_energy_estimation_breakdown_energy_uid_breakdown

val android_energy_estimation_breakdown_energy_uid_breakdown_has_uid : android_energy_estimation_breakdown_energy_uid_breakdown -> bool
  (** presence of field "uid" in [android_energy_estimation_breakdown_energy_uid_breakdown] *)

val android_energy_estimation_breakdown_energy_uid_breakdown_set_uid : android_energy_estimation_breakdown_energy_uid_breakdown -> int32 -> unit
  (** set field uid in android_energy_estimation_breakdown_energy_uid_breakdown *)

val android_energy_estimation_breakdown_energy_uid_breakdown_has_energy_uws : android_energy_estimation_breakdown_energy_uid_breakdown -> bool
  (** presence of field "energy_uws" in [android_energy_estimation_breakdown_energy_uid_breakdown] *)

val android_energy_estimation_breakdown_energy_uid_breakdown_set_energy_uws : android_energy_estimation_breakdown_energy_uid_breakdown -> int64 -> unit
  (** set field energy_uws in android_energy_estimation_breakdown_energy_uid_breakdown *)

val make_android_energy_estimation_breakdown : 
  ?energy_consumer_descriptor:android_energy_consumer_descriptor ->
  ?energy_consumer_id:int32 ->
  ?energy_uws:int64 ->
  ?per_uid_breakdown:android_energy_estimation_breakdown_energy_uid_breakdown list ->
  unit ->
  android_energy_estimation_breakdown
(** [make_android_energy_estimation_breakdown … ()] is a builder for type [android_energy_estimation_breakdown] *)

val copy_android_energy_estimation_breakdown : android_energy_estimation_breakdown -> android_energy_estimation_breakdown

val android_energy_estimation_breakdown_set_energy_consumer_descriptor : android_energy_estimation_breakdown -> android_energy_consumer_descriptor -> unit
  (** set field energy_consumer_descriptor in android_energy_estimation_breakdown *)

val android_energy_estimation_breakdown_has_energy_consumer_id : android_energy_estimation_breakdown -> bool
  (** presence of field "energy_consumer_id" in [android_energy_estimation_breakdown] *)

val android_energy_estimation_breakdown_set_energy_consumer_id : android_energy_estimation_breakdown -> int32 -> unit
  (** set field energy_consumer_id in android_energy_estimation_breakdown *)

val android_energy_estimation_breakdown_has_energy_uws : android_energy_estimation_breakdown -> bool
  (** presence of field "energy_uws" in [android_energy_estimation_breakdown] *)

val android_energy_estimation_breakdown_set_energy_uws : android_energy_estimation_breakdown -> int64 -> unit
  (** set field energy_uws in android_energy_estimation_breakdown *)

val android_energy_estimation_breakdown_set_per_uid_breakdown : android_energy_estimation_breakdown -> android_energy_estimation_breakdown_energy_uid_breakdown list -> unit
  (** set field per_uid_breakdown in android_energy_estimation_breakdown *)

val make_entity_state_residency_power_entity_state : 
  ?entity_index:int32 ->
  ?state_index:int32 ->
  ?entity_name:string ->
  ?state_name:string ->
  unit ->
  entity_state_residency_power_entity_state
(** [make_entity_state_residency_power_entity_state … ()] is a builder for type [entity_state_residency_power_entity_state] *)

val copy_entity_state_residency_power_entity_state : entity_state_residency_power_entity_state -> entity_state_residency_power_entity_state

val entity_state_residency_power_entity_state_has_entity_index : entity_state_residency_power_entity_state -> bool
  (** presence of field "entity_index" in [entity_state_residency_power_entity_state] *)

val entity_state_residency_power_entity_state_set_entity_index : entity_state_residency_power_entity_state -> int32 -> unit
  (** set field entity_index in entity_state_residency_power_entity_state *)

val entity_state_residency_power_entity_state_has_state_index : entity_state_residency_power_entity_state -> bool
  (** presence of field "state_index" in [entity_state_residency_power_entity_state] *)

val entity_state_residency_power_entity_state_set_state_index : entity_state_residency_power_entity_state -> int32 -> unit
  (** set field state_index in entity_state_residency_power_entity_state *)

val entity_state_residency_power_entity_state_has_entity_name : entity_state_residency_power_entity_state -> bool
  (** presence of field "entity_name" in [entity_state_residency_power_entity_state] *)

val entity_state_residency_power_entity_state_set_entity_name : entity_state_residency_power_entity_state -> string -> unit
  (** set field entity_name in entity_state_residency_power_entity_state *)

val entity_state_residency_power_entity_state_has_state_name : entity_state_residency_power_entity_state -> bool
  (** presence of field "state_name" in [entity_state_residency_power_entity_state] *)

val entity_state_residency_power_entity_state_set_state_name : entity_state_residency_power_entity_state -> string -> unit
  (** set field state_name in entity_state_residency_power_entity_state *)

val make_entity_state_residency_state_residency : 
  ?entity_index:int32 ->
  ?state_index:int32 ->
  ?total_time_in_state_ms:int64 ->
  ?total_state_entry_count:int64 ->
  ?last_entry_timestamp_ms:int64 ->
  unit ->
  entity_state_residency_state_residency
(** [make_entity_state_residency_state_residency … ()] is a builder for type [entity_state_residency_state_residency] *)

val copy_entity_state_residency_state_residency : entity_state_residency_state_residency -> entity_state_residency_state_residency

val entity_state_residency_state_residency_has_entity_index : entity_state_residency_state_residency -> bool
  (** presence of field "entity_index" in [entity_state_residency_state_residency] *)

val entity_state_residency_state_residency_set_entity_index : entity_state_residency_state_residency -> int32 -> unit
  (** set field entity_index in entity_state_residency_state_residency *)

val entity_state_residency_state_residency_has_state_index : entity_state_residency_state_residency -> bool
  (** presence of field "state_index" in [entity_state_residency_state_residency] *)

val entity_state_residency_state_residency_set_state_index : entity_state_residency_state_residency -> int32 -> unit
  (** set field state_index in entity_state_residency_state_residency *)

val entity_state_residency_state_residency_has_total_time_in_state_ms : entity_state_residency_state_residency -> bool
  (** presence of field "total_time_in_state_ms" in [entity_state_residency_state_residency] *)

val entity_state_residency_state_residency_set_total_time_in_state_ms : entity_state_residency_state_residency -> int64 -> unit
  (** set field total_time_in_state_ms in entity_state_residency_state_residency *)

val entity_state_residency_state_residency_has_total_state_entry_count : entity_state_residency_state_residency -> bool
  (** presence of field "total_state_entry_count" in [entity_state_residency_state_residency] *)

val entity_state_residency_state_residency_set_total_state_entry_count : entity_state_residency_state_residency -> int64 -> unit
  (** set field total_state_entry_count in entity_state_residency_state_residency *)

val entity_state_residency_state_residency_has_last_entry_timestamp_ms : entity_state_residency_state_residency -> bool
  (** presence of field "last_entry_timestamp_ms" in [entity_state_residency_state_residency] *)

val entity_state_residency_state_residency_set_last_entry_timestamp_ms : entity_state_residency_state_residency -> int64 -> unit
  (** set field last_entry_timestamp_ms in entity_state_residency_state_residency *)

val make_entity_state_residency : 
  ?power_entity_state:entity_state_residency_power_entity_state list ->
  ?residency:entity_state_residency_state_residency list ->
  unit ->
  entity_state_residency
(** [make_entity_state_residency … ()] is a builder for type [entity_state_residency] *)

val copy_entity_state_residency : entity_state_residency -> entity_state_residency

val entity_state_residency_set_power_entity_state : entity_state_residency -> entity_state_residency_power_entity_state list -> unit
  (** set field power_entity_state in entity_state_residency *)

val entity_state_residency_set_residency : entity_state_residency -> entity_state_residency_state_residency list -> unit
  (** set field residency in entity_state_residency *)

val make_battery_counters : 
  ?charge_counter_uah:int64 ->
  ?capacity_percent:float ->
  ?current_ua:int64 ->
  ?current_avg_ua:int64 ->
  ?name:string ->
  ?energy_counter_uwh:int64 ->
  ?voltage_uv:int64 ->
  unit ->
  battery_counters
(** [make_battery_counters … ()] is a builder for type [battery_counters] *)

val copy_battery_counters : battery_counters -> battery_counters

val battery_counters_has_charge_counter_uah : battery_counters -> bool
  (** presence of field "charge_counter_uah" in [battery_counters] *)

val battery_counters_set_charge_counter_uah : battery_counters -> int64 -> unit
  (** set field charge_counter_uah in battery_counters *)

val battery_counters_has_capacity_percent : battery_counters -> bool
  (** presence of field "capacity_percent" in [battery_counters] *)

val battery_counters_set_capacity_percent : battery_counters -> float -> unit
  (** set field capacity_percent in battery_counters *)

val battery_counters_has_current_ua : battery_counters -> bool
  (** presence of field "current_ua" in [battery_counters] *)

val battery_counters_set_current_ua : battery_counters -> int64 -> unit
  (** set field current_ua in battery_counters *)

val battery_counters_has_current_avg_ua : battery_counters -> bool
  (** presence of field "current_avg_ua" in [battery_counters] *)

val battery_counters_set_current_avg_ua : battery_counters -> int64 -> unit
  (** set field current_avg_ua in battery_counters *)

val battery_counters_has_name : battery_counters -> bool
  (** presence of field "name" in [battery_counters] *)

val battery_counters_set_name : battery_counters -> string -> unit
  (** set field name in battery_counters *)

val battery_counters_has_energy_counter_uwh : battery_counters -> bool
  (** presence of field "energy_counter_uwh" in [battery_counters] *)

val battery_counters_set_energy_counter_uwh : battery_counters -> int64 -> unit
  (** set field energy_counter_uwh in battery_counters *)

val battery_counters_has_voltage_uv : battery_counters -> bool
  (** presence of field "voltage_uv" in [battery_counters] *)

val battery_counters_set_voltage_uv : battery_counters -> int64 -> unit
  (** set field voltage_uv in battery_counters *)

val make_power_rails_rail_descriptor : 
  ?index:int32 ->
  ?rail_name:string ->
  ?subsys_name:string ->
  ?sampling_rate:int32 ->
  unit ->
  power_rails_rail_descriptor
(** [make_power_rails_rail_descriptor … ()] is a builder for type [power_rails_rail_descriptor] *)

val copy_power_rails_rail_descriptor : power_rails_rail_descriptor -> power_rails_rail_descriptor

val power_rails_rail_descriptor_has_index : power_rails_rail_descriptor -> bool
  (** presence of field "index" in [power_rails_rail_descriptor] *)

val power_rails_rail_descriptor_set_index : power_rails_rail_descriptor -> int32 -> unit
  (** set field index in power_rails_rail_descriptor *)

val power_rails_rail_descriptor_has_rail_name : power_rails_rail_descriptor -> bool
  (** presence of field "rail_name" in [power_rails_rail_descriptor] *)

val power_rails_rail_descriptor_set_rail_name : power_rails_rail_descriptor -> string -> unit
  (** set field rail_name in power_rails_rail_descriptor *)

val power_rails_rail_descriptor_has_subsys_name : power_rails_rail_descriptor -> bool
  (** presence of field "subsys_name" in [power_rails_rail_descriptor] *)

val power_rails_rail_descriptor_set_subsys_name : power_rails_rail_descriptor -> string -> unit
  (** set field subsys_name in power_rails_rail_descriptor *)

val power_rails_rail_descriptor_has_sampling_rate : power_rails_rail_descriptor -> bool
  (** presence of field "sampling_rate" in [power_rails_rail_descriptor] *)

val power_rails_rail_descriptor_set_sampling_rate : power_rails_rail_descriptor -> int32 -> unit
  (** set field sampling_rate in power_rails_rail_descriptor *)

val make_power_rails_energy_data : 
  ?index:int32 ->
  ?timestamp_ms:int64 ->
  ?energy:int64 ->
  unit ->
  power_rails_energy_data
(** [make_power_rails_energy_data … ()] is a builder for type [power_rails_energy_data] *)

val copy_power_rails_energy_data : power_rails_energy_data -> power_rails_energy_data

val power_rails_energy_data_has_index : power_rails_energy_data -> bool
  (** presence of field "index" in [power_rails_energy_data] *)

val power_rails_energy_data_set_index : power_rails_energy_data -> int32 -> unit
  (** set field index in power_rails_energy_data *)

val power_rails_energy_data_has_timestamp_ms : power_rails_energy_data -> bool
  (** presence of field "timestamp_ms" in [power_rails_energy_data] *)

val power_rails_energy_data_set_timestamp_ms : power_rails_energy_data -> int64 -> unit
  (** set field timestamp_ms in power_rails_energy_data *)

val power_rails_energy_data_has_energy : power_rails_energy_data -> bool
  (** presence of field "energy" in [power_rails_energy_data] *)

val power_rails_energy_data_set_energy : power_rails_energy_data -> int64 -> unit
  (** set field energy in power_rails_energy_data *)

val make_power_rails : 
  ?rail_descriptor:power_rails_rail_descriptor list ->
  ?energy_data:power_rails_energy_data list ->
  ?session_uuid:int64 ->
  unit ->
  power_rails
(** [make_power_rails … ()] is a builder for type [power_rails] *)

val copy_power_rails : power_rails -> power_rails

val power_rails_set_rail_descriptor : power_rails -> power_rails_rail_descriptor list -> unit
  (** set field rail_descriptor in power_rails *)

val power_rails_set_energy_data : power_rails -> power_rails_energy_data list -> unit
  (** set field energy_data in power_rails *)

val power_rails_has_session_uuid : power_rails -> bool
  (** presence of field "session_uuid" in [power_rails] *)

val power_rails_set_session_uuid : power_rails -> int64 -> unit
  (** set field session_uuid in power_rails *)

val make_obfuscated_member : 
  ?obfuscated_name:string ->
  ?deobfuscated_name:string ->
  unit ->
  obfuscated_member
(** [make_obfuscated_member … ()] is a builder for type [obfuscated_member] *)

val copy_obfuscated_member : obfuscated_member -> obfuscated_member

val obfuscated_member_has_obfuscated_name : obfuscated_member -> bool
  (** presence of field "obfuscated_name" in [obfuscated_member] *)

val obfuscated_member_set_obfuscated_name : obfuscated_member -> string -> unit
  (** set field obfuscated_name in obfuscated_member *)

val obfuscated_member_has_deobfuscated_name : obfuscated_member -> bool
  (** presence of field "deobfuscated_name" in [obfuscated_member] *)

val obfuscated_member_set_deobfuscated_name : obfuscated_member -> string -> unit
  (** set field deobfuscated_name in obfuscated_member *)

val make_obfuscated_class : 
  ?obfuscated_name:string ->
  ?deobfuscated_name:string ->
  ?obfuscated_members:obfuscated_member list ->
  ?obfuscated_methods:obfuscated_member list ->
  unit ->
  obfuscated_class
(** [make_obfuscated_class … ()] is a builder for type [obfuscated_class] *)

val copy_obfuscated_class : obfuscated_class -> obfuscated_class

val obfuscated_class_has_obfuscated_name : obfuscated_class -> bool
  (** presence of field "obfuscated_name" in [obfuscated_class] *)

val obfuscated_class_set_obfuscated_name : obfuscated_class -> string -> unit
  (** set field obfuscated_name in obfuscated_class *)

val obfuscated_class_has_deobfuscated_name : obfuscated_class -> bool
  (** presence of field "deobfuscated_name" in [obfuscated_class] *)

val obfuscated_class_set_deobfuscated_name : obfuscated_class -> string -> unit
  (** set field deobfuscated_name in obfuscated_class *)

val obfuscated_class_set_obfuscated_members : obfuscated_class -> obfuscated_member list -> unit
  (** set field obfuscated_members in obfuscated_class *)

val obfuscated_class_set_obfuscated_methods : obfuscated_class -> obfuscated_member list -> unit
  (** set field obfuscated_methods in obfuscated_class *)

val make_deobfuscation_mapping : 
  ?package_name:string ->
  ?version_code:int64 ->
  ?obfuscated_classes:obfuscated_class list ->
  unit ->
  deobfuscation_mapping
(** [make_deobfuscation_mapping … ()] is a builder for type [deobfuscation_mapping] *)

val copy_deobfuscation_mapping : deobfuscation_mapping -> deobfuscation_mapping

val deobfuscation_mapping_has_package_name : deobfuscation_mapping -> bool
  (** presence of field "package_name" in [deobfuscation_mapping] *)

val deobfuscation_mapping_set_package_name : deobfuscation_mapping -> string -> unit
  (** set field package_name in deobfuscation_mapping *)

val deobfuscation_mapping_has_version_code : deobfuscation_mapping -> bool
  (** presence of field "version_code" in [deobfuscation_mapping] *)

val deobfuscation_mapping_set_version_code : deobfuscation_mapping -> int64 -> unit
  (** set field version_code in deobfuscation_mapping *)

val deobfuscation_mapping_set_obfuscated_classes : deobfuscation_mapping -> obfuscated_class list -> unit
  (** set field obfuscated_classes in deobfuscation_mapping *)

val make_heap_graph_root : 
  ?object_ids:int64 list ->
  ?root_type:heap_graph_root_type ->
  unit ->
  heap_graph_root
(** [make_heap_graph_root … ()] is a builder for type [heap_graph_root] *)

val copy_heap_graph_root : heap_graph_root -> heap_graph_root

val heap_graph_root_set_object_ids : heap_graph_root -> int64 list -> unit
  (** set field object_ids in heap_graph_root *)

val heap_graph_root_has_root_type : heap_graph_root -> bool
  (** presence of field "root_type" in [heap_graph_root] *)

val heap_graph_root_set_root_type : heap_graph_root -> heap_graph_root_type -> unit
  (** set field root_type in heap_graph_root *)

val make_heap_graph_type : 
  ?id:int64 ->
  ?location_id:int64 ->
  ?class_name:string ->
  ?object_size:int64 ->
  ?superclass_id:int64 ->
  ?reference_field_id:int64 list ->
  ?kind:heap_graph_type_kind ->
  ?classloader_id:int64 ->
  unit ->
  heap_graph_type
(** [make_heap_graph_type … ()] is a builder for type [heap_graph_type] *)

val copy_heap_graph_type : heap_graph_type -> heap_graph_type

val heap_graph_type_has_id : heap_graph_type -> bool
  (** presence of field "id" in [heap_graph_type] *)

val heap_graph_type_set_id : heap_graph_type -> int64 -> unit
  (** set field id in heap_graph_type *)

val heap_graph_type_has_location_id : heap_graph_type -> bool
  (** presence of field "location_id" in [heap_graph_type] *)

val heap_graph_type_set_location_id : heap_graph_type -> int64 -> unit
  (** set field location_id in heap_graph_type *)

val heap_graph_type_has_class_name : heap_graph_type -> bool
  (** presence of field "class_name" in [heap_graph_type] *)

val heap_graph_type_set_class_name : heap_graph_type -> string -> unit
  (** set field class_name in heap_graph_type *)

val heap_graph_type_has_object_size : heap_graph_type -> bool
  (** presence of field "object_size" in [heap_graph_type] *)

val heap_graph_type_set_object_size : heap_graph_type -> int64 -> unit
  (** set field object_size in heap_graph_type *)

val heap_graph_type_has_superclass_id : heap_graph_type -> bool
  (** presence of field "superclass_id" in [heap_graph_type] *)

val heap_graph_type_set_superclass_id : heap_graph_type -> int64 -> unit
  (** set field superclass_id in heap_graph_type *)

val heap_graph_type_set_reference_field_id : heap_graph_type -> int64 list -> unit
  (** set field reference_field_id in heap_graph_type *)

val heap_graph_type_has_kind : heap_graph_type -> bool
  (** presence of field "kind" in [heap_graph_type] *)

val heap_graph_type_set_kind : heap_graph_type -> heap_graph_type_kind -> unit
  (** set field kind in heap_graph_type *)

val heap_graph_type_has_classloader_id : heap_graph_type -> bool
  (** presence of field "classloader_id" in [heap_graph_type] *)

val heap_graph_type_set_classloader_id : heap_graph_type -> int64 -> unit
  (** set field classloader_id in heap_graph_type *)

val make_heap_graph_object : 
  ?identifier:heap_graph_object_identifier ->
  ?type_id:int64 ->
  ?self_size:int64 ->
  ?reference_field_id_base:int64 ->
  ?reference_field_id:int64 list ->
  ?reference_object_id:int64 list ->
  ?native_allocation_registry_size_field:int64 ->
  ?heap_type_delta:heap_graph_object_heap_type ->
  ?runtime_internal_object_id:int64 list ->
  unit ->
  heap_graph_object
(** [make_heap_graph_object … ()] is a builder for type [heap_graph_object] *)

val copy_heap_graph_object : heap_graph_object -> heap_graph_object

val heap_graph_object_set_identifier : heap_graph_object -> heap_graph_object_identifier -> unit
  (** set field identifier in heap_graph_object *)

val heap_graph_object_has_type_id : heap_graph_object -> bool
  (** presence of field "type_id" in [heap_graph_object] *)

val heap_graph_object_set_type_id : heap_graph_object -> int64 -> unit
  (** set field type_id in heap_graph_object *)

val heap_graph_object_has_self_size : heap_graph_object -> bool
  (** presence of field "self_size" in [heap_graph_object] *)

val heap_graph_object_set_self_size : heap_graph_object -> int64 -> unit
  (** set field self_size in heap_graph_object *)

val heap_graph_object_has_reference_field_id_base : heap_graph_object -> bool
  (** presence of field "reference_field_id_base" in [heap_graph_object] *)

val heap_graph_object_set_reference_field_id_base : heap_graph_object -> int64 -> unit
  (** set field reference_field_id_base in heap_graph_object *)

val heap_graph_object_set_reference_field_id : heap_graph_object -> int64 list -> unit
  (** set field reference_field_id in heap_graph_object *)

val heap_graph_object_set_reference_object_id : heap_graph_object -> int64 list -> unit
  (** set field reference_object_id in heap_graph_object *)

val heap_graph_object_has_native_allocation_registry_size_field : heap_graph_object -> bool
  (** presence of field "native_allocation_registry_size_field" in [heap_graph_object] *)

val heap_graph_object_set_native_allocation_registry_size_field : heap_graph_object -> int64 -> unit
  (** set field native_allocation_registry_size_field in heap_graph_object *)

val heap_graph_object_has_heap_type_delta : heap_graph_object -> bool
  (** presence of field "heap_type_delta" in [heap_graph_object] *)

val heap_graph_object_set_heap_type_delta : heap_graph_object -> heap_graph_object_heap_type -> unit
  (** set field heap_type_delta in heap_graph_object *)

val heap_graph_object_set_runtime_internal_object_id : heap_graph_object -> int64 list -> unit
  (** set field runtime_internal_object_id in heap_graph_object *)

val make_heap_graph : 
  ?pid:int32 ->
  ?objects:heap_graph_object list ->
  ?roots:heap_graph_root list ->
  ?types:heap_graph_type list ->
  ?field_names:interned_string list ->
  ?location_names:interned_string list ->
  ?continued:bool ->
  ?index:int64 ->
  unit ->
  heap_graph
(** [make_heap_graph … ()] is a builder for type [heap_graph] *)

val copy_heap_graph : heap_graph -> heap_graph

val heap_graph_has_pid : heap_graph -> bool
  (** presence of field "pid" in [heap_graph] *)

val heap_graph_set_pid : heap_graph -> int32 -> unit
  (** set field pid in heap_graph *)

val heap_graph_set_objects : heap_graph -> heap_graph_object list -> unit
  (** set field objects in heap_graph *)

val heap_graph_set_roots : heap_graph -> heap_graph_root list -> unit
  (** set field roots in heap_graph *)

val heap_graph_set_types : heap_graph -> heap_graph_type list -> unit
  (** set field types in heap_graph *)

val heap_graph_set_field_names : heap_graph -> interned_string list -> unit
  (** set field field_names in heap_graph *)

val heap_graph_set_location_names : heap_graph -> interned_string list -> unit
  (** set field location_names in heap_graph *)

val heap_graph_has_continued : heap_graph -> bool
  (** presence of field "continued" in [heap_graph] *)

val heap_graph_set_continued : heap_graph -> bool -> unit
  (** set field continued in heap_graph *)

val heap_graph_has_index : heap_graph -> bool
  (** presence of field "index" in [heap_graph] *)

val heap_graph_set_index : heap_graph -> int64 -> unit
  (** set field index in heap_graph *)

val make_profile_packet_heap_sample : 
  ?callstack_id:int64 ->
  ?self_allocated:int64 ->
  ?self_freed:int64 ->
  ?self_max:int64 ->
  ?self_max_count:int64 ->
  ?timestamp:int64 ->
  ?alloc_count:int64 ->
  ?free_count:int64 ->
  unit ->
  profile_packet_heap_sample
(** [make_profile_packet_heap_sample … ()] is a builder for type [profile_packet_heap_sample] *)

val copy_profile_packet_heap_sample : profile_packet_heap_sample -> profile_packet_heap_sample

val profile_packet_heap_sample_has_callstack_id : profile_packet_heap_sample -> bool
  (** presence of field "callstack_id" in [profile_packet_heap_sample] *)

val profile_packet_heap_sample_set_callstack_id : profile_packet_heap_sample -> int64 -> unit
  (** set field callstack_id in profile_packet_heap_sample *)

val profile_packet_heap_sample_has_self_allocated : profile_packet_heap_sample -> bool
  (** presence of field "self_allocated" in [profile_packet_heap_sample] *)

val profile_packet_heap_sample_set_self_allocated : profile_packet_heap_sample -> int64 -> unit
  (** set field self_allocated in profile_packet_heap_sample *)

val profile_packet_heap_sample_has_self_freed : profile_packet_heap_sample -> bool
  (** presence of field "self_freed" in [profile_packet_heap_sample] *)

val profile_packet_heap_sample_set_self_freed : profile_packet_heap_sample -> int64 -> unit
  (** set field self_freed in profile_packet_heap_sample *)

val profile_packet_heap_sample_has_self_max : profile_packet_heap_sample -> bool
  (** presence of field "self_max" in [profile_packet_heap_sample] *)

val profile_packet_heap_sample_set_self_max : profile_packet_heap_sample -> int64 -> unit
  (** set field self_max in profile_packet_heap_sample *)

val profile_packet_heap_sample_has_self_max_count : profile_packet_heap_sample -> bool
  (** presence of field "self_max_count" in [profile_packet_heap_sample] *)

val profile_packet_heap_sample_set_self_max_count : profile_packet_heap_sample -> int64 -> unit
  (** set field self_max_count in profile_packet_heap_sample *)

val profile_packet_heap_sample_has_timestamp : profile_packet_heap_sample -> bool
  (** presence of field "timestamp" in [profile_packet_heap_sample] *)

val profile_packet_heap_sample_set_timestamp : profile_packet_heap_sample -> int64 -> unit
  (** set field timestamp in profile_packet_heap_sample *)

val profile_packet_heap_sample_has_alloc_count : profile_packet_heap_sample -> bool
  (** presence of field "alloc_count" in [profile_packet_heap_sample] *)

val profile_packet_heap_sample_set_alloc_count : profile_packet_heap_sample -> int64 -> unit
  (** set field alloc_count in profile_packet_heap_sample *)

val profile_packet_heap_sample_has_free_count : profile_packet_heap_sample -> bool
  (** presence of field "free_count" in [profile_packet_heap_sample] *)

val profile_packet_heap_sample_set_free_count : profile_packet_heap_sample -> int64 -> unit
  (** set field free_count in profile_packet_heap_sample *)

val make_profile_packet_histogram_bucket : 
  ?upper_limit:int64 ->
  ?max_bucket:bool ->
  ?count:int64 ->
  unit ->
  profile_packet_histogram_bucket
(** [make_profile_packet_histogram_bucket … ()] is a builder for type [profile_packet_histogram_bucket] *)

val copy_profile_packet_histogram_bucket : profile_packet_histogram_bucket -> profile_packet_histogram_bucket

val profile_packet_histogram_bucket_has_upper_limit : profile_packet_histogram_bucket -> bool
  (** presence of field "upper_limit" in [profile_packet_histogram_bucket] *)

val profile_packet_histogram_bucket_set_upper_limit : profile_packet_histogram_bucket -> int64 -> unit
  (** set field upper_limit in profile_packet_histogram_bucket *)

val profile_packet_histogram_bucket_has_max_bucket : profile_packet_histogram_bucket -> bool
  (** presence of field "max_bucket" in [profile_packet_histogram_bucket] *)

val profile_packet_histogram_bucket_set_max_bucket : profile_packet_histogram_bucket -> bool -> unit
  (** set field max_bucket in profile_packet_histogram_bucket *)

val profile_packet_histogram_bucket_has_count : profile_packet_histogram_bucket -> bool
  (** presence of field "count" in [profile_packet_histogram_bucket] *)

val profile_packet_histogram_bucket_set_count : profile_packet_histogram_bucket -> int64 -> unit
  (** set field count in profile_packet_histogram_bucket *)

val make_profile_packet_histogram : 
  ?buckets:profile_packet_histogram_bucket list ->
  unit ->
  profile_packet_histogram
(** [make_profile_packet_histogram … ()] is a builder for type [profile_packet_histogram] *)

val copy_profile_packet_histogram : profile_packet_histogram -> profile_packet_histogram

val profile_packet_histogram_set_buckets : profile_packet_histogram -> profile_packet_histogram_bucket list -> unit
  (** set field buckets in profile_packet_histogram *)

val make_profile_packet_process_stats : 
  ?unwinding_errors:int64 ->
  ?heap_samples:int64 ->
  ?map_reparses:int64 ->
  ?unwinding_time_us:profile_packet_histogram ->
  ?total_unwinding_time_us:int64 ->
  ?client_spinlock_blocked_us:int64 ->
  unit ->
  profile_packet_process_stats
(** [make_profile_packet_process_stats … ()] is a builder for type [profile_packet_process_stats] *)

val copy_profile_packet_process_stats : profile_packet_process_stats -> profile_packet_process_stats

val profile_packet_process_stats_has_unwinding_errors : profile_packet_process_stats -> bool
  (** presence of field "unwinding_errors" in [profile_packet_process_stats] *)

val profile_packet_process_stats_set_unwinding_errors : profile_packet_process_stats -> int64 -> unit
  (** set field unwinding_errors in profile_packet_process_stats *)

val profile_packet_process_stats_has_heap_samples : profile_packet_process_stats -> bool
  (** presence of field "heap_samples" in [profile_packet_process_stats] *)

val profile_packet_process_stats_set_heap_samples : profile_packet_process_stats -> int64 -> unit
  (** set field heap_samples in profile_packet_process_stats *)

val profile_packet_process_stats_has_map_reparses : profile_packet_process_stats -> bool
  (** presence of field "map_reparses" in [profile_packet_process_stats] *)

val profile_packet_process_stats_set_map_reparses : profile_packet_process_stats -> int64 -> unit
  (** set field map_reparses in profile_packet_process_stats *)

val profile_packet_process_stats_set_unwinding_time_us : profile_packet_process_stats -> profile_packet_histogram -> unit
  (** set field unwinding_time_us in profile_packet_process_stats *)

val profile_packet_process_stats_has_total_unwinding_time_us : profile_packet_process_stats -> bool
  (** presence of field "total_unwinding_time_us" in [profile_packet_process_stats] *)

val profile_packet_process_stats_set_total_unwinding_time_us : profile_packet_process_stats -> int64 -> unit
  (** set field total_unwinding_time_us in profile_packet_process_stats *)

val profile_packet_process_stats_has_client_spinlock_blocked_us : profile_packet_process_stats -> bool
  (** presence of field "client_spinlock_blocked_us" in [profile_packet_process_stats] *)

val profile_packet_process_stats_set_client_spinlock_blocked_us : profile_packet_process_stats -> int64 -> unit
  (** set field client_spinlock_blocked_us in profile_packet_process_stats *)

val make_profile_packet_process_heap_samples : 
  ?pid:int64 ->
  ?from_startup:bool ->
  ?rejected_concurrent:bool ->
  ?disconnected:bool ->
  ?buffer_overran:bool ->
  ?client_error:profile_packet_process_heap_samples_client_error ->
  ?buffer_corrupted:bool ->
  ?hit_guardrail:bool ->
  ?heap_name:string ->
  ?sampling_interval_bytes:int64 ->
  ?orig_sampling_interval_bytes:int64 ->
  ?timestamp:int64 ->
  ?stats:profile_packet_process_stats ->
  ?samples:profile_packet_heap_sample list ->
  unit ->
  profile_packet_process_heap_samples
(** [make_profile_packet_process_heap_samples … ()] is a builder for type [profile_packet_process_heap_samples] *)

val copy_profile_packet_process_heap_samples : profile_packet_process_heap_samples -> profile_packet_process_heap_samples

val profile_packet_process_heap_samples_has_pid : profile_packet_process_heap_samples -> bool
  (** presence of field "pid" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_pid : profile_packet_process_heap_samples -> int64 -> unit
  (** set field pid in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_from_startup : profile_packet_process_heap_samples -> bool
  (** presence of field "from_startup" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_from_startup : profile_packet_process_heap_samples -> bool -> unit
  (** set field from_startup in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_rejected_concurrent : profile_packet_process_heap_samples -> bool
  (** presence of field "rejected_concurrent" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_rejected_concurrent : profile_packet_process_heap_samples -> bool -> unit
  (** set field rejected_concurrent in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_disconnected : profile_packet_process_heap_samples -> bool
  (** presence of field "disconnected" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_disconnected : profile_packet_process_heap_samples -> bool -> unit
  (** set field disconnected in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_buffer_overran : profile_packet_process_heap_samples -> bool
  (** presence of field "buffer_overran" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_buffer_overran : profile_packet_process_heap_samples -> bool -> unit
  (** set field buffer_overran in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_client_error : profile_packet_process_heap_samples -> bool
  (** presence of field "client_error" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_client_error : profile_packet_process_heap_samples -> profile_packet_process_heap_samples_client_error -> unit
  (** set field client_error in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_buffer_corrupted : profile_packet_process_heap_samples -> bool
  (** presence of field "buffer_corrupted" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_buffer_corrupted : profile_packet_process_heap_samples -> bool -> unit
  (** set field buffer_corrupted in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_hit_guardrail : profile_packet_process_heap_samples -> bool
  (** presence of field "hit_guardrail" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_hit_guardrail : profile_packet_process_heap_samples -> bool -> unit
  (** set field hit_guardrail in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_heap_name : profile_packet_process_heap_samples -> bool
  (** presence of field "heap_name" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_heap_name : profile_packet_process_heap_samples -> string -> unit
  (** set field heap_name in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_sampling_interval_bytes : profile_packet_process_heap_samples -> bool
  (** presence of field "sampling_interval_bytes" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_sampling_interval_bytes : profile_packet_process_heap_samples -> int64 -> unit
  (** set field sampling_interval_bytes in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_orig_sampling_interval_bytes : profile_packet_process_heap_samples -> bool
  (** presence of field "orig_sampling_interval_bytes" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_orig_sampling_interval_bytes : profile_packet_process_heap_samples -> int64 -> unit
  (** set field orig_sampling_interval_bytes in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_has_timestamp : profile_packet_process_heap_samples -> bool
  (** presence of field "timestamp" in [profile_packet_process_heap_samples] *)

val profile_packet_process_heap_samples_set_timestamp : profile_packet_process_heap_samples -> int64 -> unit
  (** set field timestamp in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_set_stats : profile_packet_process_heap_samples -> profile_packet_process_stats -> unit
  (** set field stats in profile_packet_process_heap_samples *)

val profile_packet_process_heap_samples_set_samples : profile_packet_process_heap_samples -> profile_packet_heap_sample list -> unit
  (** set field samples in profile_packet_process_heap_samples *)

val make_profile_packet : 
  ?strings:interned_string list ->
  ?mappings:mapping list ->
  ?frames:frame list ->
  ?callstacks:callstack list ->
  ?process_dumps:profile_packet_process_heap_samples list ->
  ?continued:bool ->
  ?index:int64 ->
  unit ->
  profile_packet
(** [make_profile_packet … ()] is a builder for type [profile_packet] *)

val copy_profile_packet : profile_packet -> profile_packet

val profile_packet_set_strings : profile_packet -> interned_string list -> unit
  (** set field strings in profile_packet *)

val profile_packet_set_mappings : profile_packet -> mapping list -> unit
  (** set field mappings in profile_packet *)

val profile_packet_set_frames : profile_packet -> frame list -> unit
  (** set field frames in profile_packet *)

val profile_packet_set_callstacks : profile_packet -> callstack list -> unit
  (** set field callstacks in profile_packet *)

val profile_packet_set_process_dumps : profile_packet -> profile_packet_process_heap_samples list -> unit
  (** set field process_dumps in profile_packet *)

val profile_packet_has_continued : profile_packet -> bool
  (** presence of field "continued" in [profile_packet] *)

val profile_packet_set_continued : profile_packet -> bool -> unit
  (** set field continued in profile_packet *)

val profile_packet_has_index : profile_packet -> bool
  (** presence of field "index" in [profile_packet] *)

val profile_packet_set_index : profile_packet -> int64 -> unit
  (** set field index in profile_packet *)

val make_streaming_allocation : 
  ?address:int64 list ->
  ?size:int64 list ->
  ?sample_size:int64 list ->
  ?clock_monotonic_coarse_timestamp:int64 list ->
  ?heap_id:int32 list ->
  ?sequence_number:int64 list ->
  unit ->
  streaming_allocation
(** [make_streaming_allocation … ()] is a builder for type [streaming_allocation] *)

val copy_streaming_allocation : streaming_allocation -> streaming_allocation

val streaming_allocation_set_address : streaming_allocation -> int64 list -> unit
  (** set field address in streaming_allocation *)

val streaming_allocation_set_size : streaming_allocation -> int64 list -> unit
  (** set field size in streaming_allocation *)

val streaming_allocation_set_sample_size : streaming_allocation -> int64 list -> unit
  (** set field sample_size in streaming_allocation *)

val streaming_allocation_set_clock_monotonic_coarse_timestamp : streaming_allocation -> int64 list -> unit
  (** set field clock_monotonic_coarse_timestamp in streaming_allocation *)

val streaming_allocation_set_heap_id : streaming_allocation -> int32 list -> unit
  (** set field heap_id in streaming_allocation *)

val streaming_allocation_set_sequence_number : streaming_allocation -> int64 list -> unit
  (** set field sequence_number in streaming_allocation *)

val make_streaming_free : 
  ?address:int64 list ->
  ?heap_id:int32 list ->
  ?sequence_number:int64 list ->
  unit ->
  streaming_free
(** [make_streaming_free … ()] is a builder for type [streaming_free] *)

val copy_streaming_free : streaming_free -> streaming_free

val streaming_free_set_address : streaming_free -> int64 list -> unit
  (** set field address in streaming_free *)

val streaming_free_set_heap_id : streaming_free -> int32 list -> unit
  (** set field heap_id in streaming_free *)

val streaming_free_set_sequence_number : streaming_free -> int64 list -> unit
  (** set field sequence_number in streaming_free *)

val make_streaming_profile_packet : 
  ?callstack_iid:int64 list ->
  ?timestamp_delta_us:int64 list ->
  ?process_priority:int32 ->
  unit ->
  streaming_profile_packet
(** [make_streaming_profile_packet … ()] is a builder for type [streaming_profile_packet] *)

val copy_streaming_profile_packet : streaming_profile_packet -> streaming_profile_packet

val streaming_profile_packet_set_callstack_iid : streaming_profile_packet -> int64 list -> unit
  (** set field callstack_iid in streaming_profile_packet *)

val streaming_profile_packet_set_timestamp_delta_us : streaming_profile_packet -> int64 list -> unit
  (** set field timestamp_delta_us in streaming_profile_packet *)

val streaming_profile_packet_has_process_priority : streaming_profile_packet -> bool
  (** presence of field "process_priority" in [streaming_profile_packet] *)

val streaming_profile_packet_set_process_priority : streaming_profile_packet -> int32 -> unit
  (** set field process_priority in streaming_profile_packet *)

val make_perf_sample : 
  ?cpu:int32 ->
  ?pid:int32 ->
  ?tid:int32 ->
  ?cpu_mode:profiling_cpu_mode ->
  ?timebase_count:int64 ->
  ?follower_counts:int64 list ->
  ?callstack_iid:int64 ->
  ?optional_unwind_error:perf_sample_optional_unwind_error ->
  ?kernel_records_lost:int64 ->
  ?optional_sample_skipped_reason:perf_sample_optional_sample_skipped_reason ->
  ?producer_event:perf_sample_producer_event ->
  unit ->
  perf_sample
(** [make_perf_sample … ()] is a builder for type [perf_sample] *)

val copy_perf_sample : perf_sample -> perf_sample

val perf_sample_has_cpu : perf_sample -> bool
  (** presence of field "cpu" in [perf_sample] *)

val perf_sample_set_cpu : perf_sample -> int32 -> unit
  (** set field cpu in perf_sample *)

val perf_sample_has_pid : perf_sample -> bool
  (** presence of field "pid" in [perf_sample] *)

val perf_sample_set_pid : perf_sample -> int32 -> unit
  (** set field pid in perf_sample *)

val perf_sample_has_tid : perf_sample -> bool
  (** presence of field "tid" in [perf_sample] *)

val perf_sample_set_tid : perf_sample -> int32 -> unit
  (** set field tid in perf_sample *)

val perf_sample_has_cpu_mode : perf_sample -> bool
  (** presence of field "cpu_mode" in [perf_sample] *)

val perf_sample_set_cpu_mode : perf_sample -> profiling_cpu_mode -> unit
  (** set field cpu_mode in perf_sample *)

val perf_sample_has_timebase_count : perf_sample -> bool
  (** presence of field "timebase_count" in [perf_sample] *)

val perf_sample_set_timebase_count : perf_sample -> int64 -> unit
  (** set field timebase_count in perf_sample *)

val perf_sample_set_follower_counts : perf_sample -> int64 list -> unit
  (** set field follower_counts in perf_sample *)

val perf_sample_has_callstack_iid : perf_sample -> bool
  (** presence of field "callstack_iid" in [perf_sample] *)

val perf_sample_set_callstack_iid : perf_sample -> int64 -> unit
  (** set field callstack_iid in perf_sample *)

val perf_sample_set_optional_unwind_error : perf_sample -> perf_sample_optional_unwind_error -> unit
  (** set field optional_unwind_error in perf_sample *)

val perf_sample_has_kernel_records_lost : perf_sample -> bool
  (** presence of field "kernel_records_lost" in [perf_sample] *)

val perf_sample_set_kernel_records_lost : perf_sample -> int64 -> unit
  (** set field kernel_records_lost in perf_sample *)

val perf_sample_set_optional_sample_skipped_reason : perf_sample -> perf_sample_optional_sample_skipped_reason -> unit
  (** set field optional_sample_skipped_reason in perf_sample *)

val perf_sample_set_producer_event : perf_sample -> perf_sample_producer_event -> unit
  (** set field producer_event in perf_sample *)

val make_smaps_entry : 
  ?path:string ->
  ?size_kb:int64 ->
  ?private_dirty_kb:int64 ->
  ?swap_kb:int64 ->
  ?file_name:string ->
  ?start_address:int64 ->
  ?module_timestamp:int64 ->
  ?module_debugid:string ->
  ?module_debug_path:string ->
  ?protection_flags:int32 ->
  ?private_clean_resident_kb:int64 ->
  ?shared_dirty_resident_kb:int64 ->
  ?shared_clean_resident_kb:int64 ->
  ?locked_kb:int64 ->
  ?proportional_resident_kb:int64 ->
  unit ->
  smaps_entry
(** [make_smaps_entry … ()] is a builder for type [smaps_entry] *)

val copy_smaps_entry : smaps_entry -> smaps_entry

val smaps_entry_has_path : smaps_entry -> bool
  (** presence of field "path" in [smaps_entry] *)

val smaps_entry_set_path : smaps_entry -> string -> unit
  (** set field path in smaps_entry *)

val smaps_entry_has_size_kb : smaps_entry -> bool
  (** presence of field "size_kb" in [smaps_entry] *)

val smaps_entry_set_size_kb : smaps_entry -> int64 -> unit
  (** set field size_kb in smaps_entry *)

val smaps_entry_has_private_dirty_kb : smaps_entry -> bool
  (** presence of field "private_dirty_kb" in [smaps_entry] *)

val smaps_entry_set_private_dirty_kb : smaps_entry -> int64 -> unit
  (** set field private_dirty_kb in smaps_entry *)

val smaps_entry_has_swap_kb : smaps_entry -> bool
  (** presence of field "swap_kb" in [smaps_entry] *)

val smaps_entry_set_swap_kb : smaps_entry -> int64 -> unit
  (** set field swap_kb in smaps_entry *)

val smaps_entry_has_file_name : smaps_entry -> bool
  (** presence of field "file_name" in [smaps_entry] *)

val smaps_entry_set_file_name : smaps_entry -> string -> unit
  (** set field file_name in smaps_entry *)

val smaps_entry_has_start_address : smaps_entry -> bool
  (** presence of field "start_address" in [smaps_entry] *)

val smaps_entry_set_start_address : smaps_entry -> int64 -> unit
  (** set field start_address in smaps_entry *)

val smaps_entry_has_module_timestamp : smaps_entry -> bool
  (** presence of field "module_timestamp" in [smaps_entry] *)

val smaps_entry_set_module_timestamp : smaps_entry -> int64 -> unit
  (** set field module_timestamp in smaps_entry *)

val smaps_entry_has_module_debugid : smaps_entry -> bool
  (** presence of field "module_debugid" in [smaps_entry] *)

val smaps_entry_set_module_debugid : smaps_entry -> string -> unit
  (** set field module_debugid in smaps_entry *)

val smaps_entry_has_module_debug_path : smaps_entry -> bool
  (** presence of field "module_debug_path" in [smaps_entry] *)

val smaps_entry_set_module_debug_path : smaps_entry -> string -> unit
  (** set field module_debug_path in smaps_entry *)

val smaps_entry_has_protection_flags : smaps_entry -> bool
  (** presence of field "protection_flags" in [smaps_entry] *)

val smaps_entry_set_protection_flags : smaps_entry -> int32 -> unit
  (** set field protection_flags in smaps_entry *)

val smaps_entry_has_private_clean_resident_kb : smaps_entry -> bool
  (** presence of field "private_clean_resident_kb" in [smaps_entry] *)

val smaps_entry_set_private_clean_resident_kb : smaps_entry -> int64 -> unit
  (** set field private_clean_resident_kb in smaps_entry *)

val smaps_entry_has_shared_dirty_resident_kb : smaps_entry -> bool
  (** presence of field "shared_dirty_resident_kb" in [smaps_entry] *)

val smaps_entry_set_shared_dirty_resident_kb : smaps_entry -> int64 -> unit
  (** set field shared_dirty_resident_kb in smaps_entry *)

val smaps_entry_has_shared_clean_resident_kb : smaps_entry -> bool
  (** presence of field "shared_clean_resident_kb" in [smaps_entry] *)

val smaps_entry_set_shared_clean_resident_kb : smaps_entry -> int64 -> unit
  (** set field shared_clean_resident_kb in smaps_entry *)

val smaps_entry_has_locked_kb : smaps_entry -> bool
  (** presence of field "locked_kb" in [smaps_entry] *)

val smaps_entry_set_locked_kb : smaps_entry -> int64 -> unit
  (** set field locked_kb in smaps_entry *)

val smaps_entry_has_proportional_resident_kb : smaps_entry -> bool
  (** presence of field "proportional_resident_kb" in [smaps_entry] *)

val smaps_entry_set_proportional_resident_kb : smaps_entry -> int64 -> unit
  (** set field proportional_resident_kb in smaps_entry *)

val make_smaps_packet : 
  ?pid:int32 ->
  ?entries:smaps_entry list ->
  unit ->
  smaps_packet
(** [make_smaps_packet … ()] is a builder for type [smaps_packet] *)

val copy_smaps_packet : smaps_packet -> smaps_packet

val smaps_packet_has_pid : smaps_packet -> bool
  (** presence of field "pid" in [smaps_packet] *)

val smaps_packet_set_pid : smaps_packet -> int32 -> unit
  (** set field pid in smaps_packet *)

val smaps_packet_set_entries : smaps_packet -> smaps_entry list -> unit
  (** set field entries in smaps_packet *)

val make_process_stats_thread : 
  ?tid:int32 ->
  unit ->
  process_stats_thread
(** [make_process_stats_thread … ()] is a builder for type [process_stats_thread] *)

val copy_process_stats_thread : process_stats_thread -> process_stats_thread

val process_stats_thread_has_tid : process_stats_thread -> bool
  (** presence of field "tid" in [process_stats_thread] *)

val process_stats_thread_set_tid : process_stats_thread -> int32 -> unit
  (** set field tid in process_stats_thread *)

val make_process_stats_fdinfo : 
  ?fd:int64 ->
  ?path:string ->
  unit ->
  process_stats_fdinfo
(** [make_process_stats_fdinfo … ()] is a builder for type [process_stats_fdinfo] *)

val copy_process_stats_fdinfo : process_stats_fdinfo -> process_stats_fdinfo

val process_stats_fdinfo_has_fd : process_stats_fdinfo -> bool
  (** presence of field "fd" in [process_stats_fdinfo] *)

val process_stats_fdinfo_set_fd : process_stats_fdinfo -> int64 -> unit
  (** set field fd in process_stats_fdinfo *)

val process_stats_fdinfo_has_path : process_stats_fdinfo -> bool
  (** presence of field "path" in [process_stats_fdinfo] *)

val process_stats_fdinfo_set_path : process_stats_fdinfo -> string -> unit
  (** set field path in process_stats_fdinfo *)

val make_process_stats_process : 
  ?pid:int32 ->
  ?threads:process_stats_thread list ->
  ?vm_size_kb:int64 ->
  ?vm_rss_kb:int64 ->
  ?rss_anon_kb:int64 ->
  ?rss_file_kb:int64 ->
  ?rss_shmem_kb:int64 ->
  ?vm_swap_kb:int64 ->
  ?vm_locked_kb:int64 ->
  ?vm_hwm_kb:int64 ->
  ?oom_score_adj:int64 ->
  ?is_peak_rss_resettable:bool ->
  ?chrome_private_footprint_kb:int32 ->
  ?chrome_peak_resident_set_kb:int32 ->
  ?fds:process_stats_fdinfo list ->
  ?smr_rss_kb:int64 ->
  ?smr_pss_kb:int64 ->
  ?smr_pss_anon_kb:int64 ->
  ?smr_pss_file_kb:int64 ->
  ?smr_pss_shmem_kb:int64 ->
  ?smr_swap_pss_kb:int64 ->
  ?runtime_user_mode:int64 ->
  ?runtime_kernel_mode:int64 ->
  ?dmabuf_rss_kb:int64 ->
  unit ->
  process_stats_process
(** [make_process_stats_process … ()] is a builder for type [process_stats_process] *)

val copy_process_stats_process : process_stats_process -> process_stats_process

val process_stats_process_has_pid : process_stats_process -> bool
  (** presence of field "pid" in [process_stats_process] *)

val process_stats_process_set_pid : process_stats_process -> int32 -> unit
  (** set field pid in process_stats_process *)

val process_stats_process_set_threads : process_stats_process -> process_stats_thread list -> unit
  (** set field threads in process_stats_process *)

val process_stats_process_has_vm_size_kb : process_stats_process -> bool
  (** presence of field "vm_size_kb" in [process_stats_process] *)

val process_stats_process_set_vm_size_kb : process_stats_process -> int64 -> unit
  (** set field vm_size_kb in process_stats_process *)

val process_stats_process_has_vm_rss_kb : process_stats_process -> bool
  (** presence of field "vm_rss_kb" in [process_stats_process] *)

val process_stats_process_set_vm_rss_kb : process_stats_process -> int64 -> unit
  (** set field vm_rss_kb in process_stats_process *)

val process_stats_process_has_rss_anon_kb : process_stats_process -> bool
  (** presence of field "rss_anon_kb" in [process_stats_process] *)

val process_stats_process_set_rss_anon_kb : process_stats_process -> int64 -> unit
  (** set field rss_anon_kb in process_stats_process *)

val process_stats_process_has_rss_file_kb : process_stats_process -> bool
  (** presence of field "rss_file_kb" in [process_stats_process] *)

val process_stats_process_set_rss_file_kb : process_stats_process -> int64 -> unit
  (** set field rss_file_kb in process_stats_process *)

val process_stats_process_has_rss_shmem_kb : process_stats_process -> bool
  (** presence of field "rss_shmem_kb" in [process_stats_process] *)

val process_stats_process_set_rss_shmem_kb : process_stats_process -> int64 -> unit
  (** set field rss_shmem_kb in process_stats_process *)

val process_stats_process_has_vm_swap_kb : process_stats_process -> bool
  (** presence of field "vm_swap_kb" in [process_stats_process] *)

val process_stats_process_set_vm_swap_kb : process_stats_process -> int64 -> unit
  (** set field vm_swap_kb in process_stats_process *)

val process_stats_process_has_vm_locked_kb : process_stats_process -> bool
  (** presence of field "vm_locked_kb" in [process_stats_process] *)

val process_stats_process_set_vm_locked_kb : process_stats_process -> int64 -> unit
  (** set field vm_locked_kb in process_stats_process *)

val process_stats_process_has_vm_hwm_kb : process_stats_process -> bool
  (** presence of field "vm_hwm_kb" in [process_stats_process] *)

val process_stats_process_set_vm_hwm_kb : process_stats_process -> int64 -> unit
  (** set field vm_hwm_kb in process_stats_process *)

val process_stats_process_has_oom_score_adj : process_stats_process -> bool
  (** presence of field "oom_score_adj" in [process_stats_process] *)

val process_stats_process_set_oom_score_adj : process_stats_process -> int64 -> unit
  (** set field oom_score_adj in process_stats_process *)

val process_stats_process_has_is_peak_rss_resettable : process_stats_process -> bool
  (** presence of field "is_peak_rss_resettable" in [process_stats_process] *)

val process_stats_process_set_is_peak_rss_resettable : process_stats_process -> bool -> unit
  (** set field is_peak_rss_resettable in process_stats_process *)

val process_stats_process_has_chrome_private_footprint_kb : process_stats_process -> bool
  (** presence of field "chrome_private_footprint_kb" in [process_stats_process] *)

val process_stats_process_set_chrome_private_footprint_kb : process_stats_process -> int32 -> unit
  (** set field chrome_private_footprint_kb in process_stats_process *)

val process_stats_process_has_chrome_peak_resident_set_kb : process_stats_process -> bool
  (** presence of field "chrome_peak_resident_set_kb" in [process_stats_process] *)

val process_stats_process_set_chrome_peak_resident_set_kb : process_stats_process -> int32 -> unit
  (** set field chrome_peak_resident_set_kb in process_stats_process *)

val process_stats_process_set_fds : process_stats_process -> process_stats_fdinfo list -> unit
  (** set field fds in process_stats_process *)

val process_stats_process_has_smr_rss_kb : process_stats_process -> bool
  (** presence of field "smr_rss_kb" in [process_stats_process] *)

val process_stats_process_set_smr_rss_kb : process_stats_process -> int64 -> unit
  (** set field smr_rss_kb in process_stats_process *)

val process_stats_process_has_smr_pss_kb : process_stats_process -> bool
  (** presence of field "smr_pss_kb" in [process_stats_process] *)

val process_stats_process_set_smr_pss_kb : process_stats_process -> int64 -> unit
  (** set field smr_pss_kb in process_stats_process *)

val process_stats_process_has_smr_pss_anon_kb : process_stats_process -> bool
  (** presence of field "smr_pss_anon_kb" in [process_stats_process] *)

val process_stats_process_set_smr_pss_anon_kb : process_stats_process -> int64 -> unit
  (** set field smr_pss_anon_kb in process_stats_process *)

val process_stats_process_has_smr_pss_file_kb : process_stats_process -> bool
  (** presence of field "smr_pss_file_kb" in [process_stats_process] *)

val process_stats_process_set_smr_pss_file_kb : process_stats_process -> int64 -> unit
  (** set field smr_pss_file_kb in process_stats_process *)

val process_stats_process_has_smr_pss_shmem_kb : process_stats_process -> bool
  (** presence of field "smr_pss_shmem_kb" in [process_stats_process] *)

val process_stats_process_set_smr_pss_shmem_kb : process_stats_process -> int64 -> unit
  (** set field smr_pss_shmem_kb in process_stats_process *)

val process_stats_process_has_smr_swap_pss_kb : process_stats_process -> bool
  (** presence of field "smr_swap_pss_kb" in [process_stats_process] *)

val process_stats_process_set_smr_swap_pss_kb : process_stats_process -> int64 -> unit
  (** set field smr_swap_pss_kb in process_stats_process *)

val process_stats_process_has_runtime_user_mode : process_stats_process -> bool
  (** presence of field "runtime_user_mode" in [process_stats_process] *)

val process_stats_process_set_runtime_user_mode : process_stats_process -> int64 -> unit
  (** set field runtime_user_mode in process_stats_process *)

val process_stats_process_has_runtime_kernel_mode : process_stats_process -> bool
  (** presence of field "runtime_kernel_mode" in [process_stats_process] *)

val process_stats_process_set_runtime_kernel_mode : process_stats_process -> int64 -> unit
  (** set field runtime_kernel_mode in process_stats_process *)

val process_stats_process_has_dmabuf_rss_kb : process_stats_process -> bool
  (** presence of field "dmabuf_rss_kb" in [process_stats_process] *)

val process_stats_process_set_dmabuf_rss_kb : process_stats_process -> int64 -> unit
  (** set field dmabuf_rss_kb in process_stats_process *)

val make_process_stats : 
  ?processes:process_stats_process list ->
  ?collection_end_timestamp:int64 ->
  unit ->
  process_stats
(** [make_process_stats … ()] is a builder for type [process_stats] *)

val copy_process_stats : process_stats -> process_stats

val process_stats_set_processes : process_stats -> process_stats_process list -> unit
  (** set field processes in process_stats *)

val process_stats_has_collection_end_timestamp : process_stats -> bool
  (** presence of field "collection_end_timestamp" in [process_stats] *)

val process_stats_set_collection_end_timestamp : process_stats -> int64 -> unit
  (** set field collection_end_timestamp in process_stats *)

val make_process_tree_thread : 
  ?tid:int32 ->
  ?tgid:int32 ->
  ?name:string ->
  ?nstid:int32 list ->
  unit ->
  process_tree_thread
(** [make_process_tree_thread … ()] is a builder for type [process_tree_thread] *)

val copy_process_tree_thread : process_tree_thread -> process_tree_thread

val process_tree_thread_has_tid : process_tree_thread -> bool
  (** presence of field "tid" in [process_tree_thread] *)

val process_tree_thread_set_tid : process_tree_thread -> int32 -> unit
  (** set field tid in process_tree_thread *)

val process_tree_thread_has_tgid : process_tree_thread -> bool
  (** presence of field "tgid" in [process_tree_thread] *)

val process_tree_thread_set_tgid : process_tree_thread -> int32 -> unit
  (** set field tgid in process_tree_thread *)

val process_tree_thread_has_name : process_tree_thread -> bool
  (** presence of field "name" in [process_tree_thread] *)

val process_tree_thread_set_name : process_tree_thread -> string -> unit
  (** set field name in process_tree_thread *)

val process_tree_thread_set_nstid : process_tree_thread -> int32 list -> unit
  (** set field nstid in process_tree_thread *)

val make_process_tree_process : 
  ?pid:int32 ->
  ?ppid:int32 ->
  ?cmdline:string list ->
  ?cmdline_is_comm:bool ->
  ?uid:int32 ->
  ?nspid:int32 list ->
  ?process_start_from_boot:int64 ->
  ?is_kthread:bool ->
  unit ->
  process_tree_process
(** [make_process_tree_process … ()] is a builder for type [process_tree_process] *)

val copy_process_tree_process : process_tree_process -> process_tree_process

val process_tree_process_has_pid : process_tree_process -> bool
  (** presence of field "pid" in [process_tree_process] *)

val process_tree_process_set_pid : process_tree_process -> int32 -> unit
  (** set field pid in process_tree_process *)

val process_tree_process_has_ppid : process_tree_process -> bool
  (** presence of field "ppid" in [process_tree_process] *)

val process_tree_process_set_ppid : process_tree_process -> int32 -> unit
  (** set field ppid in process_tree_process *)

val process_tree_process_set_cmdline : process_tree_process -> string list -> unit
  (** set field cmdline in process_tree_process *)

val process_tree_process_has_cmdline_is_comm : process_tree_process -> bool
  (** presence of field "cmdline_is_comm" in [process_tree_process] *)

val process_tree_process_set_cmdline_is_comm : process_tree_process -> bool -> unit
  (** set field cmdline_is_comm in process_tree_process *)

val process_tree_process_has_uid : process_tree_process -> bool
  (** presence of field "uid" in [process_tree_process] *)

val process_tree_process_set_uid : process_tree_process -> int32 -> unit
  (** set field uid in process_tree_process *)

val process_tree_process_set_nspid : process_tree_process -> int32 list -> unit
  (** set field nspid in process_tree_process *)

val process_tree_process_has_process_start_from_boot : process_tree_process -> bool
  (** presence of field "process_start_from_boot" in [process_tree_process] *)

val process_tree_process_set_process_start_from_boot : process_tree_process -> int64 -> unit
  (** set field process_start_from_boot in process_tree_process *)

val process_tree_process_has_is_kthread : process_tree_process -> bool
  (** presence of field "is_kthread" in [process_tree_process] *)

val process_tree_process_set_is_kthread : process_tree_process -> bool -> unit
  (** set field is_kthread in process_tree_process *)

val make_process_tree : 
  ?processes:process_tree_process list ->
  ?threads:process_tree_thread list ->
  ?collection_end_timestamp:int64 ->
  unit ->
  process_tree
(** [make_process_tree … ()] is a builder for type [process_tree] *)

val copy_process_tree : process_tree -> process_tree

val process_tree_set_processes : process_tree -> process_tree_process list -> unit
  (** set field processes in process_tree *)

val process_tree_set_threads : process_tree -> process_tree_thread list -> unit
  (** set field threads in process_tree *)

val process_tree_has_collection_end_timestamp : process_tree -> bool
  (** presence of field "collection_end_timestamp" in [process_tree] *)

val process_tree_set_collection_end_timestamp : process_tree -> int64 -> unit
  (** set field collection_end_timestamp in process_tree *)

val make_remote_clock_sync_synced_clocks : 
  ?client_clocks:clock_snapshot ->
  ?host_clocks:clock_snapshot ->
  unit ->
  remote_clock_sync_synced_clocks
(** [make_remote_clock_sync_synced_clocks … ()] is a builder for type [remote_clock_sync_synced_clocks] *)

val copy_remote_clock_sync_synced_clocks : remote_clock_sync_synced_clocks -> remote_clock_sync_synced_clocks

val remote_clock_sync_synced_clocks_set_client_clocks : remote_clock_sync_synced_clocks -> clock_snapshot -> unit
  (** set field client_clocks in remote_clock_sync_synced_clocks *)

val remote_clock_sync_synced_clocks_set_host_clocks : remote_clock_sync_synced_clocks -> clock_snapshot -> unit
  (** set field host_clocks in remote_clock_sync_synced_clocks *)

val make_remote_clock_sync : 
  ?synced_clocks:remote_clock_sync_synced_clocks list ->
  unit ->
  remote_clock_sync
(** [make_remote_clock_sync … ()] is a builder for type [remote_clock_sync] *)

val copy_remote_clock_sync : remote_clock_sync -> remote_clock_sync

val remote_clock_sync_set_synced_clocks : remote_clock_sync -> remote_clock_sync_synced_clocks list -> unit
  (** set field synced_clocks in remote_clock_sync *)

val make_statsd_atom : 
  ?atom:unit list ->
  ?timestamp_nanos:int64 list ->
  unit ->
  statsd_atom
(** [make_statsd_atom … ()] is a builder for type [statsd_atom] *)

val copy_statsd_atom : statsd_atom -> statsd_atom

val statsd_atom_set_atom : statsd_atom -> unit list -> unit
  (** set field atom in statsd_atom *)

val statsd_atom_set_timestamp_nanos : statsd_atom -> int64 list -> unit
  (** set field timestamp_nanos in statsd_atom *)

val make_sys_stats_meminfo_value : 
  ?key:meminfo_counters ->
  ?value:int64 ->
  unit ->
  sys_stats_meminfo_value
(** [make_sys_stats_meminfo_value … ()] is a builder for type [sys_stats_meminfo_value] *)

val copy_sys_stats_meminfo_value : sys_stats_meminfo_value -> sys_stats_meminfo_value

val sys_stats_meminfo_value_has_key : sys_stats_meminfo_value -> bool
  (** presence of field "key" in [sys_stats_meminfo_value] *)

val sys_stats_meminfo_value_set_key : sys_stats_meminfo_value -> meminfo_counters -> unit
  (** set field key in sys_stats_meminfo_value *)

val sys_stats_meminfo_value_has_value : sys_stats_meminfo_value -> bool
  (** presence of field "value" in [sys_stats_meminfo_value] *)

val sys_stats_meminfo_value_set_value : sys_stats_meminfo_value -> int64 -> unit
  (** set field value in sys_stats_meminfo_value *)

val make_sys_stats_vmstat_value : 
  ?key:vmstat_counters ->
  ?value:int64 ->
  unit ->
  sys_stats_vmstat_value
(** [make_sys_stats_vmstat_value … ()] is a builder for type [sys_stats_vmstat_value] *)

val copy_sys_stats_vmstat_value : sys_stats_vmstat_value -> sys_stats_vmstat_value

val sys_stats_vmstat_value_has_key : sys_stats_vmstat_value -> bool
  (** presence of field "key" in [sys_stats_vmstat_value] *)

val sys_stats_vmstat_value_set_key : sys_stats_vmstat_value -> vmstat_counters -> unit
  (** set field key in sys_stats_vmstat_value *)

val sys_stats_vmstat_value_has_value : sys_stats_vmstat_value -> bool
  (** presence of field "value" in [sys_stats_vmstat_value] *)

val sys_stats_vmstat_value_set_value : sys_stats_vmstat_value -> int64 -> unit
  (** set field value in sys_stats_vmstat_value *)

val make_sys_stats_cpu_times : 
  ?cpu_id:int32 ->
  ?user_ns:int64 ->
  ?user_nice_ns:int64 ->
  ?system_mode_ns:int64 ->
  ?idle_ns:int64 ->
  ?io_wait_ns:int64 ->
  ?irq_ns:int64 ->
  ?softirq_ns:int64 ->
  ?steal_ns:int64 ->
  unit ->
  sys_stats_cpu_times
(** [make_sys_stats_cpu_times … ()] is a builder for type [sys_stats_cpu_times] *)

val copy_sys_stats_cpu_times : sys_stats_cpu_times -> sys_stats_cpu_times

val sys_stats_cpu_times_has_cpu_id : sys_stats_cpu_times -> bool
  (** presence of field "cpu_id" in [sys_stats_cpu_times] *)

val sys_stats_cpu_times_set_cpu_id : sys_stats_cpu_times -> int32 -> unit
  (** set field cpu_id in sys_stats_cpu_times *)

val sys_stats_cpu_times_has_user_ns : sys_stats_cpu_times -> bool
  (** presence of field "user_ns" in [sys_stats_cpu_times] *)

val sys_stats_cpu_times_set_user_ns : sys_stats_cpu_times -> int64 -> unit
  (** set field user_ns in sys_stats_cpu_times *)

val sys_stats_cpu_times_has_user_nice_ns : sys_stats_cpu_times -> bool
  (** presence of field "user_nice_ns" in [sys_stats_cpu_times] *)

val sys_stats_cpu_times_set_user_nice_ns : sys_stats_cpu_times -> int64 -> unit
  (** set field user_nice_ns in sys_stats_cpu_times *)

val sys_stats_cpu_times_has_system_mode_ns : sys_stats_cpu_times -> bool
  (** presence of field "system_mode_ns" in [sys_stats_cpu_times] *)

val sys_stats_cpu_times_set_system_mode_ns : sys_stats_cpu_times -> int64 -> unit
  (** set field system_mode_ns in sys_stats_cpu_times *)

val sys_stats_cpu_times_has_idle_ns : sys_stats_cpu_times -> bool
  (** presence of field "idle_ns" in [sys_stats_cpu_times] *)

val sys_stats_cpu_times_set_idle_ns : sys_stats_cpu_times -> int64 -> unit
  (** set field idle_ns in sys_stats_cpu_times *)

val sys_stats_cpu_times_has_io_wait_ns : sys_stats_cpu_times -> bool
  (** presence of field "io_wait_ns" in [sys_stats_cpu_times] *)

val sys_stats_cpu_times_set_io_wait_ns : sys_stats_cpu_times -> int64 -> unit
  (** set field io_wait_ns in sys_stats_cpu_times *)

val sys_stats_cpu_times_has_irq_ns : sys_stats_cpu_times -> bool
  (** presence of field "irq_ns" in [sys_stats_cpu_times] *)

val sys_stats_cpu_times_set_irq_ns : sys_stats_cpu_times -> int64 -> unit
  (** set field irq_ns in sys_stats_cpu_times *)

val sys_stats_cpu_times_has_softirq_ns : sys_stats_cpu_times -> bool
  (** presence of field "softirq_ns" in [sys_stats_cpu_times] *)

val sys_stats_cpu_times_set_softirq_ns : sys_stats_cpu_times -> int64 -> unit
  (** set field softirq_ns in sys_stats_cpu_times *)

val sys_stats_cpu_times_has_steal_ns : sys_stats_cpu_times -> bool
  (** presence of field "steal_ns" in [sys_stats_cpu_times] *)

val sys_stats_cpu_times_set_steal_ns : sys_stats_cpu_times -> int64 -> unit
  (** set field steal_ns in sys_stats_cpu_times *)

val make_sys_stats_interrupt_count : 
  ?irq:int32 ->
  ?count:int64 ->
  unit ->
  sys_stats_interrupt_count
(** [make_sys_stats_interrupt_count … ()] is a builder for type [sys_stats_interrupt_count] *)

val copy_sys_stats_interrupt_count : sys_stats_interrupt_count -> sys_stats_interrupt_count

val sys_stats_interrupt_count_has_irq : sys_stats_interrupt_count -> bool
  (** presence of field "irq" in [sys_stats_interrupt_count] *)

val sys_stats_interrupt_count_set_irq : sys_stats_interrupt_count -> int32 -> unit
  (** set field irq in sys_stats_interrupt_count *)

val sys_stats_interrupt_count_has_count : sys_stats_interrupt_count -> bool
  (** presence of field "count" in [sys_stats_interrupt_count] *)

val sys_stats_interrupt_count_set_count : sys_stats_interrupt_count -> int64 -> unit
  (** set field count in sys_stats_interrupt_count *)

val make_sys_stats_devfreq_value : 
  ?key:string ->
  ?value:int64 ->
  unit ->
  sys_stats_devfreq_value
(** [make_sys_stats_devfreq_value … ()] is a builder for type [sys_stats_devfreq_value] *)

val copy_sys_stats_devfreq_value : sys_stats_devfreq_value -> sys_stats_devfreq_value

val sys_stats_devfreq_value_has_key : sys_stats_devfreq_value -> bool
  (** presence of field "key" in [sys_stats_devfreq_value] *)

val sys_stats_devfreq_value_set_key : sys_stats_devfreq_value -> string -> unit
  (** set field key in sys_stats_devfreq_value *)

val sys_stats_devfreq_value_has_value : sys_stats_devfreq_value -> bool
  (** presence of field "value" in [sys_stats_devfreq_value] *)

val sys_stats_devfreq_value_set_value : sys_stats_devfreq_value -> int64 -> unit
  (** set field value in sys_stats_devfreq_value *)

val make_sys_stats_buddy_info : 
  ?node:string ->
  ?zone:string ->
  ?order_pages:int32 list ->
  unit ->
  sys_stats_buddy_info
(** [make_sys_stats_buddy_info … ()] is a builder for type [sys_stats_buddy_info] *)

val copy_sys_stats_buddy_info : sys_stats_buddy_info -> sys_stats_buddy_info

val sys_stats_buddy_info_has_node : sys_stats_buddy_info -> bool
  (** presence of field "node" in [sys_stats_buddy_info] *)

val sys_stats_buddy_info_set_node : sys_stats_buddy_info -> string -> unit
  (** set field node in sys_stats_buddy_info *)

val sys_stats_buddy_info_has_zone : sys_stats_buddy_info -> bool
  (** presence of field "zone" in [sys_stats_buddy_info] *)

val sys_stats_buddy_info_set_zone : sys_stats_buddy_info -> string -> unit
  (** set field zone in sys_stats_buddy_info *)

val sys_stats_buddy_info_set_order_pages : sys_stats_buddy_info -> int32 list -> unit
  (** set field order_pages in sys_stats_buddy_info *)

val make_sys_stats_disk_stat : 
  ?device_name:string ->
  ?read_sectors:int64 ->
  ?read_time_ms:int64 ->
  ?write_sectors:int64 ->
  ?write_time_ms:int64 ->
  ?discard_sectors:int64 ->
  ?discard_time_ms:int64 ->
  ?flush_count:int64 ->
  ?flush_time_ms:int64 ->
  unit ->
  sys_stats_disk_stat
(** [make_sys_stats_disk_stat … ()] is a builder for type [sys_stats_disk_stat] *)

val copy_sys_stats_disk_stat : sys_stats_disk_stat -> sys_stats_disk_stat

val sys_stats_disk_stat_has_device_name : sys_stats_disk_stat -> bool
  (** presence of field "device_name" in [sys_stats_disk_stat] *)

val sys_stats_disk_stat_set_device_name : sys_stats_disk_stat -> string -> unit
  (** set field device_name in sys_stats_disk_stat *)

val sys_stats_disk_stat_has_read_sectors : sys_stats_disk_stat -> bool
  (** presence of field "read_sectors" in [sys_stats_disk_stat] *)

val sys_stats_disk_stat_set_read_sectors : sys_stats_disk_stat -> int64 -> unit
  (** set field read_sectors in sys_stats_disk_stat *)

val sys_stats_disk_stat_has_read_time_ms : sys_stats_disk_stat -> bool
  (** presence of field "read_time_ms" in [sys_stats_disk_stat] *)

val sys_stats_disk_stat_set_read_time_ms : sys_stats_disk_stat -> int64 -> unit
  (** set field read_time_ms in sys_stats_disk_stat *)

val sys_stats_disk_stat_has_write_sectors : sys_stats_disk_stat -> bool
  (** presence of field "write_sectors" in [sys_stats_disk_stat] *)

val sys_stats_disk_stat_set_write_sectors : sys_stats_disk_stat -> int64 -> unit
  (** set field write_sectors in sys_stats_disk_stat *)

val sys_stats_disk_stat_has_write_time_ms : sys_stats_disk_stat -> bool
  (** presence of field "write_time_ms" in [sys_stats_disk_stat] *)

val sys_stats_disk_stat_set_write_time_ms : sys_stats_disk_stat -> int64 -> unit
  (** set field write_time_ms in sys_stats_disk_stat *)

val sys_stats_disk_stat_has_discard_sectors : sys_stats_disk_stat -> bool
  (** presence of field "discard_sectors" in [sys_stats_disk_stat] *)

val sys_stats_disk_stat_set_discard_sectors : sys_stats_disk_stat -> int64 -> unit
  (** set field discard_sectors in sys_stats_disk_stat *)

val sys_stats_disk_stat_has_discard_time_ms : sys_stats_disk_stat -> bool
  (** presence of field "discard_time_ms" in [sys_stats_disk_stat] *)

val sys_stats_disk_stat_set_discard_time_ms : sys_stats_disk_stat -> int64 -> unit
  (** set field discard_time_ms in sys_stats_disk_stat *)

val sys_stats_disk_stat_has_flush_count : sys_stats_disk_stat -> bool
  (** presence of field "flush_count" in [sys_stats_disk_stat] *)

val sys_stats_disk_stat_set_flush_count : sys_stats_disk_stat -> int64 -> unit
  (** set field flush_count in sys_stats_disk_stat *)

val sys_stats_disk_stat_has_flush_time_ms : sys_stats_disk_stat -> bool
  (** presence of field "flush_time_ms" in [sys_stats_disk_stat] *)

val sys_stats_disk_stat_set_flush_time_ms : sys_stats_disk_stat -> int64 -> unit
  (** set field flush_time_ms in sys_stats_disk_stat *)

val make_sys_stats_psi_sample : 
  ?resource:sys_stats_psi_sample_psi_resource ->
  ?total_ns:int64 ->
  unit ->
  sys_stats_psi_sample
(** [make_sys_stats_psi_sample … ()] is a builder for type [sys_stats_psi_sample] *)

val copy_sys_stats_psi_sample : sys_stats_psi_sample -> sys_stats_psi_sample

val sys_stats_psi_sample_has_resource : sys_stats_psi_sample -> bool
  (** presence of field "resource" in [sys_stats_psi_sample] *)

val sys_stats_psi_sample_set_resource : sys_stats_psi_sample -> sys_stats_psi_sample_psi_resource -> unit
  (** set field resource in sys_stats_psi_sample *)

val sys_stats_psi_sample_has_total_ns : sys_stats_psi_sample -> bool
  (** presence of field "total_ns" in [sys_stats_psi_sample] *)

val sys_stats_psi_sample_set_total_ns : sys_stats_psi_sample -> int64 -> unit
  (** set field total_ns in sys_stats_psi_sample *)

val make_sys_stats_thermal_zone : 
  ?name:string ->
  ?temp:int64 ->
  ?type_:string ->
  unit ->
  sys_stats_thermal_zone
(** [make_sys_stats_thermal_zone … ()] is a builder for type [sys_stats_thermal_zone] *)

val copy_sys_stats_thermal_zone : sys_stats_thermal_zone -> sys_stats_thermal_zone

val sys_stats_thermal_zone_has_name : sys_stats_thermal_zone -> bool
  (** presence of field "name" in [sys_stats_thermal_zone] *)

val sys_stats_thermal_zone_set_name : sys_stats_thermal_zone -> string -> unit
  (** set field name in sys_stats_thermal_zone *)

val sys_stats_thermal_zone_has_temp : sys_stats_thermal_zone -> bool
  (** presence of field "temp" in [sys_stats_thermal_zone] *)

val sys_stats_thermal_zone_set_temp : sys_stats_thermal_zone -> int64 -> unit
  (** set field temp in sys_stats_thermal_zone *)

val sys_stats_thermal_zone_has_type_ : sys_stats_thermal_zone -> bool
  (** presence of field "type_" in [sys_stats_thermal_zone] *)

val sys_stats_thermal_zone_set_type_ : sys_stats_thermal_zone -> string -> unit
  (** set field type_ in sys_stats_thermal_zone *)

val make_sys_stats_cpu_idle_state_entry : 
  ?state:string ->
  ?duration_us:int64 ->
  unit ->
  sys_stats_cpu_idle_state_entry
(** [make_sys_stats_cpu_idle_state_entry … ()] is a builder for type [sys_stats_cpu_idle_state_entry] *)

val copy_sys_stats_cpu_idle_state_entry : sys_stats_cpu_idle_state_entry -> sys_stats_cpu_idle_state_entry

val sys_stats_cpu_idle_state_entry_has_state : sys_stats_cpu_idle_state_entry -> bool
  (** presence of field "state" in [sys_stats_cpu_idle_state_entry] *)

val sys_stats_cpu_idle_state_entry_set_state : sys_stats_cpu_idle_state_entry -> string -> unit
  (** set field state in sys_stats_cpu_idle_state_entry *)

val sys_stats_cpu_idle_state_entry_has_duration_us : sys_stats_cpu_idle_state_entry -> bool
  (** presence of field "duration_us" in [sys_stats_cpu_idle_state_entry] *)

val sys_stats_cpu_idle_state_entry_set_duration_us : sys_stats_cpu_idle_state_entry -> int64 -> unit
  (** set field duration_us in sys_stats_cpu_idle_state_entry *)

val make_sys_stats_cpu_idle_state : 
  ?cpu_id:int32 ->
  ?cpuidle_state_entry:sys_stats_cpu_idle_state_entry list ->
  unit ->
  sys_stats_cpu_idle_state
(** [make_sys_stats_cpu_idle_state … ()] is a builder for type [sys_stats_cpu_idle_state] *)

val copy_sys_stats_cpu_idle_state : sys_stats_cpu_idle_state -> sys_stats_cpu_idle_state

val sys_stats_cpu_idle_state_has_cpu_id : sys_stats_cpu_idle_state -> bool
  (** presence of field "cpu_id" in [sys_stats_cpu_idle_state] *)

val sys_stats_cpu_idle_state_set_cpu_id : sys_stats_cpu_idle_state -> int32 -> unit
  (** set field cpu_id in sys_stats_cpu_idle_state *)

val sys_stats_cpu_idle_state_set_cpuidle_state_entry : sys_stats_cpu_idle_state -> sys_stats_cpu_idle_state_entry list -> unit
  (** set field cpuidle_state_entry in sys_stats_cpu_idle_state *)

val make_sys_stats : 
  ?meminfo:sys_stats_meminfo_value list ->
  ?vmstat:sys_stats_vmstat_value list ->
  ?cpu_stat:sys_stats_cpu_times list ->
  ?num_forks:int64 ->
  ?num_irq_total:int64 ->
  ?num_irq:sys_stats_interrupt_count list ->
  ?num_softirq_total:int64 ->
  ?num_softirq:sys_stats_interrupt_count list ->
  ?collection_end_timestamp:int64 ->
  ?devfreq:sys_stats_devfreq_value list ->
  ?cpufreq_khz:int32 list ->
  ?buddy_info:sys_stats_buddy_info list ->
  ?disk_stat:sys_stats_disk_stat list ->
  ?psi:sys_stats_psi_sample list ->
  ?thermal_zone:sys_stats_thermal_zone list ->
  ?cpuidle_state:sys_stats_cpu_idle_state list ->
  ?gpufreq_mhz:int64 list ->
  unit ->
  sys_stats
(** [make_sys_stats … ()] is a builder for type [sys_stats] *)

val copy_sys_stats : sys_stats -> sys_stats

val sys_stats_set_meminfo : sys_stats -> sys_stats_meminfo_value list -> unit
  (** set field meminfo in sys_stats *)

val sys_stats_set_vmstat : sys_stats -> sys_stats_vmstat_value list -> unit
  (** set field vmstat in sys_stats *)

val sys_stats_set_cpu_stat : sys_stats -> sys_stats_cpu_times list -> unit
  (** set field cpu_stat in sys_stats *)

val sys_stats_has_num_forks : sys_stats -> bool
  (** presence of field "num_forks" in [sys_stats] *)

val sys_stats_set_num_forks : sys_stats -> int64 -> unit
  (** set field num_forks in sys_stats *)

val sys_stats_has_num_irq_total : sys_stats -> bool
  (** presence of field "num_irq_total" in [sys_stats] *)

val sys_stats_set_num_irq_total : sys_stats -> int64 -> unit
  (** set field num_irq_total in sys_stats *)

val sys_stats_set_num_irq : sys_stats -> sys_stats_interrupt_count list -> unit
  (** set field num_irq in sys_stats *)

val sys_stats_has_num_softirq_total : sys_stats -> bool
  (** presence of field "num_softirq_total" in [sys_stats] *)

val sys_stats_set_num_softirq_total : sys_stats -> int64 -> unit
  (** set field num_softirq_total in sys_stats *)

val sys_stats_set_num_softirq : sys_stats -> sys_stats_interrupt_count list -> unit
  (** set field num_softirq in sys_stats *)

val sys_stats_has_collection_end_timestamp : sys_stats -> bool
  (** presence of field "collection_end_timestamp" in [sys_stats] *)

val sys_stats_set_collection_end_timestamp : sys_stats -> int64 -> unit
  (** set field collection_end_timestamp in sys_stats *)

val sys_stats_set_devfreq : sys_stats -> sys_stats_devfreq_value list -> unit
  (** set field devfreq in sys_stats *)

val sys_stats_set_cpufreq_khz : sys_stats -> int32 list -> unit
  (** set field cpufreq_khz in sys_stats *)

val sys_stats_set_buddy_info : sys_stats -> sys_stats_buddy_info list -> unit
  (** set field buddy_info in sys_stats *)

val sys_stats_set_disk_stat : sys_stats -> sys_stats_disk_stat list -> unit
  (** set field disk_stat in sys_stats *)

val sys_stats_set_psi : sys_stats -> sys_stats_psi_sample list -> unit
  (** set field psi in sys_stats *)

val sys_stats_set_thermal_zone : sys_stats -> sys_stats_thermal_zone list -> unit
  (** set field thermal_zone in sys_stats *)

val sys_stats_set_cpuidle_state : sys_stats -> sys_stats_cpu_idle_state list -> unit
  (** set field cpuidle_state in sys_stats *)

val sys_stats_set_gpufreq_mhz : sys_stats -> int64 list -> unit
  (** set field gpufreq_mhz in sys_stats *)

val make_cpu_info_arm_cpu_identifier : 
  ?implementer:int32 ->
  ?architecture:int32 ->
  ?variant:int32 ->
  ?part:int32 ->
  ?revision:int32 ->
  unit ->
  cpu_info_arm_cpu_identifier
(** [make_cpu_info_arm_cpu_identifier … ()] is a builder for type [cpu_info_arm_cpu_identifier] *)

val copy_cpu_info_arm_cpu_identifier : cpu_info_arm_cpu_identifier -> cpu_info_arm_cpu_identifier

val cpu_info_arm_cpu_identifier_has_implementer : cpu_info_arm_cpu_identifier -> bool
  (** presence of field "implementer" in [cpu_info_arm_cpu_identifier] *)

val cpu_info_arm_cpu_identifier_set_implementer : cpu_info_arm_cpu_identifier -> int32 -> unit
  (** set field implementer in cpu_info_arm_cpu_identifier *)

val cpu_info_arm_cpu_identifier_has_architecture : cpu_info_arm_cpu_identifier -> bool
  (** presence of field "architecture" in [cpu_info_arm_cpu_identifier] *)

val cpu_info_arm_cpu_identifier_set_architecture : cpu_info_arm_cpu_identifier -> int32 -> unit
  (** set field architecture in cpu_info_arm_cpu_identifier *)

val cpu_info_arm_cpu_identifier_has_variant : cpu_info_arm_cpu_identifier -> bool
  (** presence of field "variant" in [cpu_info_arm_cpu_identifier] *)

val cpu_info_arm_cpu_identifier_set_variant : cpu_info_arm_cpu_identifier -> int32 -> unit
  (** set field variant in cpu_info_arm_cpu_identifier *)

val cpu_info_arm_cpu_identifier_has_part : cpu_info_arm_cpu_identifier -> bool
  (** presence of field "part" in [cpu_info_arm_cpu_identifier] *)

val cpu_info_arm_cpu_identifier_set_part : cpu_info_arm_cpu_identifier -> int32 -> unit
  (** set field part in cpu_info_arm_cpu_identifier *)

val cpu_info_arm_cpu_identifier_has_revision : cpu_info_arm_cpu_identifier -> bool
  (** presence of field "revision" in [cpu_info_arm_cpu_identifier] *)

val cpu_info_arm_cpu_identifier_set_revision : cpu_info_arm_cpu_identifier -> int32 -> unit
  (** set field revision in cpu_info_arm_cpu_identifier *)

val make_cpu_info_cpu : 
  ?processor:string ->
  ?frequencies:int32 list ->
  ?capacity:int32 ->
  ?identifier:cpu_info_cpu_identifier ->
  ?features:int64 ->
  unit ->
  cpu_info_cpu
(** [make_cpu_info_cpu … ()] is a builder for type [cpu_info_cpu] *)

val copy_cpu_info_cpu : cpu_info_cpu -> cpu_info_cpu

val cpu_info_cpu_has_processor : cpu_info_cpu -> bool
  (** presence of field "processor" in [cpu_info_cpu] *)

val cpu_info_cpu_set_processor : cpu_info_cpu -> string -> unit
  (** set field processor in cpu_info_cpu *)

val cpu_info_cpu_set_frequencies : cpu_info_cpu -> int32 list -> unit
  (** set field frequencies in cpu_info_cpu *)

val cpu_info_cpu_has_capacity : cpu_info_cpu -> bool
  (** presence of field "capacity" in [cpu_info_cpu] *)

val cpu_info_cpu_set_capacity : cpu_info_cpu -> int32 -> unit
  (** set field capacity in cpu_info_cpu *)

val cpu_info_cpu_set_identifier : cpu_info_cpu -> cpu_info_cpu_identifier -> unit
  (** set field identifier in cpu_info_cpu *)

val cpu_info_cpu_has_features : cpu_info_cpu -> bool
  (** presence of field "features" in [cpu_info_cpu] *)

val cpu_info_cpu_set_features : cpu_info_cpu -> int64 -> unit
  (** set field features in cpu_info_cpu *)

val make_cpu_info : 
  ?cpus:cpu_info_cpu list ->
  unit ->
  cpu_info
(** [make_cpu_info … ()] is a builder for type [cpu_info] *)

val copy_cpu_info : cpu_info -> cpu_info

val cpu_info_set_cpus : cpu_info -> cpu_info_cpu list -> unit
  (** set field cpus in cpu_info *)

val make_test_event_test_payload : 
  ?str:string list ->
  ?nested:test_event_test_payload list ->
  ?single_string:string ->
  ?single_int:int32 ->
  ?repeated_ints:int32 list ->
  ?remaining_nesting_depth:int32 ->
  ?debug_annotations:debug_annotation list ->
  unit ->
  test_event_test_payload
(** [make_test_event_test_payload … ()] is a builder for type [test_event_test_payload] *)

val copy_test_event_test_payload : test_event_test_payload -> test_event_test_payload

val test_event_test_payload_set_str : test_event_test_payload -> string list -> unit
  (** set field str in test_event_test_payload *)

val test_event_test_payload_set_nested : test_event_test_payload -> test_event_test_payload list -> unit
  (** set field nested in test_event_test_payload *)

val test_event_test_payload_has_single_string : test_event_test_payload -> bool
  (** presence of field "single_string" in [test_event_test_payload] *)

val test_event_test_payload_set_single_string : test_event_test_payload -> string -> unit
  (** set field single_string in test_event_test_payload *)

val test_event_test_payload_has_single_int : test_event_test_payload -> bool
  (** presence of field "single_int" in [test_event_test_payload] *)

val test_event_test_payload_set_single_int : test_event_test_payload -> int32 -> unit
  (** set field single_int in test_event_test_payload *)

val test_event_test_payload_set_repeated_ints : test_event_test_payload -> int32 list -> unit
  (** set field repeated_ints in test_event_test_payload *)

val test_event_test_payload_has_remaining_nesting_depth : test_event_test_payload -> bool
  (** presence of field "remaining_nesting_depth" in [test_event_test_payload] *)

val test_event_test_payload_set_remaining_nesting_depth : test_event_test_payload -> int32 -> unit
  (** set field remaining_nesting_depth in test_event_test_payload *)

val test_event_test_payload_set_debug_annotations : test_event_test_payload -> debug_annotation list -> unit
  (** set field debug_annotations in test_event_test_payload *)

val make_test_event : 
  ?str:string ->
  ?seq_value:int32 ->
  ?counter:int64 ->
  ?is_last:bool ->
  ?payload:test_event_test_payload ->
  unit ->
  test_event
(** [make_test_event … ()] is a builder for type [test_event] *)

val copy_test_event : test_event -> test_event

val test_event_has_str : test_event -> bool
  (** presence of field "str" in [test_event] *)

val test_event_set_str : test_event -> string -> unit
  (** set field str in test_event *)

val test_event_has_seq_value : test_event -> bool
  (** presence of field "seq_value" in [test_event] *)

val test_event_set_seq_value : test_event -> int32 -> unit
  (** set field seq_value in test_event *)

val test_event_has_counter : test_event -> bool
  (** presence of field "counter" in [test_event] *)

val test_event_set_counter : test_event -> int64 -> unit
  (** set field counter in test_event *)

val test_event_has_is_last : test_event -> bool
  (** presence of field "is_last" in [test_event] *)

val test_event_set_is_last : test_event -> bool -> unit
  (** set field is_last in test_event *)

val test_event_set_payload : test_event -> test_event_test_payload -> unit
  (** set field payload in test_event *)

val make_trace_packet_defaults : 
  ?timestamp_clock_id:int32 ->
  ?track_event_defaults:track_event_defaults ->
  ?v8_code_defaults:v8_code_defaults ->
  unit ->
  trace_packet_defaults
(** [make_trace_packet_defaults … ()] is a builder for type [trace_packet_defaults] *)

val copy_trace_packet_defaults : trace_packet_defaults -> trace_packet_defaults

val trace_packet_defaults_has_timestamp_clock_id : trace_packet_defaults -> bool
  (** presence of field "timestamp_clock_id" in [trace_packet_defaults] *)

val trace_packet_defaults_set_timestamp_clock_id : trace_packet_defaults -> int32 -> unit
  (** set field timestamp_clock_id in trace_packet_defaults *)

val trace_packet_defaults_set_track_event_defaults : trace_packet_defaults -> track_event_defaults -> unit
  (** set field track_event_defaults in trace_packet_defaults *)

val trace_packet_defaults_set_v8_code_defaults : trace_packet_defaults -> v8_code_defaults -> unit
  (** set field v8_code_defaults in trace_packet_defaults *)

val make_trace_uuid : 
  ?msb:int64 ->
  ?lsb:int64 ->
  unit ->
  trace_uuid
(** [make_trace_uuid … ()] is a builder for type [trace_uuid] *)

val copy_trace_uuid : trace_uuid -> trace_uuid

val trace_uuid_has_msb : trace_uuid -> bool
  (** presence of field "msb" in [trace_uuid] *)

val trace_uuid_set_msb : trace_uuid -> int64 -> unit
  (** set field msb in trace_uuid *)

val trace_uuid_has_lsb : trace_uuid -> bool
  (** presence of field "lsb" in [trace_uuid] *)

val trace_uuid_set_lsb : trace_uuid -> int64 -> unit
  (** set field lsb in trace_uuid *)

val make_process_descriptor : 
  ?pid:int32 ->
  ?cmdline:string list ->
  ?process_name:string ->
  ?process_priority:int32 ->
  ?start_timestamp_ns:int64 ->
  ?chrome_process_type:process_descriptor_chrome_process_type ->
  ?legacy_sort_index:int32 ->
  ?process_labels:string list ->
  unit ->
  process_descriptor
(** [make_process_descriptor … ()] is a builder for type [process_descriptor] *)

val copy_process_descriptor : process_descriptor -> process_descriptor

val process_descriptor_has_pid : process_descriptor -> bool
  (** presence of field "pid" in [process_descriptor] *)

val process_descriptor_set_pid : process_descriptor -> int32 -> unit
  (** set field pid in process_descriptor *)

val process_descriptor_set_cmdline : process_descriptor -> string list -> unit
  (** set field cmdline in process_descriptor *)

val process_descriptor_has_process_name : process_descriptor -> bool
  (** presence of field "process_name" in [process_descriptor] *)

val process_descriptor_set_process_name : process_descriptor -> string -> unit
  (** set field process_name in process_descriptor *)

val process_descriptor_has_process_priority : process_descriptor -> bool
  (** presence of field "process_priority" in [process_descriptor] *)

val process_descriptor_set_process_priority : process_descriptor -> int32 -> unit
  (** set field process_priority in process_descriptor *)

val process_descriptor_has_start_timestamp_ns : process_descriptor -> bool
  (** presence of field "start_timestamp_ns" in [process_descriptor] *)

val process_descriptor_set_start_timestamp_ns : process_descriptor -> int64 -> unit
  (** set field start_timestamp_ns in process_descriptor *)

val process_descriptor_has_chrome_process_type : process_descriptor -> bool
  (** presence of field "chrome_process_type" in [process_descriptor] *)

val process_descriptor_set_chrome_process_type : process_descriptor -> process_descriptor_chrome_process_type -> unit
  (** set field chrome_process_type in process_descriptor *)

val process_descriptor_has_legacy_sort_index : process_descriptor -> bool
  (** presence of field "legacy_sort_index" in [process_descriptor] *)

val process_descriptor_set_legacy_sort_index : process_descriptor -> int32 -> unit
  (** set field legacy_sort_index in process_descriptor *)

val process_descriptor_set_process_labels : process_descriptor -> string list -> unit
  (** set field process_labels in process_descriptor *)

val make_track_event_range_of_interest : 
  ?start_us:int64 ->
  unit ->
  track_event_range_of_interest
(** [make_track_event_range_of_interest … ()] is a builder for type [track_event_range_of_interest] *)

val copy_track_event_range_of_interest : track_event_range_of_interest -> track_event_range_of_interest

val track_event_range_of_interest_has_start_us : track_event_range_of_interest -> bool
  (** presence of field "start_us" in [track_event_range_of_interest] *)

val track_event_range_of_interest_set_start_us : track_event_range_of_interest -> int64 -> unit
  (** set field start_us in track_event_range_of_interest *)

val make_thread_descriptor : 
  ?pid:int32 ->
  ?tid:int32 ->
  ?thread_name:string ->
  ?chrome_thread_type:thread_descriptor_chrome_thread_type ->
  ?reference_timestamp_us:int64 ->
  ?reference_thread_time_us:int64 ->
  ?reference_thread_instruction_count:int64 ->
  ?legacy_sort_index:int32 ->
  unit ->
  thread_descriptor
(** [make_thread_descriptor … ()] is a builder for type [thread_descriptor] *)

val copy_thread_descriptor : thread_descriptor -> thread_descriptor

val thread_descriptor_has_pid : thread_descriptor -> bool
  (** presence of field "pid" in [thread_descriptor] *)

val thread_descriptor_set_pid : thread_descriptor -> int32 -> unit
  (** set field pid in thread_descriptor *)

val thread_descriptor_has_tid : thread_descriptor -> bool
  (** presence of field "tid" in [thread_descriptor] *)

val thread_descriptor_set_tid : thread_descriptor -> int32 -> unit
  (** set field tid in thread_descriptor *)

val thread_descriptor_has_thread_name : thread_descriptor -> bool
  (** presence of field "thread_name" in [thread_descriptor] *)

val thread_descriptor_set_thread_name : thread_descriptor -> string -> unit
  (** set field thread_name in thread_descriptor *)

val thread_descriptor_has_chrome_thread_type : thread_descriptor -> bool
  (** presence of field "chrome_thread_type" in [thread_descriptor] *)

val thread_descriptor_set_chrome_thread_type : thread_descriptor -> thread_descriptor_chrome_thread_type -> unit
  (** set field chrome_thread_type in thread_descriptor *)

val thread_descriptor_has_reference_timestamp_us : thread_descriptor -> bool
  (** presence of field "reference_timestamp_us" in [thread_descriptor] *)

val thread_descriptor_set_reference_timestamp_us : thread_descriptor -> int64 -> unit
  (** set field reference_timestamp_us in thread_descriptor *)

val thread_descriptor_has_reference_thread_time_us : thread_descriptor -> bool
  (** presence of field "reference_thread_time_us" in [thread_descriptor] *)

val thread_descriptor_set_reference_thread_time_us : thread_descriptor -> int64 -> unit
  (** set field reference_thread_time_us in thread_descriptor *)

val thread_descriptor_has_reference_thread_instruction_count : thread_descriptor -> bool
  (** presence of field "reference_thread_instruction_count" in [thread_descriptor] *)

val thread_descriptor_set_reference_thread_instruction_count : thread_descriptor -> int64 -> unit
  (** set field reference_thread_instruction_count in thread_descriptor *)

val thread_descriptor_has_legacy_sort_index : thread_descriptor -> bool
  (** presence of field "legacy_sort_index" in [thread_descriptor] *)

val thread_descriptor_set_legacy_sort_index : thread_descriptor -> int32 -> unit
  (** set field legacy_sort_index in thread_descriptor *)

val make_chrome_process_descriptor : 
  ?process_type:int32 ->
  ?process_priority:int32 ->
  ?legacy_sort_index:int32 ->
  ?host_app_package_name:string ->
  ?crash_trace_id:int64 ->
  unit ->
  chrome_process_descriptor
(** [make_chrome_process_descriptor … ()] is a builder for type [chrome_process_descriptor] *)

val copy_chrome_process_descriptor : chrome_process_descriptor -> chrome_process_descriptor

val chrome_process_descriptor_has_process_type : chrome_process_descriptor -> bool
  (** presence of field "process_type" in [chrome_process_descriptor] *)

val chrome_process_descriptor_set_process_type : chrome_process_descriptor -> int32 -> unit
  (** set field process_type in chrome_process_descriptor *)

val chrome_process_descriptor_has_process_priority : chrome_process_descriptor -> bool
  (** presence of field "process_priority" in [chrome_process_descriptor] *)

val chrome_process_descriptor_set_process_priority : chrome_process_descriptor -> int32 -> unit
  (** set field process_priority in chrome_process_descriptor *)

val chrome_process_descriptor_has_legacy_sort_index : chrome_process_descriptor -> bool
  (** presence of field "legacy_sort_index" in [chrome_process_descriptor] *)

val chrome_process_descriptor_set_legacy_sort_index : chrome_process_descriptor -> int32 -> unit
  (** set field legacy_sort_index in chrome_process_descriptor *)

val chrome_process_descriptor_has_host_app_package_name : chrome_process_descriptor -> bool
  (** presence of field "host_app_package_name" in [chrome_process_descriptor] *)

val chrome_process_descriptor_set_host_app_package_name : chrome_process_descriptor -> string -> unit
  (** set field host_app_package_name in chrome_process_descriptor *)

val chrome_process_descriptor_has_crash_trace_id : chrome_process_descriptor -> bool
  (** presence of field "crash_trace_id" in [chrome_process_descriptor] *)

val chrome_process_descriptor_set_crash_trace_id : chrome_process_descriptor -> int64 -> unit
  (** set field crash_trace_id in chrome_process_descriptor *)

val make_chrome_thread_descriptor : 
  ?thread_type:int32 ->
  ?legacy_sort_index:int32 ->
  ?is_sandboxed_tid:bool ->
  unit ->
  chrome_thread_descriptor
(** [make_chrome_thread_descriptor … ()] is a builder for type [chrome_thread_descriptor] *)

val copy_chrome_thread_descriptor : chrome_thread_descriptor -> chrome_thread_descriptor

val chrome_thread_descriptor_has_thread_type : chrome_thread_descriptor -> bool
  (** presence of field "thread_type" in [chrome_thread_descriptor] *)

val chrome_thread_descriptor_set_thread_type : chrome_thread_descriptor -> int32 -> unit
  (** set field thread_type in chrome_thread_descriptor *)

val chrome_thread_descriptor_has_legacy_sort_index : chrome_thread_descriptor -> bool
  (** presence of field "legacy_sort_index" in [chrome_thread_descriptor] *)

val chrome_thread_descriptor_set_legacy_sort_index : chrome_thread_descriptor -> int32 -> unit
  (** set field legacy_sort_index in chrome_thread_descriptor *)

val chrome_thread_descriptor_has_is_sandboxed_tid : chrome_thread_descriptor -> bool
  (** presence of field "is_sandboxed_tid" in [chrome_thread_descriptor] *)

val chrome_thread_descriptor_set_is_sandboxed_tid : chrome_thread_descriptor -> bool -> unit
  (** set field is_sandboxed_tid in chrome_thread_descriptor *)

val make_counter_descriptor : 
  ?type_:counter_descriptor_builtin_counter_type ->
  ?categories:string list ->
  ?unit_:counter_descriptor_unit ->
  ?unit_name:string ->
  ?unit_multiplier:int64 ->
  ?is_incremental:bool ->
  ?y_axis_share_key:string ->
  unit ->
  counter_descriptor
(** [make_counter_descriptor … ()] is a builder for type [counter_descriptor] *)

val copy_counter_descriptor : counter_descriptor -> counter_descriptor

val counter_descriptor_has_type_ : counter_descriptor -> bool
  (** presence of field "type_" in [counter_descriptor] *)

val counter_descriptor_set_type_ : counter_descriptor -> counter_descriptor_builtin_counter_type -> unit
  (** set field type_ in counter_descriptor *)

val counter_descriptor_set_categories : counter_descriptor -> string list -> unit
  (** set field categories in counter_descriptor *)

val counter_descriptor_has_unit_ : counter_descriptor -> bool
  (** presence of field "unit_" in [counter_descriptor] *)

val counter_descriptor_set_unit_ : counter_descriptor -> counter_descriptor_unit -> unit
  (** set field unit_ in counter_descriptor *)

val counter_descriptor_has_unit_name : counter_descriptor -> bool
  (** presence of field "unit_name" in [counter_descriptor] *)

val counter_descriptor_set_unit_name : counter_descriptor -> string -> unit
  (** set field unit_name in counter_descriptor *)

val counter_descriptor_has_unit_multiplier : counter_descriptor -> bool
  (** presence of field "unit_multiplier" in [counter_descriptor] *)

val counter_descriptor_set_unit_multiplier : counter_descriptor -> int64 -> unit
  (** set field unit_multiplier in counter_descriptor *)

val counter_descriptor_has_is_incremental : counter_descriptor -> bool
  (** presence of field "is_incremental" in [counter_descriptor] *)

val counter_descriptor_set_is_incremental : counter_descriptor -> bool -> unit
  (** set field is_incremental in counter_descriptor *)

val counter_descriptor_has_y_axis_share_key : counter_descriptor -> bool
  (** presence of field "y_axis_share_key" in [counter_descriptor] *)

val counter_descriptor_set_y_axis_share_key : counter_descriptor -> string -> unit
  (** set field y_axis_share_key in counter_descriptor *)

val make_track_descriptor : 
  ?uuid:int64 ->
  ?parent_uuid:int64 ->
  ?static_or_dynamic_name:track_descriptor_static_or_dynamic_name ->
  ?description:string ->
  ?process:process_descriptor ->
  ?chrome_process:chrome_process_descriptor ->
  ?thread:thread_descriptor ->
  ?chrome_thread:chrome_thread_descriptor ->
  ?counter:counter_descriptor ->
  ?disallow_merging_with_system_tracks:bool ->
  ?child_ordering:track_descriptor_child_tracks_ordering ->
  ?sibling_order_rank:int32 ->
  ?sibling_merge_behavior:track_descriptor_sibling_merge_behavior ->
  ?sibling_merge_key_field:track_descriptor_sibling_merge_key_field ->
  unit ->
  track_descriptor
(** [make_track_descriptor … ()] is a builder for type [track_descriptor] *)

val copy_track_descriptor : track_descriptor -> track_descriptor

val track_descriptor_has_uuid : track_descriptor -> bool
  (** presence of field "uuid" in [track_descriptor] *)

val track_descriptor_set_uuid : track_descriptor -> int64 -> unit
  (** set field uuid in track_descriptor *)

val track_descriptor_has_parent_uuid : track_descriptor -> bool
  (** presence of field "parent_uuid" in [track_descriptor] *)

val track_descriptor_set_parent_uuid : track_descriptor -> int64 -> unit
  (** set field parent_uuid in track_descriptor *)

val track_descriptor_set_static_or_dynamic_name : track_descriptor -> track_descriptor_static_or_dynamic_name -> unit
  (** set field static_or_dynamic_name in track_descriptor *)

val track_descriptor_has_description : track_descriptor -> bool
  (** presence of field "description" in [track_descriptor] *)

val track_descriptor_set_description : track_descriptor -> string -> unit
  (** set field description in track_descriptor *)

val track_descriptor_set_process : track_descriptor -> process_descriptor -> unit
  (** set field process in track_descriptor *)

val track_descriptor_set_chrome_process : track_descriptor -> chrome_process_descriptor -> unit
  (** set field chrome_process in track_descriptor *)

val track_descriptor_set_thread : track_descriptor -> thread_descriptor -> unit
  (** set field thread in track_descriptor *)

val track_descriptor_set_chrome_thread : track_descriptor -> chrome_thread_descriptor -> unit
  (** set field chrome_thread in track_descriptor *)

val track_descriptor_set_counter : track_descriptor -> counter_descriptor -> unit
  (** set field counter in track_descriptor *)

val track_descriptor_has_disallow_merging_with_system_tracks : track_descriptor -> bool
  (** presence of field "disallow_merging_with_system_tracks" in [track_descriptor] *)

val track_descriptor_set_disallow_merging_with_system_tracks : track_descriptor -> bool -> unit
  (** set field disallow_merging_with_system_tracks in track_descriptor *)

val track_descriptor_has_child_ordering : track_descriptor -> bool
  (** presence of field "child_ordering" in [track_descriptor] *)

val track_descriptor_set_child_ordering : track_descriptor -> track_descriptor_child_tracks_ordering -> unit
  (** set field child_ordering in track_descriptor *)

val track_descriptor_has_sibling_order_rank : track_descriptor -> bool
  (** presence of field "sibling_order_rank" in [track_descriptor] *)

val track_descriptor_set_sibling_order_rank : track_descriptor -> int32 -> unit
  (** set field sibling_order_rank in track_descriptor *)

val track_descriptor_has_sibling_merge_behavior : track_descriptor -> bool
  (** presence of field "sibling_merge_behavior" in [track_descriptor] *)

val track_descriptor_set_sibling_merge_behavior : track_descriptor -> track_descriptor_sibling_merge_behavior -> unit
  (** set field sibling_merge_behavior in track_descriptor *)

val track_descriptor_set_sibling_merge_key_field : track_descriptor -> track_descriptor_sibling_merge_key_field -> unit
  (** set field sibling_merge_key_field in track_descriptor *)

val make_chrome_historgram_translation_table : 
  ?hash_to_name:(int64 * string) list ->
  unit ->
  chrome_historgram_translation_table
(** [make_chrome_historgram_translation_table … ()] is a builder for type [chrome_historgram_translation_table] *)

val copy_chrome_historgram_translation_table : chrome_historgram_translation_table -> chrome_historgram_translation_table

val chrome_historgram_translation_table_set_hash_to_name : chrome_historgram_translation_table -> (int64 * string) list -> unit
  (** set field hash_to_name in chrome_historgram_translation_table *)

val make_chrome_user_event_translation_table : 
  ?action_hash_to_name:(int64 * string) list ->
  unit ->
  chrome_user_event_translation_table
(** [make_chrome_user_event_translation_table … ()] is a builder for type [chrome_user_event_translation_table] *)

val copy_chrome_user_event_translation_table : chrome_user_event_translation_table -> chrome_user_event_translation_table

val chrome_user_event_translation_table_set_action_hash_to_name : chrome_user_event_translation_table -> (int64 * string) list -> unit
  (** set field action_hash_to_name in chrome_user_event_translation_table *)

val make_chrome_performance_mark_translation_table : 
  ?site_hash_to_name:(int32 * string) list ->
  ?mark_hash_to_name:(int32 * string) list ->
  unit ->
  chrome_performance_mark_translation_table
(** [make_chrome_performance_mark_translation_table … ()] is a builder for type [chrome_performance_mark_translation_table] *)

val copy_chrome_performance_mark_translation_table : chrome_performance_mark_translation_table -> chrome_performance_mark_translation_table

val chrome_performance_mark_translation_table_set_site_hash_to_name : chrome_performance_mark_translation_table -> (int32 * string) list -> unit
  (** set field site_hash_to_name in chrome_performance_mark_translation_table *)

val chrome_performance_mark_translation_table_set_mark_hash_to_name : chrome_performance_mark_translation_table -> (int32 * string) list -> unit
  (** set field mark_hash_to_name in chrome_performance_mark_translation_table *)

val make_slice_name_translation_table : 
  ?raw_to_deobfuscated_name:(string * string) list ->
  unit ->
  slice_name_translation_table
(** [make_slice_name_translation_table … ()] is a builder for type [slice_name_translation_table] *)

val copy_slice_name_translation_table : slice_name_translation_table -> slice_name_translation_table

val slice_name_translation_table_set_raw_to_deobfuscated_name : slice_name_translation_table -> (string * string) list -> unit
  (** set field raw_to_deobfuscated_name in slice_name_translation_table *)

val make_process_track_name_translation_table : 
  ?raw_to_deobfuscated_name:(string * string) list ->
  unit ->
  process_track_name_translation_table
(** [make_process_track_name_translation_table … ()] is a builder for type [process_track_name_translation_table] *)

val copy_process_track_name_translation_table : process_track_name_translation_table -> process_track_name_translation_table

val process_track_name_translation_table_set_raw_to_deobfuscated_name : process_track_name_translation_table -> (string * string) list -> unit
  (** set field raw_to_deobfuscated_name in process_track_name_translation_table *)

val make_chrome_study_translation_table : 
  ?hash_to_name:(int64 * string) list ->
  unit ->
  chrome_study_translation_table
(** [make_chrome_study_translation_table … ()] is a builder for type [chrome_study_translation_table] *)

val copy_chrome_study_translation_table : chrome_study_translation_table -> chrome_study_translation_table

val chrome_study_translation_table_set_hash_to_name : chrome_study_translation_table -> (int64 * string) list -> unit
  (** set field hash_to_name in chrome_study_translation_table *)

val make_trigger : 
  ?trigger_name:string ->
  ?producer_name:string ->
  ?trusted_producer_uid:int32 ->
  ?stop_delay_ms:int64 ->
  unit ->
  trigger
(** [make_trigger … ()] is a builder for type [trigger] *)

val copy_trigger : trigger -> trigger

val trigger_has_trigger_name : trigger -> bool
  (** presence of field "trigger_name" in [trigger] *)

val trigger_set_trigger_name : trigger -> string -> unit
  (** set field trigger_name in trigger *)

val trigger_has_producer_name : trigger -> bool
  (** presence of field "producer_name" in [trigger] *)

val trigger_set_producer_name : trigger -> string -> unit
  (** set field producer_name in trigger *)

val trigger_has_trusted_producer_uid : trigger -> bool
  (** presence of field "trusted_producer_uid" in [trigger] *)

val trigger_set_trusted_producer_uid : trigger -> int32 -> unit
  (** set field trusted_producer_uid in trigger *)

val trigger_has_stop_delay_ms : trigger -> bool
  (** presence of field "stop_delay_ms" in [trigger] *)

val trigger_set_stop_delay_ms : trigger -> int64 -> unit
  (** set field stop_delay_ms in trigger *)

val make_ui_state : 
  ?timeline_start_ts:int64 ->
  ?timeline_end_ts:int64 ->
  ?highlight_process:ui_state_highlight_process ->
  unit ->
  ui_state
(** [make_ui_state … ()] is a builder for type [ui_state] *)

val copy_ui_state : ui_state -> ui_state

val ui_state_has_timeline_start_ts : ui_state -> bool
  (** presence of field "timeline_start_ts" in [ui_state] *)

val ui_state_set_timeline_start_ts : ui_state -> int64 -> unit
  (** set field timeline_start_ts in ui_state *)

val ui_state_has_timeline_end_ts : ui_state -> bool
  (** presence of field "timeline_end_ts" in [ui_state] *)

val ui_state_set_timeline_end_ts : ui_state -> int64 -> unit
  (** set field timeline_end_ts in ui_state *)

val ui_state_set_highlight_process : ui_state -> ui_state_highlight_process -> unit
  (** set field highlight_process in ui_state *)

val make_trace_packet : 
  ?timestamp:int64 ->
  ?timestamp_clock_id:int32 ->
  ?data:trace_packet_data ->
  ?optional_trusted_uid:trace_packet_optional_trusted_uid ->
  ?optional_trusted_packet_sequence_id:trace_packet_optional_trusted_packet_sequence_id ->
  ?trusted_pid:int32 ->
  ?interned_data:interned_data ->
  ?sequence_flags:int32 ->
  ?incremental_state_cleared:bool ->
  ?trace_packet_defaults:trace_packet_defaults ->
  ?previous_packet_dropped:bool ->
  ?first_packet_on_sequence:bool ->
  ?machine_id:int32 ->
  unit ->
  trace_packet
(** [make_trace_packet … ()] is a builder for type [trace_packet] *)

val copy_trace_packet : trace_packet -> trace_packet

val trace_packet_has_timestamp : trace_packet -> bool
  (** presence of field "timestamp" in [trace_packet] *)

val trace_packet_set_timestamp : trace_packet -> int64 -> unit
  (** set field timestamp in trace_packet *)

val trace_packet_has_timestamp_clock_id : trace_packet -> bool
  (** presence of field "timestamp_clock_id" in [trace_packet] *)

val trace_packet_set_timestamp_clock_id : trace_packet -> int32 -> unit
  (** set field timestamp_clock_id in trace_packet *)

val trace_packet_set_data : trace_packet -> trace_packet_data -> unit
  (** set field data in trace_packet *)

val trace_packet_set_optional_trusted_uid : trace_packet -> trace_packet_optional_trusted_uid -> unit
  (** set field optional_trusted_uid in trace_packet *)

val trace_packet_set_optional_trusted_packet_sequence_id : trace_packet -> trace_packet_optional_trusted_packet_sequence_id -> unit
  (** set field optional_trusted_packet_sequence_id in trace_packet *)

val trace_packet_has_trusted_pid : trace_packet -> bool
  (** presence of field "trusted_pid" in [trace_packet] *)

val trace_packet_set_trusted_pid : trace_packet -> int32 -> unit
  (** set field trusted_pid in trace_packet *)

val trace_packet_set_interned_data : trace_packet -> interned_data -> unit
  (** set field interned_data in trace_packet *)

val trace_packet_has_sequence_flags : trace_packet -> bool
  (** presence of field "sequence_flags" in [trace_packet] *)

val trace_packet_set_sequence_flags : trace_packet -> int32 -> unit
  (** set field sequence_flags in trace_packet *)

val trace_packet_has_incremental_state_cleared : trace_packet -> bool
  (** presence of field "incremental_state_cleared" in [trace_packet] *)

val trace_packet_set_incremental_state_cleared : trace_packet -> bool -> unit
  (** set field incremental_state_cleared in trace_packet *)

val trace_packet_set_trace_packet_defaults : trace_packet -> trace_packet_defaults -> unit
  (** set field trace_packet_defaults in trace_packet *)

val trace_packet_has_previous_packet_dropped : trace_packet -> bool
  (** presence of field "previous_packet_dropped" in [trace_packet] *)

val trace_packet_set_previous_packet_dropped : trace_packet -> bool -> unit
  (** set field previous_packet_dropped in trace_packet *)

val trace_packet_has_first_packet_on_sequence : trace_packet -> bool
  (** presence of field "first_packet_on_sequence" in [trace_packet] *)

val trace_packet_set_first_packet_on_sequence : trace_packet -> bool -> unit
  (** set field first_packet_on_sequence in trace_packet *)

val trace_packet_has_machine_id : trace_packet -> bool
  (** presence of field "machine_id" in [trace_packet] *)

val trace_packet_set_machine_id : trace_packet -> int32 -> unit
  (** set field machine_id in trace_packet *)

val make_trace : 
  ?packet:trace_packet list ->
  unit ->
  trace
(** [make_trace … ()] is a builder for type [trace] *)

val copy_trace : trace -> trace

val trace_set_packet : trace -> trace_packet list -> unit
  (** set field packet in trace *)


(** {2 Formatters} *)

val pp_ftrace_descriptor_atrace_category : Format.formatter -> ftrace_descriptor_atrace_category -> unit 
(** [pp_ftrace_descriptor_atrace_category v] formats v *)

val pp_ftrace_descriptor : Format.formatter -> ftrace_descriptor -> unit 
(** [pp_ftrace_descriptor v] formats v *)

val pp_gpu_counter_descriptor_gpu_counter_group : Format.formatter -> gpu_counter_descriptor_gpu_counter_group -> unit 
(** [pp_gpu_counter_descriptor_gpu_counter_group v] formats v *)

val pp_gpu_counter_descriptor_measure_unit : Format.formatter -> gpu_counter_descriptor_measure_unit -> unit 
(** [pp_gpu_counter_descriptor_measure_unit v] formats v *)

val pp_gpu_counter_descriptor_gpu_counter_spec_peak_value : Format.formatter -> gpu_counter_descriptor_gpu_counter_spec_peak_value -> unit 
(** [pp_gpu_counter_descriptor_gpu_counter_spec_peak_value v] formats v *)

val pp_gpu_counter_descriptor_gpu_counter_spec : Format.formatter -> gpu_counter_descriptor_gpu_counter_spec -> unit 
(** [pp_gpu_counter_descriptor_gpu_counter_spec v] formats v *)

val pp_gpu_counter_descriptor_gpu_counter_block : Format.formatter -> gpu_counter_descriptor_gpu_counter_block -> unit 
(** [pp_gpu_counter_descriptor_gpu_counter_block v] formats v *)

val pp_gpu_counter_descriptor : Format.formatter -> gpu_counter_descriptor -> unit 
(** [pp_gpu_counter_descriptor v] formats v *)

val pp_track_event_category : Format.formatter -> track_event_category -> unit 
(** [pp_track_event_category v] formats v *)

val pp_track_event_descriptor : Format.formatter -> track_event_descriptor -> unit 
(** [pp_track_event_descriptor v] formats v *)

val pp_data_source_descriptor : Format.formatter -> data_source_descriptor -> unit 
(** [pp_data_source_descriptor v] formats v *)

val pp_tracing_service_state_producer : Format.formatter -> tracing_service_state_producer -> unit 
(** [pp_tracing_service_state_producer v] formats v *)

val pp_tracing_service_state_data_source : Format.formatter -> tracing_service_state_data_source -> unit 
(** [pp_tracing_service_state_data_source v] formats v *)

val pp_tracing_service_state_tracing_session : Format.formatter -> tracing_service_state_tracing_session -> unit 
(** [pp_tracing_service_state_tracing_session v] formats v *)

val pp_tracing_service_state : Format.formatter -> tracing_service_state -> unit 
(** [pp_tracing_service_state v] formats v *)

val pp_builtin_clock : Format.formatter -> builtin_clock -> unit 
(** [pp_builtin_clock v] formats v *)

val pp_android_game_intervention_list_config : Format.formatter -> android_game_intervention_list_config -> unit 
(** [pp_android_game_intervention_list_config v] formats v *)

val pp_proto_log_level : Format.formatter -> proto_log_level -> unit 
(** [pp_proto_log_level v] formats v *)

val pp_proto_log_config_tracing_mode : Format.formatter -> proto_log_config_tracing_mode -> unit 
(** [pp_proto_log_config_tracing_mode v] formats v *)

val pp_proto_log_group : Format.formatter -> proto_log_group -> unit 
(** [pp_proto_log_group v] formats v *)

val pp_proto_log_config : Format.formatter -> proto_log_config -> unit 
(** [pp_proto_log_config v] formats v *)

val pp_surface_flinger_layers_config_mode : Format.formatter -> surface_flinger_layers_config_mode -> unit 
(** [pp_surface_flinger_layers_config_mode v] formats v *)

val pp_surface_flinger_layers_config_trace_flag : Format.formatter -> surface_flinger_layers_config_trace_flag -> unit 
(** [pp_surface_flinger_layers_config_trace_flag v] formats v *)

val pp_surface_flinger_layers_config : Format.formatter -> surface_flinger_layers_config -> unit 
(** [pp_surface_flinger_layers_config v] formats v *)

val pp_surface_flinger_transactions_config_mode : Format.formatter -> surface_flinger_transactions_config_mode -> unit 
(** [pp_surface_flinger_transactions_config_mode v] formats v *)

val pp_surface_flinger_transactions_config : Format.formatter -> surface_flinger_transactions_config -> unit 
(** [pp_surface_flinger_transactions_config v] formats v *)

val pp_window_manager_config_log_frequency : Format.formatter -> window_manager_config_log_frequency -> unit 
(** [pp_window_manager_config_log_frequency v] formats v *)

val pp_window_manager_config_log_level : Format.formatter -> window_manager_config_log_level -> unit 
(** [pp_window_manager_config_log_level v] formats v *)

val pp_window_manager_config : Format.formatter -> window_manager_config -> unit 
(** [pp_window_manager_config v] formats v *)

val pp_chrome_config_client_priority : Format.formatter -> chrome_config_client_priority -> unit 
(** [pp_chrome_config_client_priority v] formats v *)

val pp_chrome_config : Format.formatter -> chrome_config -> unit 
(** [pp_chrome_config v] formats v *)

val pp_chromium_histogram_samples_config_histogram_sample : Format.formatter -> chromium_histogram_samples_config_histogram_sample -> unit 
(** [pp_chromium_histogram_samples_config_histogram_sample v] formats v *)

val pp_chromium_histogram_samples_config : Format.formatter -> chromium_histogram_samples_config -> unit 
(** [pp_chromium_histogram_samples_config v] formats v *)

val pp_chromium_system_metrics_config : Format.formatter -> chromium_system_metrics_config -> unit 
(** [pp_chromium_system_metrics_config v] formats v *)

val pp_v8_config : Format.formatter -> v8_config -> unit 
(** [pp_v8_config v] formats v *)

val pp_etw_config_kernel_flag : Format.formatter -> etw_config_kernel_flag -> unit 
(** [pp_etw_config_kernel_flag v] formats v *)

val pp_etw_config : Format.formatter -> etw_config -> unit 
(** [pp_etw_config v] formats v *)

val pp_frozen_ftrace_config : Format.formatter -> frozen_ftrace_config -> unit 
(** [pp_frozen_ftrace_config v] formats v *)

val pp_inode_file_config_mount_point_mapping_entry : Format.formatter -> inode_file_config_mount_point_mapping_entry -> unit 
(** [pp_inode_file_config_mount_point_mapping_entry v] formats v *)

val pp_inode_file_config : Format.formatter -> inode_file_config -> unit 
(** [pp_inode_file_config v] formats v *)

val pp_console_config_output : Format.formatter -> console_config_output -> unit 
(** [pp_console_config_output v] formats v *)

val pp_console_config : Format.formatter -> console_config -> unit 
(** [pp_console_config v] formats v *)

val pp_interceptor_config : Format.formatter -> interceptor_config -> unit 
(** [pp_interceptor_config v] formats v *)

val pp_android_power_config_battery_counters : Format.formatter -> android_power_config_battery_counters -> unit 
(** [pp_android_power_config_battery_counters v] formats v *)

val pp_android_power_config : Format.formatter -> android_power_config -> unit 
(** [pp_android_power_config v] formats v *)

val pp_priority_boost_config_boost_policy : Format.formatter -> priority_boost_config_boost_policy -> unit 
(** [pp_priority_boost_config_boost_policy v] formats v *)

val pp_priority_boost_config : Format.formatter -> priority_boost_config -> unit 
(** [pp_priority_boost_config v] formats v *)

val pp_process_stats_config_quirks : Format.formatter -> process_stats_config_quirks -> unit 
(** [pp_process_stats_config_quirks v] formats v *)

val pp_process_stats_config : Format.formatter -> process_stats_config -> unit 
(** [pp_process_stats_config v] formats v *)

val pp_heapprofd_config_continuous_dump_config : Format.formatter -> heapprofd_config_continuous_dump_config -> unit 
(** [pp_heapprofd_config_continuous_dump_config v] formats v *)

val pp_heapprofd_config : Format.formatter -> heapprofd_config -> unit 
(** [pp_heapprofd_config v] formats v *)

val pp_meminfo_counters : Format.formatter -> meminfo_counters -> unit 
(** [pp_meminfo_counters v] formats v *)

val pp_vmstat_counters : Format.formatter -> vmstat_counters -> unit 
(** [pp_vmstat_counters v] formats v *)

val pp_sys_stats_config_stat_counters : Format.formatter -> sys_stats_config_stat_counters -> unit 
(** [pp_sys_stats_config_stat_counters v] formats v *)

val pp_sys_stats_config : Format.formatter -> sys_stats_config -> unit 
(** [pp_sys_stats_config v] formats v *)

val pp_system_info_config : Format.formatter -> system_info_config -> unit 
(** [pp_system_info_config v] formats v *)

val pp_test_config_dummy_fields : Format.formatter -> test_config_dummy_fields -> unit 
(** [pp_test_config_dummy_fields v] formats v *)

val pp_test_config : Format.formatter -> test_config -> unit 
(** [pp_test_config v] formats v *)

val pp_track_event_config : Format.formatter -> track_event_config -> unit 
(** [pp_track_event_config v] formats v *)

val pp_data_source_config_session_initiator : Format.formatter -> data_source_config_session_initiator -> unit 
(** [pp_data_source_config_session_initiator v] formats v *)

val pp_data_source_config_buffer_exhausted_policy : Format.formatter -> data_source_config_buffer_exhausted_policy -> unit 
(** [pp_data_source_config_buffer_exhausted_policy v] formats v *)

val pp_data_source_config : Format.formatter -> data_source_config -> unit 
(** [pp_data_source_config v] formats v *)

val pp_trace_config_buffer_config_fill_policy : Format.formatter -> trace_config_buffer_config_fill_policy -> unit 
(** [pp_trace_config_buffer_config_fill_policy v] formats v *)

val pp_trace_config_buffer_config : Format.formatter -> trace_config_buffer_config -> unit 
(** [pp_trace_config_buffer_config v] formats v *)

val pp_trace_config_data_source : Format.formatter -> trace_config_data_source -> unit 
(** [pp_trace_config_data_source v] formats v *)

val pp_trace_config_builtin_data_source : Format.formatter -> trace_config_builtin_data_source -> unit 
(** [pp_trace_config_builtin_data_source v] formats v *)

val pp_trace_config_lockdown_mode_operation : Format.formatter -> trace_config_lockdown_mode_operation -> unit 
(** [pp_trace_config_lockdown_mode_operation v] formats v *)

val pp_trace_config_producer_config : Format.formatter -> trace_config_producer_config -> unit 
(** [pp_trace_config_producer_config v] formats v *)

val pp_trace_config_statsd_metadata : Format.formatter -> trace_config_statsd_metadata -> unit 
(** [pp_trace_config_statsd_metadata v] formats v *)

val pp_trace_config_guardrail_overrides : Format.formatter -> trace_config_guardrail_overrides -> unit 
(** [pp_trace_config_guardrail_overrides v] formats v *)

val pp_trace_config_trigger_config_trigger_mode : Format.formatter -> trace_config_trigger_config_trigger_mode -> unit 
(** [pp_trace_config_trigger_config_trigger_mode v] formats v *)

val pp_trace_config_trigger_config_trigger : Format.formatter -> trace_config_trigger_config_trigger -> unit 
(** [pp_trace_config_trigger_config_trigger v] formats v *)

val pp_trace_config_trigger_config : Format.formatter -> trace_config_trigger_config -> unit 
(** [pp_trace_config_trigger_config v] formats v *)

val pp_trace_config_incremental_state_config : Format.formatter -> trace_config_incremental_state_config -> unit 
(** [pp_trace_config_incremental_state_config v] formats v *)

val pp_trace_config_compression_type : Format.formatter -> trace_config_compression_type -> unit 
(** [pp_trace_config_compression_type v] formats v *)

val pp_trace_config_incident_report_config : Format.formatter -> trace_config_incident_report_config -> unit 
(** [pp_trace_config_incident_report_config v] formats v *)

val pp_trace_config_statsd_logging : Format.formatter -> trace_config_statsd_logging -> unit 
(** [pp_trace_config_statsd_logging v] formats v *)

val pp_trace_config_trace_filter_string_filter_policy : Format.formatter -> trace_config_trace_filter_string_filter_policy -> unit 
(** [pp_trace_config_trace_filter_string_filter_policy v] formats v *)

val pp_trace_config_trace_filter_string_filter_rule : Format.formatter -> trace_config_trace_filter_string_filter_rule -> unit 
(** [pp_trace_config_trace_filter_string_filter_rule v] formats v *)

val pp_trace_config_trace_filter_string_filter_chain : Format.formatter -> trace_config_trace_filter_string_filter_chain -> unit 
(** [pp_trace_config_trace_filter_string_filter_chain v] formats v *)

val pp_trace_config_trace_filter : Format.formatter -> trace_config_trace_filter -> unit 
(** [pp_trace_config_trace_filter v] formats v *)

val pp_trace_config_android_report_config : Format.formatter -> trace_config_android_report_config -> unit 
(** [pp_trace_config_android_report_config v] formats v *)

val pp_trace_config_cmd_trace_start_delay : Format.formatter -> trace_config_cmd_trace_start_delay -> unit 
(** [pp_trace_config_cmd_trace_start_delay v] formats v *)

val pp_trace_config_session_semaphore : Format.formatter -> trace_config_session_semaphore -> unit 
(** [pp_trace_config_session_semaphore v] formats v *)

val pp_trace_config : Format.formatter -> trace_config -> unit 
(** [pp_trace_config v] formats v *)

val pp_utsname : Format.formatter -> utsname -> unit 
(** [pp_utsname v] formats v *)

val pp_system_info : Format.formatter -> system_info -> unit 
(** [pp_system_info v] formats v *)

val pp_trace_stats_buffer_stats : Format.formatter -> trace_stats_buffer_stats -> unit 
(** [pp_trace_stats_buffer_stats v] formats v *)

val pp_trace_stats_writer_stats : Format.formatter -> trace_stats_writer_stats -> unit 
(** [pp_trace_stats_writer_stats v] formats v *)

val pp_trace_stats_filter_stats : Format.formatter -> trace_stats_filter_stats -> unit 
(** [pp_trace_stats_filter_stats v] formats v *)

val pp_trace_stats_final_flush_outcome : Format.formatter -> trace_stats_final_flush_outcome -> unit 
(** [pp_trace_stats_final_flush_outcome v] formats v *)

val pp_trace_stats : Format.formatter -> trace_stats -> unit 
(** [pp_trace_stats v] formats v *)

val pp_proto_log_message : Format.formatter -> proto_log_message -> unit 
(** [pp_proto_log_message v] formats v *)

val pp_proto_log_viewer_config_message_data : Format.formatter -> proto_log_viewer_config_message_data -> unit 
(** [pp_proto_log_viewer_config_message_data v] formats v *)

val pp_proto_log_viewer_config_group : Format.formatter -> proto_log_viewer_config_group -> unit 
(** [pp_proto_log_viewer_config_group v] formats v *)

val pp_proto_log_viewer_config : Format.formatter -> proto_log_viewer_config -> unit 
(** [pp_proto_log_viewer_config v] formats v *)

val pp_shell_transition_target : Format.formatter -> shell_transition_target -> unit 
(** [pp_shell_transition_target v] formats v *)

val pp_shell_transition : Format.formatter -> shell_transition -> unit 
(** [pp_shell_transition v] formats v *)

val pp_shell_handler_mapping : Format.formatter -> shell_handler_mapping -> unit 
(** [pp_shell_handler_mapping v] formats v *)

val pp_shell_handler_mappings : Format.formatter -> shell_handler_mappings -> unit 
(** [pp_shell_handler_mappings v] formats v *)

val pp_rect_proto : Format.formatter -> rect_proto -> unit 
(** [pp_rect_proto v] formats v *)

val pp_region_proto : Format.formatter -> region_proto -> unit 
(** [pp_region_proto v] formats v *)

val pp_size_proto : Format.formatter -> size_proto -> unit 
(** [pp_size_proto v] formats v *)

val pp_transform_proto : Format.formatter -> transform_proto -> unit 
(** [pp_transform_proto v] formats v *)

val pp_color_proto : Format.formatter -> color_proto -> unit 
(** [pp_color_proto v] formats v *)

val pp_input_window_info_proto : Format.formatter -> input_window_info_proto -> unit 
(** [pp_input_window_info_proto v] formats v *)

val pp_blur_region : Format.formatter -> blur_region -> unit 
(** [pp_blur_region v] formats v *)

val pp_color_transform_proto : Format.formatter -> color_transform_proto -> unit 
(** [pp_color_transform_proto v] formats v *)

val pp_trusted_overlay : Format.formatter -> trusted_overlay -> unit 
(** [pp_trusted_overlay v] formats v *)

val pp_box_shadow_settings_box_shadow_params : Format.formatter -> box_shadow_settings_box_shadow_params -> unit 
(** [pp_box_shadow_settings_box_shadow_params v] formats v *)

val pp_box_shadow_settings : Format.formatter -> box_shadow_settings -> unit 
(** [pp_box_shadow_settings v] formats v *)

val pp_border_settings : Format.formatter -> border_settings -> unit 
(** [pp_border_settings v] formats v *)

val pp_layers_trace_file_proto_magic_number : Format.formatter -> layers_trace_file_proto_magic_number -> unit 
(** [pp_layers_trace_file_proto_magic_number v] formats v *)

val pp_position_proto : Format.formatter -> position_proto -> unit 
(** [pp_position_proto v] formats v *)

val pp_active_buffer_proto : Format.formatter -> active_buffer_proto -> unit 
(** [pp_active_buffer_proto v] formats v *)

val pp_float_rect_proto : Format.formatter -> float_rect_proto -> unit 
(** [pp_float_rect_proto v] formats v *)

val pp_hwc_composition_type : Format.formatter -> hwc_composition_type -> unit 
(** [pp_hwc_composition_type v] formats v *)

val pp_barrier_layer_proto : Format.formatter -> barrier_layer_proto -> unit 
(** [pp_barrier_layer_proto v] formats v *)

val pp_corner_radii_proto : Format.formatter -> corner_radii_proto -> unit 
(** [pp_corner_radii_proto v] formats v *)

val pp_layer_proto : Format.formatter -> layer_proto -> unit 
(** [pp_layer_proto v] formats v *)

val pp_layers_proto : Format.formatter -> layers_proto -> unit 
(** [pp_layers_proto v] formats v *)

val pp_display_proto : Format.formatter -> display_proto -> unit 
(** [pp_display_proto v] formats v *)

val pp_layers_snapshot_proto : Format.formatter -> layers_snapshot_proto -> unit 
(** [pp_layers_snapshot_proto v] formats v *)

val pp_layers_trace_file_proto : Format.formatter -> layers_trace_file_proto -> unit 
(** [pp_layers_trace_file_proto v] formats v *)

val pp_transaction_trace_file_magic_number : Format.formatter -> transaction_trace_file_magic_number -> unit 
(** [pp_transaction_trace_file_magic_number v] formats v *)

val pp_layer_state_matrix22 : Format.formatter -> layer_state_matrix22 -> unit 
(** [pp_layer_state_matrix22 v] formats v *)

val pp_layer_state_color3 : Format.formatter -> layer_state_color3 -> unit 
(** [pp_layer_state_color3 v] formats v *)

val pp_layer_state_buffer_data_pixel_format : Format.formatter -> layer_state_buffer_data_pixel_format -> unit 
(** [pp_layer_state_buffer_data_pixel_format v] formats v *)

val pp_layer_state_buffer_data : Format.formatter -> layer_state_buffer_data -> unit 
(** [pp_layer_state_buffer_data v] formats v *)

val pp_transform : Format.formatter -> transform -> unit 
(** [pp_transform v] formats v *)

val pp_layer_state_window_info : Format.formatter -> layer_state_window_info -> unit 
(** [pp_layer_state_window_info v] formats v *)

val pp_layer_state_drop_input_mode : Format.formatter -> layer_state_drop_input_mode -> unit 
(** [pp_layer_state_drop_input_mode v] formats v *)

val pp_layer_state_corner_radii : Format.formatter -> layer_state_corner_radii -> unit 
(** [pp_layer_state_corner_radii v] formats v *)

val pp_layer_state : Format.formatter -> layer_state -> unit 
(** [pp_layer_state v] formats v *)

val pp_display_state : Format.formatter -> display_state -> unit 
(** [pp_display_state v] formats v *)

val pp_transaction_barrier : Format.formatter -> transaction_barrier -> unit 
(** [pp_transaction_barrier v] formats v *)

val pp_transaction_state : Format.formatter -> transaction_state -> unit 
(** [pp_transaction_state v] formats v *)

val pp_layer_creation_args : Format.formatter -> layer_creation_args -> unit 
(** [pp_layer_creation_args v] formats v *)

val pp_display_info : Format.formatter -> display_info -> unit 
(** [pp_display_info v] formats v *)

val pp_transaction_trace_entry : Format.formatter -> transaction_trace_entry -> unit 
(** [pp_transaction_trace_entry v] formats v *)

val pp_transaction_trace_file : Format.formatter -> transaction_trace_file -> unit 
(** [pp_transaction_trace_file v] formats v *)

val pp_layer_state_changes_lsb : Format.formatter -> layer_state_changes_lsb -> unit 
(** [pp_layer_state_changes_lsb v] formats v *)

val pp_layer_state_changes_msb : Format.formatter -> layer_state_changes_msb -> unit 
(** [pp_layer_state_changes_msb v] formats v *)

val pp_layer_state_flags : Format.formatter -> layer_state_flags -> unit 
(** [pp_layer_state_flags v] formats v *)

val pp_layer_state_buffer_data_buffer_data_change : Format.formatter -> layer_state_buffer_data_buffer_data_change -> unit 
(** [pp_layer_state_buffer_data_buffer_data_change v] formats v *)

val pp_display_state_changes : Format.formatter -> display_state_changes -> unit 
(** [pp_display_state_changes v] formats v *)

val pp_winscope_extensions : Format.formatter -> winscope_extensions -> unit 
(** [pp_winscope_extensions v] formats v *)

val pp_chrome_benchmark_metadata : Format.formatter -> chrome_benchmark_metadata -> unit 
(** [pp_chrome_benchmark_metadata v] formats v *)

val pp_chrome_metadata_packet_finch_hash : Format.formatter -> chrome_metadata_packet_finch_hash -> unit 
(** [pp_chrome_metadata_packet_finch_hash v] formats v *)

val pp_background_tracing_metadata_trigger_rule_trigger_type : Format.formatter -> background_tracing_metadata_trigger_rule_trigger_type -> unit 
(** [pp_background_tracing_metadata_trigger_rule_trigger_type v] formats v *)

val pp_background_tracing_metadata_trigger_rule_histogram_rule : Format.formatter -> background_tracing_metadata_trigger_rule_histogram_rule -> unit 
(** [pp_background_tracing_metadata_trigger_rule_histogram_rule v] formats v *)

val pp_background_tracing_metadata_trigger_rule_named_rule_event_type : Format.formatter -> background_tracing_metadata_trigger_rule_named_rule_event_type -> unit 
(** [pp_background_tracing_metadata_trigger_rule_named_rule_event_type v] formats v *)

val pp_background_tracing_metadata_trigger_rule_named_rule : Format.formatter -> background_tracing_metadata_trigger_rule_named_rule -> unit 
(** [pp_background_tracing_metadata_trigger_rule_named_rule v] formats v *)

val pp_background_tracing_metadata_trigger_rule : Format.formatter -> background_tracing_metadata_trigger_rule -> unit 
(** [pp_background_tracing_metadata_trigger_rule v] formats v *)

val pp_background_tracing_metadata : Format.formatter -> background_tracing_metadata -> unit 
(** [pp_background_tracing_metadata v] formats v *)

val pp_chrome_metadata_packet : Format.formatter -> chrome_metadata_packet -> unit 
(** [pp_chrome_metadata_packet v] formats v *)

val pp_chrome_traced_value_nested_type : Format.formatter -> chrome_traced_value_nested_type -> unit 
(** [pp_chrome_traced_value_nested_type v] formats v *)

val pp_chrome_traced_value : Format.formatter -> chrome_traced_value -> unit 
(** [pp_chrome_traced_value v] formats v *)

val pp_chrome_string_table_entry : Format.formatter -> chrome_string_table_entry -> unit 
(** [pp_chrome_string_table_entry v] formats v *)

val pp_chrome_trace_event_arg_value : Format.formatter -> chrome_trace_event_arg_value -> unit 
(** [pp_chrome_trace_event_arg_value v] formats v *)

val pp_chrome_trace_event_arg : Format.formatter -> chrome_trace_event_arg -> unit 
(** [pp_chrome_trace_event_arg v] formats v *)

val pp_chrome_trace_event : Format.formatter -> chrome_trace_event -> unit 
(** [pp_chrome_trace_event v] formats v *)

val pp_chrome_metadata_value : Format.formatter -> chrome_metadata_value -> unit 
(** [pp_chrome_metadata_value v] formats v *)

val pp_chrome_metadata : Format.formatter -> chrome_metadata -> unit 
(** [pp_chrome_metadata v] formats v *)

val pp_chrome_legacy_json_trace_trace_type : Format.formatter -> chrome_legacy_json_trace_trace_type -> unit 
(** [pp_chrome_legacy_json_trace_trace_type v] formats v *)

val pp_chrome_legacy_json_trace : Format.formatter -> chrome_legacy_json_trace -> unit 
(** [pp_chrome_legacy_json_trace v] formats v *)

val pp_chrome_event_bundle : Format.formatter -> chrome_event_bundle -> unit 
(** [pp_chrome_event_bundle v] formats v *)

val pp_chrome_trigger : Format.formatter -> chrome_trigger -> unit 
(** [pp_chrome_trigger v] formats v *)

val pp_v8_string : Format.formatter -> v8_string -> unit 
(** [pp_v8_string v] formats v *)

val pp_interned_v8_string_encoded_string : Format.formatter -> interned_v8_string_encoded_string -> unit 
(** [pp_interned_v8_string_encoded_string v] formats v *)

val pp_interned_v8_string : Format.formatter -> interned_v8_string -> unit 
(** [pp_interned_v8_string v] formats v *)

val pp_interned_v8_js_script_type : Format.formatter -> interned_v8_js_script_type -> unit 
(** [pp_interned_v8_js_script_type v] formats v *)

val pp_interned_v8_js_script : Format.formatter -> interned_v8_js_script -> unit 
(** [pp_interned_v8_js_script v] formats v *)

val pp_interned_v8_wasm_script : Format.formatter -> interned_v8_wasm_script -> unit 
(** [pp_interned_v8_wasm_script v] formats v *)

val pp_interned_v8_js_function_kind : Format.formatter -> interned_v8_js_function_kind -> unit 
(** [pp_interned_v8_js_function_kind v] formats v *)

val pp_interned_v8_js_function : Format.formatter -> interned_v8_js_function -> unit 
(** [pp_interned_v8_js_function v] formats v *)

val pp_interned_v8_isolate_code_range : Format.formatter -> interned_v8_isolate_code_range -> unit 
(** [pp_interned_v8_isolate_code_range v] formats v *)

val pp_interned_v8_isolate : Format.formatter -> interned_v8_isolate -> unit 
(** [pp_interned_v8_isolate v] formats v *)

val pp_v8_js_code_tier : Format.formatter -> v8_js_code_tier -> unit 
(** [pp_v8_js_code_tier v] formats v *)

val pp_v8_js_code_instructions : Format.formatter -> v8_js_code_instructions -> unit 
(** [pp_v8_js_code_instructions v] formats v *)

val pp_v8_js_code : Format.formatter -> v8_js_code -> unit 
(** [pp_v8_js_code v] formats v *)

val pp_v8_internal_code_type : Format.formatter -> v8_internal_code_type -> unit 
(** [pp_v8_internal_code_type v] formats v *)

val pp_v8_internal_code : Format.formatter -> v8_internal_code -> unit 
(** [pp_v8_internal_code v] formats v *)

val pp_v8_wasm_code_tier : Format.formatter -> v8_wasm_code_tier -> unit 
(** [pp_v8_wasm_code_tier v] formats v *)

val pp_v8_wasm_code : Format.formatter -> v8_wasm_code -> unit 
(** [pp_v8_wasm_code v] formats v *)

val pp_v8_reg_exp_code : Format.formatter -> v8_reg_exp_code -> unit 
(** [pp_v8_reg_exp_code v] formats v *)

val pp_v8_code_move_to_instructions : Format.formatter -> v8_code_move_to_instructions -> unit 
(** [pp_v8_code_move_to_instructions v] formats v *)

val pp_v8_code_move : Format.formatter -> v8_code_move -> unit 
(** [pp_v8_code_move v] formats v *)

val pp_v8_code_defaults : Format.formatter -> v8_code_defaults -> unit 
(** [pp_v8_code_defaults v] formats v *)

val pp_clock_snapshot_clock_builtin_clocks : Format.formatter -> clock_snapshot_clock_builtin_clocks -> unit 
(** [pp_clock_snapshot_clock_builtin_clocks v] formats v *)

val pp_clock_snapshot_clock : Format.formatter -> clock_snapshot_clock -> unit 
(** [pp_clock_snapshot_clock v] formats v *)

val pp_clock_snapshot : Format.formatter -> clock_snapshot -> unit 
(** [pp_clock_snapshot v] formats v *)

val pp_cswitch_etw_event_old_thread_wait_reason : Format.formatter -> cswitch_etw_event_old_thread_wait_reason -> unit 
(** [pp_cswitch_etw_event_old_thread_wait_reason v] formats v *)

val pp_cswitch_etw_event_old_thread_wait_mode : Format.formatter -> cswitch_etw_event_old_thread_wait_mode -> unit 
(** [pp_cswitch_etw_event_old_thread_wait_mode v] formats v *)

val pp_cswitch_etw_event_old_thread_state : Format.formatter -> cswitch_etw_event_old_thread_state -> unit 
(** [pp_cswitch_etw_event_old_thread_state v] formats v *)

val pp_cswitch_etw_event_old_thread_wait_reason_enum_or_int : Format.formatter -> cswitch_etw_event_old_thread_wait_reason_enum_or_int -> unit 
(** [pp_cswitch_etw_event_old_thread_wait_reason_enum_or_int v] formats v *)

val pp_cswitch_etw_event_old_thread_wait_mode_enum_or_int : Format.formatter -> cswitch_etw_event_old_thread_wait_mode_enum_or_int -> unit 
(** [pp_cswitch_etw_event_old_thread_wait_mode_enum_or_int v] formats v *)

val pp_cswitch_etw_event_old_thread_state_enum_or_int : Format.formatter -> cswitch_etw_event_old_thread_state_enum_or_int -> unit 
(** [pp_cswitch_etw_event_old_thread_state_enum_or_int v] formats v *)

val pp_cswitch_etw_event : Format.formatter -> cswitch_etw_event -> unit 
(** [pp_cswitch_etw_event v] formats v *)

val pp_ready_thread_etw_event_adjust_reason : Format.formatter -> ready_thread_etw_event_adjust_reason -> unit 
(** [pp_ready_thread_etw_event_adjust_reason v] formats v *)

val pp_ready_thread_etw_event_trace_flag : Format.formatter -> ready_thread_etw_event_trace_flag -> unit 
(** [pp_ready_thread_etw_event_trace_flag v] formats v *)

val pp_ready_thread_etw_event_adjust_reason_enum_or_int : Format.formatter -> ready_thread_etw_event_adjust_reason_enum_or_int -> unit 
(** [pp_ready_thread_etw_event_adjust_reason_enum_or_int v] formats v *)

val pp_ready_thread_etw_event_flag_enum_or_int : Format.formatter -> ready_thread_etw_event_flag_enum_or_int -> unit 
(** [pp_ready_thread_etw_event_flag_enum_or_int v] formats v *)

val pp_ready_thread_etw_event : Format.formatter -> ready_thread_etw_event -> unit 
(** [pp_ready_thread_etw_event v] formats v *)

val pp_mem_info_etw_event : Format.formatter -> mem_info_etw_event -> unit 
(** [pp_mem_info_etw_event v] formats v *)

val pp_file_io_create_etw_event : Format.formatter -> file_io_create_etw_event -> unit 
(** [pp_file_io_create_etw_event v] formats v *)

val pp_file_io_dir_enum_etw_event : Format.formatter -> file_io_dir_enum_etw_event -> unit 
(** [pp_file_io_dir_enum_etw_event v] formats v *)

val pp_file_io_info_etw_event : Format.formatter -> file_io_info_etw_event -> unit 
(** [pp_file_io_info_etw_event v] formats v *)

val pp_file_io_read_write_etw_event : Format.formatter -> file_io_read_write_etw_event -> unit 
(** [pp_file_io_read_write_etw_event v] formats v *)

val pp_file_io_simple_op_etw_event : Format.formatter -> file_io_simple_op_etw_event -> unit 
(** [pp_file_io_simple_op_etw_event v] formats v *)

val pp_file_io_op_end_etw_event : Format.formatter -> file_io_op_end_etw_event -> unit 
(** [pp_file_io_op_end_etw_event v] formats v *)

val pp_etw_trace_event_event : Format.formatter -> etw_trace_event_event -> unit 
(** [pp_etw_trace_event_event v] formats v *)

val pp_etw_trace_event : Format.formatter -> etw_trace_event -> unit 
(** [pp_etw_trace_event v] formats v *)

val pp_etw_trace_event_bundle : Format.formatter -> etw_trace_event_bundle -> unit 
(** [pp_etw_trace_event_bundle v] formats v *)

val pp_evdev_event_input_event : Format.formatter -> evdev_event_input_event -> unit 
(** [pp_evdev_event_input_event v] formats v *)

val pp_evdev_event_event : Format.formatter -> evdev_event_event -> unit 
(** [pp_evdev_event_event v] formats v *)

val pp_evdev_event : Format.formatter -> evdev_event -> unit 
(** [pp_evdev_event v] formats v *)

val pp_field_descriptor_proto_label : Format.formatter -> field_descriptor_proto_label -> unit 
(** [pp_field_descriptor_proto_label v] formats v *)

val pp_field_descriptor_proto_type : Format.formatter -> field_descriptor_proto_type -> unit 
(** [pp_field_descriptor_proto_type v] formats v *)

val pp_uninterpreted_option_name_part : Format.formatter -> uninterpreted_option_name_part -> unit 
(** [pp_uninterpreted_option_name_part v] formats v *)

val pp_uninterpreted_option : Format.formatter -> uninterpreted_option -> unit 
(** [pp_uninterpreted_option v] formats v *)

val pp_field_options : Format.formatter -> field_options -> unit 
(** [pp_field_options v] formats v *)

val pp_field_descriptor_proto : Format.formatter -> field_descriptor_proto -> unit 
(** [pp_field_descriptor_proto v] formats v *)

val pp_enum_value_descriptor_proto : Format.formatter -> enum_value_descriptor_proto -> unit 
(** [pp_enum_value_descriptor_proto v] formats v *)

val pp_enum_descriptor_proto : Format.formatter -> enum_descriptor_proto -> unit 
(** [pp_enum_descriptor_proto v] formats v *)

val pp_oneof_options : Format.formatter -> oneof_options -> unit 
(** [pp_oneof_options v] formats v *)

val pp_oneof_descriptor_proto : Format.formatter -> oneof_descriptor_proto -> unit 
(** [pp_oneof_descriptor_proto v] formats v *)

val pp_descriptor_proto_reserved_range : Format.formatter -> descriptor_proto_reserved_range -> unit 
(** [pp_descriptor_proto_reserved_range v] formats v *)

val pp_descriptor_proto : Format.formatter -> descriptor_proto -> unit 
(** [pp_descriptor_proto v] formats v *)

val pp_file_descriptor_proto : Format.formatter -> file_descriptor_proto -> unit 
(** [pp_file_descriptor_proto v] formats v *)

val pp_file_descriptor_set : Format.formatter -> file_descriptor_set -> unit 
(** [pp_file_descriptor_set v] formats v *)

val pp_extension_descriptor : Format.formatter -> extension_descriptor -> unit 
(** [pp_extension_descriptor v] formats v *)

val pp_inode_file_map_entry_type : Format.formatter -> inode_file_map_entry_type -> unit 
(** [pp_inode_file_map_entry_type v] formats v *)

val pp_inode_file_map_entry : Format.formatter -> inode_file_map_entry -> unit 
(** [pp_inode_file_map_entry v] formats v *)

val pp_inode_file_map : Format.formatter -> inode_file_map -> unit 
(** [pp_inode_file_map v] formats v *)

val pp_generic_kernel_cpu_frequency_event : Format.formatter -> generic_kernel_cpu_frequency_event -> unit 
(** [pp_generic_kernel_cpu_frequency_event v] formats v *)

val pp_generic_kernel_task_state_event_task_state_enum : Format.formatter -> generic_kernel_task_state_event_task_state_enum -> unit 
(** [pp_generic_kernel_task_state_event_task_state_enum v] formats v *)

val pp_generic_kernel_task_state_event : Format.formatter -> generic_kernel_task_state_event -> unit 
(** [pp_generic_kernel_task_state_event v] formats v *)

val pp_generic_kernel_task_rename_event : Format.formatter -> generic_kernel_task_rename_event -> unit 
(** [pp_generic_kernel_task_rename_event v] formats v *)

val pp_generic_kernel_process_tree_thread : Format.formatter -> generic_kernel_process_tree_thread -> unit 
(** [pp_generic_kernel_process_tree_thread v] formats v *)

val pp_generic_kernel_process_tree_process : Format.formatter -> generic_kernel_process_tree_process -> unit 
(** [pp_generic_kernel_process_tree_process v] formats v *)

val pp_generic_kernel_process_tree : Format.formatter -> generic_kernel_process_tree -> unit 
(** [pp_generic_kernel_process_tree v] formats v *)

val pp_gpu_counter_event_gpu_counter_value : Format.formatter -> gpu_counter_event_gpu_counter_value -> unit 
(** [pp_gpu_counter_event_gpu_counter_value v] formats v *)

val pp_gpu_counter_event_gpu_counter : Format.formatter -> gpu_counter_event_gpu_counter -> unit 
(** [pp_gpu_counter_event_gpu_counter v] formats v *)

val pp_gpu_counter_event : Format.formatter -> gpu_counter_event -> unit 
(** [pp_gpu_counter_event v] formats v *)

val pp_gpu_log_severity : Format.formatter -> gpu_log_severity -> unit 
(** [pp_gpu_log_severity v] formats v *)

val pp_gpu_log : Format.formatter -> gpu_log -> unit 
(** [pp_gpu_log v] formats v *)

val pp_gpu_render_stage_event_extra_data : Format.formatter -> gpu_render_stage_event_extra_data -> unit 
(** [pp_gpu_render_stage_event_extra_data v] formats v *)

val pp_gpu_render_stage_event_specifications_context_spec : Format.formatter -> gpu_render_stage_event_specifications_context_spec -> unit 
(** [pp_gpu_render_stage_event_specifications_context_spec v] formats v *)

val pp_gpu_render_stage_event_specifications_description : Format.formatter -> gpu_render_stage_event_specifications_description -> unit 
(** [pp_gpu_render_stage_event_specifications_description v] formats v *)

val pp_gpu_render_stage_event_specifications : Format.formatter -> gpu_render_stage_event_specifications -> unit 
(** [pp_gpu_render_stage_event_specifications v] formats v *)

val pp_gpu_render_stage_event : Format.formatter -> gpu_render_stage_event -> unit 
(** [pp_gpu_render_stage_event v] formats v *)

val pp_interned_graphics_context_api : Format.formatter -> interned_graphics_context_api -> unit 
(** [pp_interned_graphics_context_api v] formats v *)

val pp_interned_graphics_context : Format.formatter -> interned_graphics_context -> unit 
(** [pp_interned_graphics_context v] formats v *)

val pp_interned_gpu_render_stage_specification_render_stage_category : Format.formatter -> interned_gpu_render_stage_specification_render_stage_category -> unit 
(** [pp_interned_gpu_render_stage_specification_render_stage_category v] formats v *)

val pp_interned_gpu_render_stage_specification : Format.formatter -> interned_gpu_render_stage_specification -> unit 
(** [pp_interned_gpu_render_stage_specification v] formats v *)

val pp_vulkan_api_event_vk_debug_utils_object_name : Format.formatter -> vulkan_api_event_vk_debug_utils_object_name -> unit 
(** [pp_vulkan_api_event_vk_debug_utils_object_name v] formats v *)

val pp_vulkan_api_event_vk_queue_submit : Format.formatter -> vulkan_api_event_vk_queue_submit -> unit 
(** [pp_vulkan_api_event_vk_queue_submit v] formats v *)

val pp_vulkan_api_event : Format.formatter -> vulkan_api_event -> unit 
(** [pp_vulkan_api_event v] formats v *)

val pp_vulkan_memory_event_annotation_value : Format.formatter -> vulkan_memory_event_annotation_value -> unit 
(** [pp_vulkan_memory_event_annotation_value v] formats v *)

val pp_vulkan_memory_event_annotation : Format.formatter -> vulkan_memory_event_annotation -> unit 
(** [pp_vulkan_memory_event_annotation v] formats v *)

val pp_vulkan_memory_event_source : Format.formatter -> vulkan_memory_event_source -> unit 
(** [pp_vulkan_memory_event_source v] formats v *)

val pp_vulkan_memory_event_operation : Format.formatter -> vulkan_memory_event_operation -> unit 
(** [pp_vulkan_memory_event_operation v] formats v *)

val pp_vulkan_memory_event_allocation_scope : Format.formatter -> vulkan_memory_event_allocation_scope -> unit 
(** [pp_vulkan_memory_event_allocation_scope v] formats v *)

val pp_vulkan_memory_event : Format.formatter -> vulkan_memory_event -> unit 
(** [pp_vulkan_memory_event v] formats v *)

val pp_interned_string : Format.formatter -> interned_string -> unit 
(** [pp_interned_string v] formats v *)

val pp_line : Format.formatter -> line -> unit 
(** [pp_line v] formats v *)

val pp_address_symbols : Format.formatter -> address_symbols -> unit 
(** [pp_address_symbols v] formats v *)

val pp_module_symbols : Format.formatter -> module_symbols -> unit 
(** [pp_module_symbols v] formats v *)

val pp_mapping : Format.formatter -> mapping -> unit 
(** [pp_mapping v] formats v *)

val pp_frame : Format.formatter -> frame -> unit 
(** [pp_frame v] formats v *)

val pp_callstack : Format.formatter -> callstack -> unit 
(** [pp_callstack v] formats v *)

val pp_histogram_name : Format.formatter -> histogram_name -> unit 
(** [pp_histogram_name v] formats v *)

val pp_chrome_histogram_sample : Format.formatter -> chrome_histogram_sample -> unit 
(** [pp_chrome_histogram_sample v] formats v *)

val pp_debug_annotation_nested_value_nested_type : Format.formatter -> debug_annotation_nested_value_nested_type -> unit 
(** [pp_debug_annotation_nested_value_nested_type v] formats v *)

val pp_debug_annotation_nested_value : Format.formatter -> debug_annotation_nested_value -> unit 
(** [pp_debug_annotation_nested_value v] formats v *)

val pp_debug_annotation_name_field : Format.formatter -> debug_annotation_name_field -> unit 
(** [pp_debug_annotation_name_field v] formats v *)

val pp_debug_annotation_value : Format.formatter -> debug_annotation_value -> unit 
(** [pp_debug_annotation_value v] formats v *)

val pp_debug_annotation_proto_type_descriptor : Format.formatter -> debug_annotation_proto_type_descriptor -> unit 
(** [pp_debug_annotation_proto_type_descriptor v] formats v *)

val pp_debug_annotation : Format.formatter -> debug_annotation -> unit 
(** [pp_debug_annotation v] formats v *)

val pp_debug_annotation_name : Format.formatter -> debug_annotation_name -> unit 
(** [pp_debug_annotation_name v] formats v *)

val pp_debug_annotation_value_type_name : Format.formatter -> debug_annotation_value_type_name -> unit 
(** [pp_debug_annotation_value_type_name v] formats v *)

val pp_log_message_priority : Format.formatter -> log_message_priority -> unit 
(** [pp_log_message_priority v] formats v *)

val pp_log_message : Format.formatter -> log_message -> unit 
(** [pp_log_message v] formats v *)

val pp_log_message_body : Format.formatter -> log_message_body -> unit 
(** [pp_log_message_body v] formats v *)

val pp_unsymbolized_source_location : Format.formatter -> unsymbolized_source_location -> unit 
(** [pp_unsymbolized_source_location v] formats v *)

val pp_source_location : Format.formatter -> source_location -> unit 
(** [pp_source_location v] formats v *)

val pp_chrome_active_processes : Format.formatter -> chrome_active_processes -> unit 
(** [pp_chrome_active_processes v] formats v *)

val pp_chrome_application_state_info_chrome_application_state : Format.formatter -> chrome_application_state_info_chrome_application_state -> unit 
(** [pp_chrome_application_state_info_chrome_application_state v] formats v *)

val pp_chrome_application_state_info : Format.formatter -> chrome_application_state_info -> unit 
(** [pp_chrome_application_state_info v] formats v *)

val pp_chrome_compositor_scheduler_action : Format.formatter -> chrome_compositor_scheduler_action -> unit 
(** [pp_chrome_compositor_scheduler_action v] formats v *)

val pp_chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode : Format.formatter -> chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode -> unit 
(** [pp_chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode v] formats v *)

val pp_chrome_compositor_state_machine_major_state_begin_impl_frame_state : Format.formatter -> chrome_compositor_state_machine_major_state_begin_impl_frame_state -> unit 
(** [pp_chrome_compositor_state_machine_major_state_begin_impl_frame_state v] formats v *)

val pp_chrome_compositor_state_machine_major_state_begin_main_frame_state : Format.formatter -> chrome_compositor_state_machine_major_state_begin_main_frame_state -> unit 
(** [pp_chrome_compositor_state_machine_major_state_begin_main_frame_state v] formats v *)

val pp_chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state : Format.formatter -> chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state -> unit 
(** [pp_chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state v] formats v *)

val pp_chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state : Format.formatter -> chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state -> unit 
(** [pp_chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state v] formats v *)

val pp_chrome_compositor_state_machine_major_state : Format.formatter -> chrome_compositor_state_machine_major_state -> unit 
(** [pp_chrome_compositor_state_machine_major_state v] formats v *)

val pp_chrome_compositor_state_machine_minor_state_tree_priority : Format.formatter -> chrome_compositor_state_machine_minor_state_tree_priority -> unit 
(** [pp_chrome_compositor_state_machine_minor_state_tree_priority v] formats v *)

val pp_chrome_compositor_state_machine_minor_state_scroll_handler_state : Format.formatter -> chrome_compositor_state_machine_minor_state_scroll_handler_state -> unit 
(** [pp_chrome_compositor_state_machine_minor_state_scroll_handler_state v] formats v *)

val pp_chrome_compositor_state_machine_minor_state : Format.formatter -> chrome_compositor_state_machine_minor_state -> unit 
(** [pp_chrome_compositor_state_machine_minor_state v] formats v *)

val pp_chrome_compositor_state_machine : Format.formatter -> chrome_compositor_state_machine -> unit 
(** [pp_chrome_compositor_state_machine v] formats v *)

val pp_begin_impl_frame_args_state : Format.formatter -> begin_impl_frame_args_state -> unit 
(** [pp_begin_impl_frame_args_state v] formats v *)

val pp_begin_frame_args_begin_frame_args_type : Format.formatter -> begin_frame_args_begin_frame_args_type -> unit 
(** [pp_begin_frame_args_begin_frame_args_type v] formats v *)

val pp_begin_frame_args_created_from : Format.formatter -> begin_frame_args_created_from -> unit 
(** [pp_begin_frame_args_created_from v] formats v *)

val pp_begin_frame_args : Format.formatter -> begin_frame_args -> unit 
(** [pp_begin_frame_args v] formats v *)

val pp_begin_impl_frame_args_timestamps_in_us : Format.formatter -> begin_impl_frame_args_timestamps_in_us -> unit 
(** [pp_begin_impl_frame_args_timestamps_in_us v] formats v *)

val pp_begin_impl_frame_args_args : Format.formatter -> begin_impl_frame_args_args -> unit 
(** [pp_begin_impl_frame_args_args v] formats v *)

val pp_begin_impl_frame_args : Format.formatter -> begin_impl_frame_args -> unit 
(** [pp_begin_impl_frame_args v] formats v *)

val pp_begin_frame_observer_state : Format.formatter -> begin_frame_observer_state -> unit 
(** [pp_begin_frame_observer_state v] formats v *)

val pp_begin_frame_source_state : Format.formatter -> begin_frame_source_state -> unit 
(** [pp_begin_frame_source_state v] formats v *)

val pp_compositor_timing_history : Format.formatter -> compositor_timing_history -> unit 
(** [pp_compositor_timing_history v] formats v *)

val pp_chrome_compositor_scheduler_state : Format.formatter -> chrome_compositor_scheduler_state -> unit 
(** [pp_chrome_compositor_scheduler_state v] formats v *)

val pp_chrome_content_settings_event_info : Format.formatter -> chrome_content_settings_event_info -> unit 
(** [pp_chrome_content_settings_event_info v] formats v *)

val pp_chrome_frame_reporter_state : Format.formatter -> chrome_frame_reporter_state -> unit 
(** [pp_chrome_frame_reporter_state v] formats v *)

val pp_chrome_frame_reporter_frame_drop_reason : Format.formatter -> chrome_frame_reporter_frame_drop_reason -> unit 
(** [pp_chrome_frame_reporter_frame_drop_reason v] formats v *)

val pp_chrome_frame_reporter_scroll_state : Format.formatter -> chrome_frame_reporter_scroll_state -> unit 
(** [pp_chrome_frame_reporter_scroll_state v] formats v *)

val pp_chrome_frame_reporter_frame_type : Format.formatter -> chrome_frame_reporter_frame_type -> unit 
(** [pp_chrome_frame_reporter_frame_type v] formats v *)

val pp_chrome_frame_reporter : Format.formatter -> chrome_frame_reporter -> unit 
(** [pp_chrome_frame_reporter v] formats v *)

val pp_chrome_keyed_service : Format.formatter -> chrome_keyed_service -> unit 
(** [pp_chrome_keyed_service v] formats v *)

val pp_chrome_latency_info_step : Format.formatter -> chrome_latency_info_step -> unit 
(** [pp_chrome_latency_info_step v] formats v *)

val pp_chrome_latency_info_latency_component_type : Format.formatter -> chrome_latency_info_latency_component_type -> unit 
(** [pp_chrome_latency_info_latency_component_type v] formats v *)

val pp_chrome_latency_info_component_info : Format.formatter -> chrome_latency_info_component_info -> unit 
(** [pp_chrome_latency_info_component_info v] formats v *)

val pp_chrome_latency_info_input_type : Format.formatter -> chrome_latency_info_input_type -> unit 
(** [pp_chrome_latency_info_input_type v] formats v *)

val pp_chrome_latency_info : Format.formatter -> chrome_latency_info -> unit 
(** [pp_chrome_latency_info v] formats v *)

val pp_chrome_legacy_ipc_message_class : Format.formatter -> chrome_legacy_ipc_message_class -> unit 
(** [pp_chrome_legacy_ipc_message_class v] formats v *)

val pp_chrome_legacy_ipc : Format.formatter -> chrome_legacy_ipc -> unit 
(** [pp_chrome_legacy_ipc v] formats v *)

val pp_chrome_message_pump : Format.formatter -> chrome_message_pump -> unit 
(** [pp_chrome_message_pump v] formats v *)

val pp_chrome_mojo_event_info : Format.formatter -> chrome_mojo_event_info -> unit 
(** [pp_chrome_mojo_event_info v] formats v *)

val pp_chrome_railmode : Format.formatter -> chrome_railmode -> unit 
(** [pp_chrome_railmode v] formats v *)

val pp_chrome_renderer_scheduler_state : Format.formatter -> chrome_renderer_scheduler_state -> unit 
(** [pp_chrome_renderer_scheduler_state v] formats v *)

val pp_chrome_user_event : Format.formatter -> chrome_user_event -> unit 
(** [pp_chrome_user_event v] formats v *)

val pp_chrome_window_handle_event_info : Format.formatter -> chrome_window_handle_event_info -> unit 
(** [pp_chrome_window_handle_event_info v] formats v *)

val pp_screenshot : Format.formatter -> screenshot -> unit 
(** [pp_screenshot v] formats v *)

val pp_task_execution : Format.formatter -> task_execution -> unit 
(** [pp_task_execution v] formats v *)

val pp_track_event_type : Format.formatter -> track_event_type -> unit 
(** [pp_track_event_type v] formats v *)

val pp_track_event_callstack_frame : Format.formatter -> track_event_callstack_frame -> unit 
(** [pp_track_event_callstack_frame v] formats v *)

val pp_track_event_callstack : Format.formatter -> track_event_callstack -> unit 
(** [pp_track_event_callstack v] formats v *)

val pp_track_event_legacy_event_flow_direction : Format.formatter -> track_event_legacy_event_flow_direction -> unit 
(** [pp_track_event_legacy_event_flow_direction v] formats v *)

val pp_track_event_legacy_event_instant_event_scope : Format.formatter -> track_event_legacy_event_instant_event_scope -> unit 
(** [pp_track_event_legacy_event_instant_event_scope v] formats v *)

val pp_track_event_legacy_event_id : Format.formatter -> track_event_legacy_event_id -> unit 
(** [pp_track_event_legacy_event_id v] formats v *)

val pp_track_event_legacy_event : Format.formatter -> track_event_legacy_event -> unit 
(** [pp_track_event_legacy_event v] formats v *)

val pp_track_event_name_field : Format.formatter -> track_event_name_field -> unit 
(** [pp_track_event_name_field v] formats v *)

val pp_track_event_counter_value_field : Format.formatter -> track_event_counter_value_field -> unit 
(** [pp_track_event_counter_value_field v] formats v *)

val pp_track_event_correlation_id_field : Format.formatter -> track_event_correlation_id_field -> unit 
(** [pp_track_event_correlation_id_field v] formats v *)

val pp_track_event_callstack_field : Format.formatter -> track_event_callstack_field -> unit 
(** [pp_track_event_callstack_field v] formats v *)

val pp_track_event_source_location_field : Format.formatter -> track_event_source_location_field -> unit 
(** [pp_track_event_source_location_field v] formats v *)

val pp_track_event_timestamp : Format.formatter -> track_event_timestamp -> unit 
(** [pp_track_event_timestamp v] formats v *)

val pp_track_event_thread_time : Format.formatter -> track_event_thread_time -> unit 
(** [pp_track_event_thread_time v] formats v *)

val pp_track_event_thread_instruction_count : Format.formatter -> track_event_thread_instruction_count -> unit 
(** [pp_track_event_thread_instruction_count v] formats v *)

val pp_track_event : Format.formatter -> track_event -> unit 
(** [pp_track_event v] formats v *)

val pp_track_event_defaults : Format.formatter -> track_event_defaults -> unit 
(** [pp_track_event_defaults v] formats v *)

val pp_event_category : Format.formatter -> event_category -> unit 
(** [pp_event_category v] formats v *)

val pp_event_name : Format.formatter -> event_name -> unit 
(** [pp_event_name v] formats v *)

val pp_interned_data : Format.formatter -> interned_data -> unit 
(** [pp_interned_data v] formats v *)

val pp_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units : Format.formatter -> memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units -> unit 
(** [pp_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units v] formats v *)

val pp_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry : Format.formatter -> memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> unit 
(** [pp_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry v] formats v *)

val pp_memory_tracker_snapshot_process_snapshot_memory_node : Format.formatter -> memory_tracker_snapshot_process_snapshot_memory_node -> unit 
(** [pp_memory_tracker_snapshot_process_snapshot_memory_node v] formats v *)

val pp_memory_tracker_snapshot_process_snapshot_memory_edge : Format.formatter -> memory_tracker_snapshot_process_snapshot_memory_edge -> unit 
(** [pp_memory_tracker_snapshot_process_snapshot_memory_edge v] formats v *)

val pp_memory_tracker_snapshot_process_snapshot : Format.formatter -> memory_tracker_snapshot_process_snapshot -> unit 
(** [pp_memory_tracker_snapshot_process_snapshot v] formats v *)

val pp_memory_tracker_snapshot_level_of_detail : Format.formatter -> memory_tracker_snapshot_level_of_detail -> unit 
(** [pp_memory_tracker_snapshot_level_of_detail v] formats v *)

val pp_memory_tracker_snapshot : Format.formatter -> memory_tracker_snapshot -> unit 
(** [pp_memory_tracker_snapshot v] formats v *)

val pp_perfetto_metatrace_arg_key_or_interned_key : Format.formatter -> perfetto_metatrace_arg_key_or_interned_key -> unit 
(** [pp_perfetto_metatrace_arg_key_or_interned_key v] formats v *)

val pp_perfetto_metatrace_arg_value_or_interned_value : Format.formatter -> perfetto_metatrace_arg_value_or_interned_value -> unit 
(** [pp_perfetto_metatrace_arg_value_or_interned_value v] formats v *)

val pp_perfetto_metatrace_arg : Format.formatter -> perfetto_metatrace_arg -> unit 
(** [pp_perfetto_metatrace_arg v] formats v *)

val pp_perfetto_metatrace_interned_string : Format.formatter -> perfetto_metatrace_interned_string -> unit 
(** [pp_perfetto_metatrace_interned_string v] formats v *)

val pp_perfetto_metatrace_record_type : Format.formatter -> perfetto_metatrace_record_type -> unit 
(** [pp_perfetto_metatrace_record_type v] formats v *)

val pp_perfetto_metatrace : Format.formatter -> perfetto_metatrace -> unit 
(** [pp_perfetto_metatrace v] formats v *)

val pp_tracing_service_event_data_sources_data_source : Format.formatter -> tracing_service_event_data_sources_data_source -> unit 
(** [pp_tracing_service_event_data_sources_data_source v] formats v *)

val pp_tracing_service_event_data_sources : Format.formatter -> tracing_service_event_data_sources -> unit 
(** [pp_tracing_service_event_data_sources v] formats v *)

val pp_tracing_service_event : Format.formatter -> tracing_service_event -> unit 
(** [pp_tracing_service_event v] formats v *)

val pp_android_energy_consumer : Format.formatter -> android_energy_consumer -> unit 
(** [pp_android_energy_consumer v] formats v *)

val pp_android_energy_consumer_descriptor : Format.formatter -> android_energy_consumer_descriptor -> unit 
(** [pp_android_energy_consumer_descriptor v] formats v *)

val pp_android_energy_estimation_breakdown_energy_uid_breakdown : Format.formatter -> android_energy_estimation_breakdown_energy_uid_breakdown -> unit 
(** [pp_android_energy_estimation_breakdown_energy_uid_breakdown v] formats v *)

val pp_android_energy_estimation_breakdown : Format.formatter -> android_energy_estimation_breakdown -> unit 
(** [pp_android_energy_estimation_breakdown v] formats v *)

val pp_entity_state_residency_power_entity_state : Format.formatter -> entity_state_residency_power_entity_state -> unit 
(** [pp_entity_state_residency_power_entity_state v] formats v *)

val pp_entity_state_residency_state_residency : Format.formatter -> entity_state_residency_state_residency -> unit 
(** [pp_entity_state_residency_state_residency v] formats v *)

val pp_entity_state_residency : Format.formatter -> entity_state_residency -> unit 
(** [pp_entity_state_residency v] formats v *)

val pp_battery_counters : Format.formatter -> battery_counters -> unit 
(** [pp_battery_counters v] formats v *)

val pp_power_rails_rail_descriptor : Format.formatter -> power_rails_rail_descriptor -> unit 
(** [pp_power_rails_rail_descriptor v] formats v *)

val pp_power_rails_energy_data : Format.formatter -> power_rails_energy_data -> unit 
(** [pp_power_rails_energy_data v] formats v *)

val pp_power_rails : Format.formatter -> power_rails -> unit 
(** [pp_power_rails v] formats v *)

val pp_obfuscated_member : Format.formatter -> obfuscated_member -> unit 
(** [pp_obfuscated_member v] formats v *)

val pp_obfuscated_class : Format.formatter -> obfuscated_class -> unit 
(** [pp_obfuscated_class v] formats v *)

val pp_deobfuscation_mapping : Format.formatter -> deobfuscation_mapping -> unit 
(** [pp_deobfuscation_mapping v] formats v *)

val pp_heap_graph_root_type : Format.formatter -> heap_graph_root_type -> unit 
(** [pp_heap_graph_root_type v] formats v *)

val pp_heap_graph_root : Format.formatter -> heap_graph_root -> unit 
(** [pp_heap_graph_root v] formats v *)

val pp_heap_graph_type_kind : Format.formatter -> heap_graph_type_kind -> unit 
(** [pp_heap_graph_type_kind v] formats v *)

val pp_heap_graph_type : Format.formatter -> heap_graph_type -> unit 
(** [pp_heap_graph_type v] formats v *)

val pp_heap_graph_object_heap_type : Format.formatter -> heap_graph_object_heap_type -> unit 
(** [pp_heap_graph_object_heap_type v] formats v *)

val pp_heap_graph_object_identifier : Format.formatter -> heap_graph_object_identifier -> unit 
(** [pp_heap_graph_object_identifier v] formats v *)

val pp_heap_graph_object : Format.formatter -> heap_graph_object -> unit 
(** [pp_heap_graph_object v] formats v *)

val pp_heap_graph : Format.formatter -> heap_graph -> unit 
(** [pp_heap_graph v] formats v *)

val pp_profile_packet_heap_sample : Format.formatter -> profile_packet_heap_sample -> unit 
(** [pp_profile_packet_heap_sample v] formats v *)

val pp_profile_packet_histogram_bucket : Format.formatter -> profile_packet_histogram_bucket -> unit 
(** [pp_profile_packet_histogram_bucket v] formats v *)

val pp_profile_packet_histogram : Format.formatter -> profile_packet_histogram -> unit 
(** [pp_profile_packet_histogram v] formats v *)

val pp_profile_packet_process_stats : Format.formatter -> profile_packet_process_stats -> unit 
(** [pp_profile_packet_process_stats v] formats v *)

val pp_profile_packet_process_heap_samples_client_error : Format.formatter -> profile_packet_process_heap_samples_client_error -> unit 
(** [pp_profile_packet_process_heap_samples_client_error v] formats v *)

val pp_profile_packet_process_heap_samples : Format.formatter -> profile_packet_process_heap_samples -> unit 
(** [pp_profile_packet_process_heap_samples v] formats v *)

val pp_profile_packet : Format.formatter -> profile_packet -> unit 
(** [pp_profile_packet v] formats v *)

val pp_streaming_allocation : Format.formatter -> streaming_allocation -> unit 
(** [pp_streaming_allocation v] formats v *)

val pp_streaming_free : Format.formatter -> streaming_free -> unit 
(** [pp_streaming_free v] formats v *)

val pp_streaming_profile_packet : Format.formatter -> streaming_profile_packet -> unit 
(** [pp_streaming_profile_packet v] formats v *)

val pp_profiling_cpu_mode : Format.formatter -> profiling_cpu_mode -> unit 
(** [pp_profiling_cpu_mode v] formats v *)

val pp_profiling_stack_unwind_error : Format.formatter -> profiling_stack_unwind_error -> unit 
(** [pp_profiling_stack_unwind_error v] formats v *)

val pp_profiling : Format.formatter -> profiling -> unit 
(** [pp_profiling v] formats v *)

val pp_perf_sample_sample_skip_reason : Format.formatter -> perf_sample_sample_skip_reason -> unit 
(** [pp_perf_sample_sample_skip_reason v] formats v *)

val pp_perf_sample_producer_event_data_source_stop_reason : Format.formatter -> perf_sample_producer_event_data_source_stop_reason -> unit 
(** [pp_perf_sample_producer_event_data_source_stop_reason v] formats v *)

val pp_perf_sample_producer_event : Format.formatter -> perf_sample_producer_event -> unit 
(** [pp_perf_sample_producer_event v] formats v *)

val pp_perf_sample_optional_unwind_error : Format.formatter -> perf_sample_optional_unwind_error -> unit 
(** [pp_perf_sample_optional_unwind_error v] formats v *)

val pp_perf_sample_optional_sample_skipped_reason : Format.formatter -> perf_sample_optional_sample_skipped_reason -> unit 
(** [pp_perf_sample_optional_sample_skipped_reason v] formats v *)

val pp_perf_sample : Format.formatter -> perf_sample -> unit 
(** [pp_perf_sample v] formats v *)

val pp_smaps_entry : Format.formatter -> smaps_entry -> unit 
(** [pp_smaps_entry v] formats v *)

val pp_smaps_packet : Format.formatter -> smaps_packet -> unit 
(** [pp_smaps_packet v] formats v *)

val pp_process_stats_thread : Format.formatter -> process_stats_thread -> unit 
(** [pp_process_stats_thread v] formats v *)

val pp_process_stats_fdinfo : Format.formatter -> process_stats_fdinfo -> unit 
(** [pp_process_stats_fdinfo v] formats v *)

val pp_process_stats_process : Format.formatter -> process_stats_process -> unit 
(** [pp_process_stats_process v] formats v *)

val pp_process_stats : Format.formatter -> process_stats -> unit 
(** [pp_process_stats v] formats v *)

val pp_process_tree_thread : Format.formatter -> process_tree_thread -> unit 
(** [pp_process_tree_thread v] formats v *)

val pp_process_tree_process : Format.formatter -> process_tree_process -> unit 
(** [pp_process_tree_process v] formats v *)

val pp_process_tree : Format.formatter -> process_tree -> unit 
(** [pp_process_tree v] formats v *)

val pp_remote_clock_sync_synced_clocks : Format.formatter -> remote_clock_sync_synced_clocks -> unit 
(** [pp_remote_clock_sync_synced_clocks v] formats v *)

val pp_remote_clock_sync : Format.formatter -> remote_clock_sync -> unit 
(** [pp_remote_clock_sync v] formats v *)

val pp_atom : Format.formatter -> atom -> unit 
(** [pp_atom v] formats v *)

val pp_statsd_atom : Format.formatter -> statsd_atom -> unit 
(** [pp_statsd_atom v] formats v *)

val pp_sys_stats_meminfo_value : Format.formatter -> sys_stats_meminfo_value -> unit 
(** [pp_sys_stats_meminfo_value v] formats v *)

val pp_sys_stats_vmstat_value : Format.formatter -> sys_stats_vmstat_value -> unit 
(** [pp_sys_stats_vmstat_value v] formats v *)

val pp_sys_stats_cpu_times : Format.formatter -> sys_stats_cpu_times -> unit 
(** [pp_sys_stats_cpu_times v] formats v *)

val pp_sys_stats_interrupt_count : Format.formatter -> sys_stats_interrupt_count -> unit 
(** [pp_sys_stats_interrupt_count v] formats v *)

val pp_sys_stats_devfreq_value : Format.formatter -> sys_stats_devfreq_value -> unit 
(** [pp_sys_stats_devfreq_value v] formats v *)

val pp_sys_stats_buddy_info : Format.formatter -> sys_stats_buddy_info -> unit 
(** [pp_sys_stats_buddy_info v] formats v *)

val pp_sys_stats_disk_stat : Format.formatter -> sys_stats_disk_stat -> unit 
(** [pp_sys_stats_disk_stat v] formats v *)

val pp_sys_stats_psi_sample_psi_resource : Format.formatter -> sys_stats_psi_sample_psi_resource -> unit 
(** [pp_sys_stats_psi_sample_psi_resource v] formats v *)

val pp_sys_stats_psi_sample : Format.formatter -> sys_stats_psi_sample -> unit 
(** [pp_sys_stats_psi_sample v] formats v *)

val pp_sys_stats_thermal_zone : Format.formatter -> sys_stats_thermal_zone -> unit 
(** [pp_sys_stats_thermal_zone v] formats v *)

val pp_sys_stats_cpu_idle_state_entry : Format.formatter -> sys_stats_cpu_idle_state_entry -> unit 
(** [pp_sys_stats_cpu_idle_state_entry v] formats v *)

val pp_sys_stats_cpu_idle_state : Format.formatter -> sys_stats_cpu_idle_state -> unit 
(** [pp_sys_stats_cpu_idle_state v] formats v *)

val pp_sys_stats : Format.formatter -> sys_stats -> unit 
(** [pp_sys_stats v] formats v *)

val pp_cpu_info_arm_cpu_identifier : Format.formatter -> cpu_info_arm_cpu_identifier -> unit 
(** [pp_cpu_info_arm_cpu_identifier v] formats v *)

val pp_cpu_info_cpu_identifier : Format.formatter -> cpu_info_cpu_identifier -> unit 
(** [pp_cpu_info_cpu_identifier v] formats v *)

val pp_cpu_info_cpu : Format.formatter -> cpu_info_cpu -> unit 
(** [pp_cpu_info_cpu v] formats v *)

val pp_cpu_info : Format.formatter -> cpu_info -> unit 
(** [pp_cpu_info v] formats v *)

val pp_test_event_test_payload : Format.formatter -> test_event_test_payload -> unit 
(** [pp_test_event_test_payload v] formats v *)

val pp_test_event : Format.formatter -> test_event -> unit 
(** [pp_test_event v] formats v *)

val pp_trace_packet_defaults : Format.formatter -> trace_packet_defaults -> unit 
(** [pp_trace_packet_defaults v] formats v *)

val pp_trace_uuid : Format.formatter -> trace_uuid -> unit 
(** [pp_trace_uuid v] formats v *)

val pp_process_descriptor_chrome_process_type : Format.formatter -> process_descriptor_chrome_process_type -> unit 
(** [pp_process_descriptor_chrome_process_type v] formats v *)

val pp_process_descriptor : Format.formatter -> process_descriptor -> unit 
(** [pp_process_descriptor v] formats v *)

val pp_track_event_range_of_interest : Format.formatter -> track_event_range_of_interest -> unit 
(** [pp_track_event_range_of_interest v] formats v *)

val pp_thread_descriptor_chrome_thread_type : Format.formatter -> thread_descriptor_chrome_thread_type -> unit 
(** [pp_thread_descriptor_chrome_thread_type v] formats v *)

val pp_thread_descriptor : Format.formatter -> thread_descriptor -> unit 
(** [pp_thread_descriptor v] formats v *)

val pp_chrome_process_descriptor : Format.formatter -> chrome_process_descriptor -> unit 
(** [pp_chrome_process_descriptor v] formats v *)

val pp_chrome_thread_descriptor : Format.formatter -> chrome_thread_descriptor -> unit 
(** [pp_chrome_thread_descriptor v] formats v *)

val pp_counter_descriptor_builtin_counter_type : Format.formatter -> counter_descriptor_builtin_counter_type -> unit 
(** [pp_counter_descriptor_builtin_counter_type v] formats v *)

val pp_counter_descriptor_unit : Format.formatter -> counter_descriptor_unit -> unit 
(** [pp_counter_descriptor_unit v] formats v *)

val pp_counter_descriptor : Format.formatter -> counter_descriptor -> unit 
(** [pp_counter_descriptor v] formats v *)

val pp_track_descriptor_child_tracks_ordering : Format.formatter -> track_descriptor_child_tracks_ordering -> unit 
(** [pp_track_descriptor_child_tracks_ordering v] formats v *)

val pp_track_descriptor_sibling_merge_behavior : Format.formatter -> track_descriptor_sibling_merge_behavior -> unit 
(** [pp_track_descriptor_sibling_merge_behavior v] formats v *)

val pp_track_descriptor_static_or_dynamic_name : Format.formatter -> track_descriptor_static_or_dynamic_name -> unit 
(** [pp_track_descriptor_static_or_dynamic_name v] formats v *)

val pp_track_descriptor_sibling_merge_key_field : Format.formatter -> track_descriptor_sibling_merge_key_field -> unit 
(** [pp_track_descriptor_sibling_merge_key_field v] formats v *)

val pp_track_descriptor : Format.formatter -> track_descriptor -> unit 
(** [pp_track_descriptor v] formats v *)

val pp_chrome_historgram_translation_table : Format.formatter -> chrome_historgram_translation_table -> unit 
(** [pp_chrome_historgram_translation_table v] formats v *)

val pp_chrome_user_event_translation_table : Format.formatter -> chrome_user_event_translation_table -> unit 
(** [pp_chrome_user_event_translation_table v] formats v *)

val pp_chrome_performance_mark_translation_table : Format.formatter -> chrome_performance_mark_translation_table -> unit 
(** [pp_chrome_performance_mark_translation_table v] formats v *)

val pp_slice_name_translation_table : Format.formatter -> slice_name_translation_table -> unit 
(** [pp_slice_name_translation_table v] formats v *)

val pp_process_track_name_translation_table : Format.formatter -> process_track_name_translation_table -> unit 
(** [pp_process_track_name_translation_table v] formats v *)

val pp_chrome_study_translation_table : Format.formatter -> chrome_study_translation_table -> unit 
(** [pp_chrome_study_translation_table v] formats v *)

val pp_translation_table : Format.formatter -> translation_table -> unit 
(** [pp_translation_table v] formats v *)

val pp_trigger : Format.formatter -> trigger -> unit 
(** [pp_trigger v] formats v *)

val pp_ui_state_highlight_process : Format.formatter -> ui_state_highlight_process -> unit 
(** [pp_ui_state_highlight_process v] formats v *)

val pp_ui_state : Format.formatter -> ui_state -> unit 
(** [pp_ui_state v] formats v *)

val pp_trace_packet_sequence_flags : Format.formatter -> trace_packet_sequence_flags -> unit 
(** [pp_trace_packet_sequence_flags v] formats v *)

val pp_trace_packet_data : Format.formatter -> trace_packet_data -> unit 
(** [pp_trace_packet_data v] formats v *)

val pp_trace_packet_optional_trusted_uid : Format.formatter -> trace_packet_optional_trusted_uid -> unit 
(** [pp_trace_packet_optional_trusted_uid v] formats v *)

val pp_trace_packet_optional_trusted_packet_sequence_id : Format.formatter -> trace_packet_optional_trusted_packet_sequence_id -> unit 
(** [pp_trace_packet_optional_trusted_packet_sequence_id v] formats v *)

val pp_trace_packet : Format.formatter -> trace_packet -> unit 
(** [pp_trace_packet v] formats v *)

val pp_trace : Format.formatter -> trace -> unit 
(** [pp_trace v] formats v *)


(** {2 Protobuf Encoding} *)

val encode_pb_ftrace_descriptor_atrace_category : ftrace_descriptor_atrace_category -> Pbrt.Encoder.t -> unit
(** [encode_pb_ftrace_descriptor_atrace_category v encoder] encodes [v] with the given [encoder] *)

val encode_pb_ftrace_descriptor : ftrace_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_ftrace_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_counter_descriptor_gpu_counter_group : gpu_counter_descriptor_gpu_counter_group -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_counter_descriptor_gpu_counter_group v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_counter_descriptor_measure_unit : gpu_counter_descriptor_measure_unit -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_counter_descriptor_measure_unit v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_counter_descriptor_gpu_counter_spec_peak_value : gpu_counter_descriptor_gpu_counter_spec_peak_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_counter_descriptor_gpu_counter_spec_peak_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_counter_descriptor_gpu_counter_spec : gpu_counter_descriptor_gpu_counter_spec -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_counter_descriptor_gpu_counter_spec v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_counter_descriptor_gpu_counter_block : gpu_counter_descriptor_gpu_counter_block -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_counter_descriptor_gpu_counter_block v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_counter_descriptor : gpu_counter_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_counter_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_category : track_event_category -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_category v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_descriptor : track_event_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_data_source_descriptor : data_source_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_data_source_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_tracing_service_state_producer : tracing_service_state_producer -> Pbrt.Encoder.t -> unit
(** [encode_pb_tracing_service_state_producer v encoder] encodes [v] with the given [encoder] *)

val encode_pb_tracing_service_state_data_source : tracing_service_state_data_source -> Pbrt.Encoder.t -> unit
(** [encode_pb_tracing_service_state_data_source v encoder] encodes [v] with the given [encoder] *)

val encode_pb_tracing_service_state_tracing_session : tracing_service_state_tracing_session -> Pbrt.Encoder.t -> unit
(** [encode_pb_tracing_service_state_tracing_session v encoder] encodes [v] with the given [encoder] *)

val encode_pb_tracing_service_state : tracing_service_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_tracing_service_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_builtin_clock : builtin_clock -> Pbrt.Encoder.t -> unit
(** [encode_pb_builtin_clock v encoder] encodes [v] with the given [encoder] *)

val encode_pb_android_game_intervention_list_config : android_game_intervention_list_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_android_game_intervention_list_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_proto_log_level : proto_log_level -> Pbrt.Encoder.t -> unit
(** [encode_pb_proto_log_level v encoder] encodes [v] with the given [encoder] *)

val encode_pb_proto_log_config_tracing_mode : proto_log_config_tracing_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_proto_log_config_tracing_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_proto_log_group : proto_log_group -> Pbrt.Encoder.t -> unit
(** [encode_pb_proto_log_group v encoder] encodes [v] with the given [encoder] *)

val encode_pb_proto_log_config : proto_log_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_proto_log_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_surface_flinger_layers_config_mode : surface_flinger_layers_config_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_surface_flinger_layers_config_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_surface_flinger_layers_config_trace_flag : surface_flinger_layers_config_trace_flag -> Pbrt.Encoder.t -> unit
(** [encode_pb_surface_flinger_layers_config_trace_flag v encoder] encodes [v] with the given [encoder] *)

val encode_pb_surface_flinger_layers_config : surface_flinger_layers_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_surface_flinger_layers_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_surface_flinger_transactions_config_mode : surface_flinger_transactions_config_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_surface_flinger_transactions_config_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_surface_flinger_transactions_config : surface_flinger_transactions_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_surface_flinger_transactions_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_window_manager_config_log_frequency : window_manager_config_log_frequency -> Pbrt.Encoder.t -> unit
(** [encode_pb_window_manager_config_log_frequency v encoder] encodes [v] with the given [encoder] *)

val encode_pb_window_manager_config_log_level : window_manager_config_log_level -> Pbrt.Encoder.t -> unit
(** [encode_pb_window_manager_config_log_level v encoder] encodes [v] with the given [encoder] *)

val encode_pb_window_manager_config : window_manager_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_window_manager_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_config_client_priority : chrome_config_client_priority -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_config_client_priority v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_config : chrome_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chromium_histogram_samples_config_histogram_sample : chromium_histogram_samples_config_histogram_sample -> Pbrt.Encoder.t -> unit
(** [encode_pb_chromium_histogram_samples_config_histogram_sample v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chromium_histogram_samples_config : chromium_histogram_samples_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_chromium_histogram_samples_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chromium_system_metrics_config : chromium_system_metrics_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_chromium_system_metrics_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_config : v8_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_etw_config_kernel_flag : etw_config_kernel_flag -> Pbrt.Encoder.t -> unit
(** [encode_pb_etw_config_kernel_flag v encoder] encodes [v] with the given [encoder] *)

val encode_pb_etw_config : etw_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_etw_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_frozen_ftrace_config : frozen_ftrace_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_frozen_ftrace_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_inode_file_config_mount_point_mapping_entry : inode_file_config_mount_point_mapping_entry -> Pbrt.Encoder.t -> unit
(** [encode_pb_inode_file_config_mount_point_mapping_entry v encoder] encodes [v] with the given [encoder] *)

val encode_pb_inode_file_config : inode_file_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_inode_file_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_console_config_output : console_config_output -> Pbrt.Encoder.t -> unit
(** [encode_pb_console_config_output v encoder] encodes [v] with the given [encoder] *)

val encode_pb_console_config : console_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_console_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interceptor_config : interceptor_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_interceptor_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_android_power_config_battery_counters : android_power_config_battery_counters -> Pbrt.Encoder.t -> unit
(** [encode_pb_android_power_config_battery_counters v encoder] encodes [v] with the given [encoder] *)

val encode_pb_android_power_config : android_power_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_android_power_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_priority_boost_config_boost_policy : priority_boost_config_boost_policy -> Pbrt.Encoder.t -> unit
(** [encode_pb_priority_boost_config_boost_policy v encoder] encodes [v] with the given [encoder] *)

val encode_pb_priority_boost_config : priority_boost_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_priority_boost_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_stats_config_quirks : process_stats_config_quirks -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_stats_config_quirks v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_stats_config : process_stats_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_stats_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_heapprofd_config_continuous_dump_config : heapprofd_config_continuous_dump_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_heapprofd_config_continuous_dump_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_heapprofd_config : heapprofd_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_heapprofd_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_meminfo_counters : meminfo_counters -> Pbrt.Encoder.t -> unit
(** [encode_pb_meminfo_counters v encoder] encodes [v] with the given [encoder] *)

val encode_pb_vmstat_counters : vmstat_counters -> Pbrt.Encoder.t -> unit
(** [encode_pb_vmstat_counters v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_config_stat_counters : sys_stats_config_stat_counters -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_config_stat_counters v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_config : sys_stats_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_system_info_config : system_info_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_system_info_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_test_config_dummy_fields : test_config_dummy_fields -> Pbrt.Encoder.t -> unit
(** [encode_pb_test_config_dummy_fields v encoder] encodes [v] with the given [encoder] *)

val encode_pb_test_config : test_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_test_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_config : track_event_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_data_source_config_session_initiator : data_source_config_session_initiator -> Pbrt.Encoder.t -> unit
(** [encode_pb_data_source_config_session_initiator v encoder] encodes [v] with the given [encoder] *)

val encode_pb_data_source_config_buffer_exhausted_policy : data_source_config_buffer_exhausted_policy -> Pbrt.Encoder.t -> unit
(** [encode_pb_data_source_config_buffer_exhausted_policy v encoder] encodes [v] with the given [encoder] *)

val encode_pb_data_source_config : data_source_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_data_source_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_buffer_config_fill_policy : trace_config_buffer_config_fill_policy -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_buffer_config_fill_policy v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_buffer_config : trace_config_buffer_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_buffer_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_data_source : trace_config_data_source -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_data_source v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_builtin_data_source : trace_config_builtin_data_source -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_builtin_data_source v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_lockdown_mode_operation : trace_config_lockdown_mode_operation -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_lockdown_mode_operation v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_producer_config : trace_config_producer_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_producer_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_statsd_metadata : trace_config_statsd_metadata -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_statsd_metadata v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_guardrail_overrides : trace_config_guardrail_overrides -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_guardrail_overrides v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_trigger_config_trigger_mode : trace_config_trigger_config_trigger_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_trigger_config_trigger_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_trigger_config_trigger : trace_config_trigger_config_trigger -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_trigger_config_trigger v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_trigger_config : trace_config_trigger_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_trigger_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_incremental_state_config : trace_config_incremental_state_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_incremental_state_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_compression_type : trace_config_compression_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_compression_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_incident_report_config : trace_config_incident_report_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_incident_report_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_statsd_logging : trace_config_statsd_logging -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_statsd_logging v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_trace_filter_string_filter_policy : trace_config_trace_filter_string_filter_policy -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_trace_filter_string_filter_policy v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_trace_filter_string_filter_rule : trace_config_trace_filter_string_filter_rule -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_trace_filter_string_filter_rule v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_trace_filter_string_filter_chain : trace_config_trace_filter_string_filter_chain -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_trace_filter_string_filter_chain v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_trace_filter : trace_config_trace_filter -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_trace_filter v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_android_report_config : trace_config_android_report_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_android_report_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_cmd_trace_start_delay : trace_config_cmd_trace_start_delay -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_cmd_trace_start_delay v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config_session_semaphore : trace_config_session_semaphore -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config_session_semaphore v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_config : trace_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_utsname : utsname -> Pbrt.Encoder.t -> unit
(** [encode_pb_utsname v encoder] encodes [v] with the given [encoder] *)

val encode_pb_system_info : system_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_system_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_stats_buffer_stats : trace_stats_buffer_stats -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_stats_buffer_stats v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_stats_writer_stats : trace_stats_writer_stats -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_stats_writer_stats v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_stats_filter_stats : trace_stats_filter_stats -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_stats_filter_stats v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_stats_final_flush_outcome : trace_stats_final_flush_outcome -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_stats_final_flush_outcome v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_stats : trace_stats -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_stats v encoder] encodes [v] with the given [encoder] *)

val encode_pb_proto_log_message : proto_log_message -> Pbrt.Encoder.t -> unit
(** [encode_pb_proto_log_message v encoder] encodes [v] with the given [encoder] *)

val encode_pb_proto_log_viewer_config_message_data : proto_log_viewer_config_message_data -> Pbrt.Encoder.t -> unit
(** [encode_pb_proto_log_viewer_config_message_data v encoder] encodes [v] with the given [encoder] *)

val encode_pb_proto_log_viewer_config_group : proto_log_viewer_config_group -> Pbrt.Encoder.t -> unit
(** [encode_pb_proto_log_viewer_config_group v encoder] encodes [v] with the given [encoder] *)

val encode_pb_proto_log_viewer_config : proto_log_viewer_config -> Pbrt.Encoder.t -> unit
(** [encode_pb_proto_log_viewer_config v encoder] encodes [v] with the given [encoder] *)

val encode_pb_shell_transition_target : shell_transition_target -> Pbrt.Encoder.t -> unit
(** [encode_pb_shell_transition_target v encoder] encodes [v] with the given [encoder] *)

val encode_pb_shell_transition : shell_transition -> Pbrt.Encoder.t -> unit
(** [encode_pb_shell_transition v encoder] encodes [v] with the given [encoder] *)

val encode_pb_shell_handler_mapping : shell_handler_mapping -> Pbrt.Encoder.t -> unit
(** [encode_pb_shell_handler_mapping v encoder] encodes [v] with the given [encoder] *)

val encode_pb_shell_handler_mappings : shell_handler_mappings -> Pbrt.Encoder.t -> unit
(** [encode_pb_shell_handler_mappings v encoder] encodes [v] with the given [encoder] *)

val encode_pb_rect_proto : rect_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_rect_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_region_proto : region_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_region_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_size_proto : size_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_size_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_transform_proto : transform_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_transform_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_color_proto : color_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_color_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_input_window_info_proto : input_window_info_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_input_window_info_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_blur_region : blur_region -> Pbrt.Encoder.t -> unit
(** [encode_pb_blur_region v encoder] encodes [v] with the given [encoder] *)

val encode_pb_color_transform_proto : color_transform_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_color_transform_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trusted_overlay : trusted_overlay -> Pbrt.Encoder.t -> unit
(** [encode_pb_trusted_overlay v encoder] encodes [v] with the given [encoder] *)

val encode_pb_box_shadow_settings_box_shadow_params : box_shadow_settings_box_shadow_params -> Pbrt.Encoder.t -> unit
(** [encode_pb_box_shadow_settings_box_shadow_params v encoder] encodes [v] with the given [encoder] *)

val encode_pb_box_shadow_settings : box_shadow_settings -> Pbrt.Encoder.t -> unit
(** [encode_pb_box_shadow_settings v encoder] encodes [v] with the given [encoder] *)

val encode_pb_border_settings : border_settings -> Pbrt.Encoder.t -> unit
(** [encode_pb_border_settings v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layers_trace_file_proto_magic_number : layers_trace_file_proto_magic_number -> Pbrt.Encoder.t -> unit
(** [encode_pb_layers_trace_file_proto_magic_number v encoder] encodes [v] with the given [encoder] *)

val encode_pb_position_proto : position_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_position_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_active_buffer_proto : active_buffer_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_active_buffer_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_float_rect_proto : float_rect_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_float_rect_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_hwc_composition_type : hwc_composition_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_hwc_composition_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_barrier_layer_proto : barrier_layer_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_barrier_layer_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_corner_radii_proto : corner_radii_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_corner_radii_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_proto : layer_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layers_proto : layers_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_layers_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_display_proto : display_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_display_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layers_snapshot_proto : layers_snapshot_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_layers_snapshot_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layers_trace_file_proto : layers_trace_file_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_layers_trace_file_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_transaction_trace_file_magic_number : transaction_trace_file_magic_number -> Pbrt.Encoder.t -> unit
(** [encode_pb_transaction_trace_file_magic_number v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_matrix22 : layer_state_matrix22 -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_matrix22 v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_color3 : layer_state_color3 -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_color3 v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_buffer_data_pixel_format : layer_state_buffer_data_pixel_format -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_buffer_data_pixel_format v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_buffer_data : layer_state_buffer_data -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_buffer_data v encoder] encodes [v] with the given [encoder] *)

val encode_pb_transform : transform -> Pbrt.Encoder.t -> unit
(** [encode_pb_transform v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_window_info : layer_state_window_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_window_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_drop_input_mode : layer_state_drop_input_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_drop_input_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_corner_radii : layer_state_corner_radii -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_corner_radii v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state : layer_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_display_state : display_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_display_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_transaction_barrier : transaction_barrier -> Pbrt.Encoder.t -> unit
(** [encode_pb_transaction_barrier v encoder] encodes [v] with the given [encoder] *)

val encode_pb_transaction_state : transaction_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_transaction_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_creation_args : layer_creation_args -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_creation_args v encoder] encodes [v] with the given [encoder] *)

val encode_pb_display_info : display_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_display_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_transaction_trace_entry : transaction_trace_entry -> Pbrt.Encoder.t -> unit
(** [encode_pb_transaction_trace_entry v encoder] encodes [v] with the given [encoder] *)

val encode_pb_transaction_trace_file : transaction_trace_file -> Pbrt.Encoder.t -> unit
(** [encode_pb_transaction_trace_file v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_changes_lsb : layer_state_changes_lsb -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_changes_lsb v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_changes_msb : layer_state_changes_msb -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_changes_msb v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_flags : layer_state_flags -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_flags v encoder] encodes [v] with the given [encoder] *)

val encode_pb_layer_state_buffer_data_buffer_data_change : layer_state_buffer_data_buffer_data_change -> Pbrt.Encoder.t -> unit
(** [encode_pb_layer_state_buffer_data_buffer_data_change v encoder] encodes [v] with the given [encoder] *)

val encode_pb_display_state_changes : display_state_changes -> Pbrt.Encoder.t -> unit
(** [encode_pb_display_state_changes v encoder] encodes [v] with the given [encoder] *)

val encode_pb_winscope_extensions : winscope_extensions -> Pbrt.Encoder.t -> unit
(** [encode_pb_winscope_extensions v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_benchmark_metadata : chrome_benchmark_metadata -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_benchmark_metadata v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_metadata_packet_finch_hash : chrome_metadata_packet_finch_hash -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_metadata_packet_finch_hash v encoder] encodes [v] with the given [encoder] *)

val encode_pb_background_tracing_metadata_trigger_rule_trigger_type : background_tracing_metadata_trigger_rule_trigger_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_background_tracing_metadata_trigger_rule_trigger_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_background_tracing_metadata_trigger_rule_histogram_rule : background_tracing_metadata_trigger_rule_histogram_rule -> Pbrt.Encoder.t -> unit
(** [encode_pb_background_tracing_metadata_trigger_rule_histogram_rule v encoder] encodes [v] with the given [encoder] *)

val encode_pb_background_tracing_metadata_trigger_rule_named_rule_event_type : background_tracing_metadata_trigger_rule_named_rule_event_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_background_tracing_metadata_trigger_rule_named_rule_event_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_background_tracing_metadata_trigger_rule_named_rule : background_tracing_metadata_trigger_rule_named_rule -> Pbrt.Encoder.t -> unit
(** [encode_pb_background_tracing_metadata_trigger_rule_named_rule v encoder] encodes [v] with the given [encoder] *)

val encode_pb_background_tracing_metadata_trigger_rule : background_tracing_metadata_trigger_rule -> Pbrt.Encoder.t -> unit
(** [encode_pb_background_tracing_metadata_trigger_rule v encoder] encodes [v] with the given [encoder] *)

val encode_pb_background_tracing_metadata : background_tracing_metadata -> Pbrt.Encoder.t -> unit
(** [encode_pb_background_tracing_metadata v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_metadata_packet : chrome_metadata_packet -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_metadata_packet v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_traced_value_nested_type : chrome_traced_value_nested_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_traced_value_nested_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_traced_value : chrome_traced_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_traced_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_string_table_entry : chrome_string_table_entry -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_string_table_entry v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_trace_event_arg_value : chrome_trace_event_arg_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_trace_event_arg_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_trace_event_arg : chrome_trace_event_arg -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_trace_event_arg v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_trace_event : chrome_trace_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_trace_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_metadata_value : chrome_metadata_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_metadata_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_metadata : chrome_metadata -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_metadata v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_legacy_json_trace_trace_type : chrome_legacy_json_trace_trace_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_legacy_json_trace_trace_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_legacy_json_trace : chrome_legacy_json_trace -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_legacy_json_trace v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_event_bundle : chrome_event_bundle -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_event_bundle v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_trigger : chrome_trigger -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_trigger v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_string : v8_string -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_string v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_v8_string_encoded_string : interned_v8_string_encoded_string -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_v8_string_encoded_string v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_v8_string : interned_v8_string -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_v8_string v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_v8_js_script_type : interned_v8_js_script_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_v8_js_script_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_v8_js_script : interned_v8_js_script -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_v8_js_script v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_v8_wasm_script : interned_v8_wasm_script -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_v8_wasm_script v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_v8_js_function_kind : interned_v8_js_function_kind -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_v8_js_function_kind v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_v8_js_function : interned_v8_js_function -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_v8_js_function v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_v8_isolate_code_range : interned_v8_isolate_code_range -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_v8_isolate_code_range v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_v8_isolate : interned_v8_isolate -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_v8_isolate v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_js_code_tier : v8_js_code_tier -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_js_code_tier v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_js_code_instructions : v8_js_code_instructions -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_js_code_instructions v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_js_code : v8_js_code -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_js_code v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_internal_code_type : v8_internal_code_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_internal_code_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_internal_code : v8_internal_code -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_internal_code v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_wasm_code_tier : v8_wasm_code_tier -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_wasm_code_tier v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_wasm_code : v8_wasm_code -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_wasm_code v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_reg_exp_code : v8_reg_exp_code -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_reg_exp_code v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_code_move_to_instructions : v8_code_move_to_instructions -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_code_move_to_instructions v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_code_move : v8_code_move -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_code_move v encoder] encodes [v] with the given [encoder] *)

val encode_pb_v8_code_defaults : v8_code_defaults -> Pbrt.Encoder.t -> unit
(** [encode_pb_v8_code_defaults v encoder] encodes [v] with the given [encoder] *)

val encode_pb_clock_snapshot_clock_builtin_clocks : clock_snapshot_clock_builtin_clocks -> Pbrt.Encoder.t -> unit
(** [encode_pb_clock_snapshot_clock_builtin_clocks v encoder] encodes [v] with the given [encoder] *)

val encode_pb_clock_snapshot_clock : clock_snapshot_clock -> Pbrt.Encoder.t -> unit
(** [encode_pb_clock_snapshot_clock v encoder] encodes [v] with the given [encoder] *)

val encode_pb_clock_snapshot : clock_snapshot -> Pbrt.Encoder.t -> unit
(** [encode_pb_clock_snapshot v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cswitch_etw_event_old_thread_wait_reason : cswitch_etw_event_old_thread_wait_reason -> Pbrt.Encoder.t -> unit
(** [encode_pb_cswitch_etw_event_old_thread_wait_reason v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cswitch_etw_event_old_thread_wait_mode : cswitch_etw_event_old_thread_wait_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_cswitch_etw_event_old_thread_wait_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cswitch_etw_event_old_thread_state : cswitch_etw_event_old_thread_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_cswitch_etw_event_old_thread_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cswitch_etw_event_old_thread_wait_reason_enum_or_int : cswitch_etw_event_old_thread_wait_reason_enum_or_int -> Pbrt.Encoder.t -> unit
(** [encode_pb_cswitch_etw_event_old_thread_wait_reason_enum_or_int v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cswitch_etw_event_old_thread_wait_mode_enum_or_int : cswitch_etw_event_old_thread_wait_mode_enum_or_int -> Pbrt.Encoder.t -> unit
(** [encode_pb_cswitch_etw_event_old_thread_wait_mode_enum_or_int v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cswitch_etw_event_old_thread_state_enum_or_int : cswitch_etw_event_old_thread_state_enum_or_int -> Pbrt.Encoder.t -> unit
(** [encode_pb_cswitch_etw_event_old_thread_state_enum_or_int v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cswitch_etw_event : cswitch_etw_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_cswitch_etw_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_ready_thread_etw_event_adjust_reason : ready_thread_etw_event_adjust_reason -> Pbrt.Encoder.t -> unit
(** [encode_pb_ready_thread_etw_event_adjust_reason v encoder] encodes [v] with the given [encoder] *)

val encode_pb_ready_thread_etw_event_trace_flag : ready_thread_etw_event_trace_flag -> Pbrt.Encoder.t -> unit
(** [encode_pb_ready_thread_etw_event_trace_flag v encoder] encodes [v] with the given [encoder] *)

val encode_pb_ready_thread_etw_event_adjust_reason_enum_or_int : ready_thread_etw_event_adjust_reason_enum_or_int -> Pbrt.Encoder.t -> unit
(** [encode_pb_ready_thread_etw_event_adjust_reason_enum_or_int v encoder] encodes [v] with the given [encoder] *)

val encode_pb_ready_thread_etw_event_flag_enum_or_int : ready_thread_etw_event_flag_enum_or_int -> Pbrt.Encoder.t -> unit
(** [encode_pb_ready_thread_etw_event_flag_enum_or_int v encoder] encodes [v] with the given [encoder] *)

val encode_pb_ready_thread_etw_event : ready_thread_etw_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_ready_thread_etw_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_mem_info_etw_event : mem_info_etw_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_mem_info_etw_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_file_io_create_etw_event : file_io_create_etw_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_file_io_create_etw_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_file_io_dir_enum_etw_event : file_io_dir_enum_etw_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_file_io_dir_enum_etw_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_file_io_info_etw_event : file_io_info_etw_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_file_io_info_etw_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_file_io_read_write_etw_event : file_io_read_write_etw_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_file_io_read_write_etw_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_file_io_simple_op_etw_event : file_io_simple_op_etw_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_file_io_simple_op_etw_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_file_io_op_end_etw_event : file_io_op_end_etw_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_file_io_op_end_etw_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_etw_trace_event_event : etw_trace_event_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_etw_trace_event_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_etw_trace_event : etw_trace_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_etw_trace_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_etw_trace_event_bundle : etw_trace_event_bundle -> Pbrt.Encoder.t -> unit
(** [encode_pb_etw_trace_event_bundle v encoder] encodes [v] with the given [encoder] *)

val encode_pb_evdev_event_input_event : evdev_event_input_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_evdev_event_input_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_evdev_event_event : evdev_event_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_evdev_event_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_evdev_event : evdev_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_evdev_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_field_descriptor_proto_label : field_descriptor_proto_label -> Pbrt.Encoder.t -> unit
(** [encode_pb_field_descriptor_proto_label v encoder] encodes [v] with the given [encoder] *)

val encode_pb_field_descriptor_proto_type : field_descriptor_proto_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_field_descriptor_proto_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_uninterpreted_option_name_part : uninterpreted_option_name_part -> Pbrt.Encoder.t -> unit
(** [encode_pb_uninterpreted_option_name_part v encoder] encodes [v] with the given [encoder] *)

val encode_pb_uninterpreted_option : uninterpreted_option -> Pbrt.Encoder.t -> unit
(** [encode_pb_uninterpreted_option v encoder] encodes [v] with the given [encoder] *)

val encode_pb_field_options : field_options -> Pbrt.Encoder.t -> unit
(** [encode_pb_field_options v encoder] encodes [v] with the given [encoder] *)

val encode_pb_field_descriptor_proto : field_descriptor_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_field_descriptor_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_enum_value_descriptor_proto : enum_value_descriptor_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_enum_value_descriptor_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_enum_descriptor_proto : enum_descriptor_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_enum_descriptor_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_oneof_options : oneof_options -> Pbrt.Encoder.t -> unit
(** [encode_pb_oneof_options v encoder] encodes [v] with the given [encoder] *)

val encode_pb_oneof_descriptor_proto : oneof_descriptor_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_oneof_descriptor_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_descriptor_proto_reserved_range : descriptor_proto_reserved_range -> Pbrt.Encoder.t -> unit
(** [encode_pb_descriptor_proto_reserved_range v encoder] encodes [v] with the given [encoder] *)

val encode_pb_descriptor_proto : descriptor_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_descriptor_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_file_descriptor_proto : file_descriptor_proto -> Pbrt.Encoder.t -> unit
(** [encode_pb_file_descriptor_proto v encoder] encodes [v] with the given [encoder] *)

val encode_pb_file_descriptor_set : file_descriptor_set -> Pbrt.Encoder.t -> unit
(** [encode_pb_file_descriptor_set v encoder] encodes [v] with the given [encoder] *)

val encode_pb_extension_descriptor : extension_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_extension_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_inode_file_map_entry_type : inode_file_map_entry_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_inode_file_map_entry_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_inode_file_map_entry : inode_file_map_entry -> Pbrt.Encoder.t -> unit
(** [encode_pb_inode_file_map_entry v encoder] encodes [v] with the given [encoder] *)

val encode_pb_inode_file_map : inode_file_map -> Pbrt.Encoder.t -> unit
(** [encode_pb_inode_file_map v encoder] encodes [v] with the given [encoder] *)

val encode_pb_generic_kernel_cpu_frequency_event : generic_kernel_cpu_frequency_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_generic_kernel_cpu_frequency_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_generic_kernel_task_state_event_task_state_enum : generic_kernel_task_state_event_task_state_enum -> Pbrt.Encoder.t -> unit
(** [encode_pb_generic_kernel_task_state_event_task_state_enum v encoder] encodes [v] with the given [encoder] *)

val encode_pb_generic_kernel_task_state_event : generic_kernel_task_state_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_generic_kernel_task_state_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_generic_kernel_task_rename_event : generic_kernel_task_rename_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_generic_kernel_task_rename_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_generic_kernel_process_tree_thread : generic_kernel_process_tree_thread -> Pbrt.Encoder.t -> unit
(** [encode_pb_generic_kernel_process_tree_thread v encoder] encodes [v] with the given [encoder] *)

val encode_pb_generic_kernel_process_tree_process : generic_kernel_process_tree_process -> Pbrt.Encoder.t -> unit
(** [encode_pb_generic_kernel_process_tree_process v encoder] encodes [v] with the given [encoder] *)

val encode_pb_generic_kernel_process_tree : generic_kernel_process_tree -> Pbrt.Encoder.t -> unit
(** [encode_pb_generic_kernel_process_tree v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_counter_event_gpu_counter_value : gpu_counter_event_gpu_counter_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_counter_event_gpu_counter_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_counter_event_gpu_counter : gpu_counter_event_gpu_counter -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_counter_event_gpu_counter v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_counter_event : gpu_counter_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_counter_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_log_severity : gpu_log_severity -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_log_severity v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_log : gpu_log -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_log v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_render_stage_event_extra_data : gpu_render_stage_event_extra_data -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_render_stage_event_extra_data v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_render_stage_event_specifications_context_spec : gpu_render_stage_event_specifications_context_spec -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_render_stage_event_specifications_context_spec v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_render_stage_event_specifications_description : gpu_render_stage_event_specifications_description -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_render_stage_event_specifications_description v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_render_stage_event_specifications : gpu_render_stage_event_specifications -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_render_stage_event_specifications v encoder] encodes [v] with the given [encoder] *)

val encode_pb_gpu_render_stage_event : gpu_render_stage_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_gpu_render_stage_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_graphics_context_api : interned_graphics_context_api -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_graphics_context_api v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_graphics_context : interned_graphics_context -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_graphics_context v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_gpu_render_stage_specification_render_stage_category : interned_gpu_render_stage_specification_render_stage_category -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_gpu_render_stage_specification_render_stage_category v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_gpu_render_stage_specification : interned_gpu_render_stage_specification -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_gpu_render_stage_specification v encoder] encodes [v] with the given [encoder] *)

val encode_pb_vulkan_api_event_vk_debug_utils_object_name : vulkan_api_event_vk_debug_utils_object_name -> Pbrt.Encoder.t -> unit
(** [encode_pb_vulkan_api_event_vk_debug_utils_object_name v encoder] encodes [v] with the given [encoder] *)

val encode_pb_vulkan_api_event_vk_queue_submit : vulkan_api_event_vk_queue_submit -> Pbrt.Encoder.t -> unit
(** [encode_pb_vulkan_api_event_vk_queue_submit v encoder] encodes [v] with the given [encoder] *)

val encode_pb_vulkan_api_event : vulkan_api_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_vulkan_api_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_vulkan_memory_event_annotation_value : vulkan_memory_event_annotation_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_vulkan_memory_event_annotation_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_vulkan_memory_event_annotation : vulkan_memory_event_annotation -> Pbrt.Encoder.t -> unit
(** [encode_pb_vulkan_memory_event_annotation v encoder] encodes [v] with the given [encoder] *)

val encode_pb_vulkan_memory_event_source : vulkan_memory_event_source -> Pbrt.Encoder.t -> unit
(** [encode_pb_vulkan_memory_event_source v encoder] encodes [v] with the given [encoder] *)

val encode_pb_vulkan_memory_event_operation : vulkan_memory_event_operation -> Pbrt.Encoder.t -> unit
(** [encode_pb_vulkan_memory_event_operation v encoder] encodes [v] with the given [encoder] *)

val encode_pb_vulkan_memory_event_allocation_scope : vulkan_memory_event_allocation_scope -> Pbrt.Encoder.t -> unit
(** [encode_pb_vulkan_memory_event_allocation_scope v encoder] encodes [v] with the given [encoder] *)

val encode_pb_vulkan_memory_event : vulkan_memory_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_vulkan_memory_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_string : interned_string -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_string v encoder] encodes [v] with the given [encoder] *)

val encode_pb_line : line -> Pbrt.Encoder.t -> unit
(** [encode_pb_line v encoder] encodes [v] with the given [encoder] *)

val encode_pb_address_symbols : address_symbols -> Pbrt.Encoder.t -> unit
(** [encode_pb_address_symbols v encoder] encodes [v] with the given [encoder] *)

val encode_pb_module_symbols : module_symbols -> Pbrt.Encoder.t -> unit
(** [encode_pb_module_symbols v encoder] encodes [v] with the given [encoder] *)

val encode_pb_mapping : mapping -> Pbrt.Encoder.t -> unit
(** [encode_pb_mapping v encoder] encodes [v] with the given [encoder] *)

val encode_pb_frame : frame -> Pbrt.Encoder.t -> unit
(** [encode_pb_frame v encoder] encodes [v] with the given [encoder] *)

val encode_pb_callstack : callstack -> Pbrt.Encoder.t -> unit
(** [encode_pb_callstack v encoder] encodes [v] with the given [encoder] *)

val encode_pb_histogram_name : histogram_name -> Pbrt.Encoder.t -> unit
(** [encode_pb_histogram_name v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_histogram_sample : chrome_histogram_sample -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_histogram_sample v encoder] encodes [v] with the given [encoder] *)

val encode_pb_debug_annotation_nested_value_nested_type : debug_annotation_nested_value_nested_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_debug_annotation_nested_value_nested_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_debug_annotation_nested_value : debug_annotation_nested_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_debug_annotation_nested_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_debug_annotation_name_field : debug_annotation_name_field -> Pbrt.Encoder.t -> unit
(** [encode_pb_debug_annotation_name_field v encoder] encodes [v] with the given [encoder] *)

val encode_pb_debug_annotation_value : debug_annotation_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_debug_annotation_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_debug_annotation_proto_type_descriptor : debug_annotation_proto_type_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_debug_annotation_proto_type_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_debug_annotation : debug_annotation -> Pbrt.Encoder.t -> unit
(** [encode_pb_debug_annotation v encoder] encodes [v] with the given [encoder] *)

val encode_pb_debug_annotation_name : debug_annotation_name -> Pbrt.Encoder.t -> unit
(** [encode_pb_debug_annotation_name v encoder] encodes [v] with the given [encoder] *)

val encode_pb_debug_annotation_value_type_name : debug_annotation_value_type_name -> Pbrt.Encoder.t -> unit
(** [encode_pb_debug_annotation_value_type_name v encoder] encodes [v] with the given [encoder] *)

val encode_pb_log_message_priority : log_message_priority -> Pbrt.Encoder.t -> unit
(** [encode_pb_log_message_priority v encoder] encodes [v] with the given [encoder] *)

val encode_pb_log_message : log_message -> Pbrt.Encoder.t -> unit
(** [encode_pb_log_message v encoder] encodes [v] with the given [encoder] *)

val encode_pb_log_message_body : log_message_body -> Pbrt.Encoder.t -> unit
(** [encode_pb_log_message_body v encoder] encodes [v] with the given [encoder] *)

val encode_pb_unsymbolized_source_location : unsymbolized_source_location -> Pbrt.Encoder.t -> unit
(** [encode_pb_unsymbolized_source_location v encoder] encodes [v] with the given [encoder] *)

val encode_pb_source_location : source_location -> Pbrt.Encoder.t -> unit
(** [encode_pb_source_location v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_active_processes : chrome_active_processes -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_active_processes v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_application_state_info_chrome_application_state : chrome_application_state_info_chrome_application_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_application_state_info_chrome_application_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_application_state_info : chrome_application_state_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_application_state_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_scheduler_action : chrome_compositor_scheduler_action -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_scheduler_action v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode : chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_scheduler_state_begin_impl_frame_deadline_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_state_machine_major_state_begin_impl_frame_state : chrome_compositor_state_machine_major_state_begin_impl_frame_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_state_machine_major_state_begin_impl_frame_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_state_machine_major_state_begin_main_frame_state : chrome_compositor_state_machine_major_state_begin_main_frame_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_state_machine_major_state_begin_main_frame_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state : chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_state_machine_major_state_layer_tree_frame_sink_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state : chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_state_machine_major_state_forced_redraw_on_timeout_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_state_machine_major_state : chrome_compositor_state_machine_major_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_state_machine_major_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_state_machine_minor_state_tree_priority : chrome_compositor_state_machine_minor_state_tree_priority -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_state_machine_minor_state_tree_priority v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_state_machine_minor_state_scroll_handler_state : chrome_compositor_state_machine_minor_state_scroll_handler_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_state_machine_minor_state_scroll_handler_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_state_machine_minor_state : chrome_compositor_state_machine_minor_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_state_machine_minor_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_state_machine : chrome_compositor_state_machine -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_state_machine v encoder] encodes [v] with the given [encoder] *)

val encode_pb_begin_impl_frame_args_state : begin_impl_frame_args_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_begin_impl_frame_args_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_begin_frame_args_begin_frame_args_type : begin_frame_args_begin_frame_args_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_begin_frame_args_begin_frame_args_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_begin_frame_args_created_from : begin_frame_args_created_from -> Pbrt.Encoder.t -> unit
(** [encode_pb_begin_frame_args_created_from v encoder] encodes [v] with the given [encoder] *)

val encode_pb_begin_frame_args : begin_frame_args -> Pbrt.Encoder.t -> unit
(** [encode_pb_begin_frame_args v encoder] encodes [v] with the given [encoder] *)

val encode_pb_begin_impl_frame_args_timestamps_in_us : begin_impl_frame_args_timestamps_in_us -> Pbrt.Encoder.t -> unit
(** [encode_pb_begin_impl_frame_args_timestamps_in_us v encoder] encodes [v] with the given [encoder] *)

val encode_pb_begin_impl_frame_args_args : begin_impl_frame_args_args -> Pbrt.Encoder.t -> unit
(** [encode_pb_begin_impl_frame_args_args v encoder] encodes [v] with the given [encoder] *)

val encode_pb_begin_impl_frame_args : begin_impl_frame_args -> Pbrt.Encoder.t -> unit
(** [encode_pb_begin_impl_frame_args v encoder] encodes [v] with the given [encoder] *)

val encode_pb_begin_frame_observer_state : begin_frame_observer_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_begin_frame_observer_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_begin_frame_source_state : begin_frame_source_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_begin_frame_source_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_compositor_timing_history : compositor_timing_history -> Pbrt.Encoder.t -> unit
(** [encode_pb_compositor_timing_history v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_compositor_scheduler_state : chrome_compositor_scheduler_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_compositor_scheduler_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_content_settings_event_info : chrome_content_settings_event_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_content_settings_event_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_frame_reporter_state : chrome_frame_reporter_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_frame_reporter_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_frame_reporter_frame_drop_reason : chrome_frame_reporter_frame_drop_reason -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_frame_reporter_frame_drop_reason v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_frame_reporter_scroll_state : chrome_frame_reporter_scroll_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_frame_reporter_scroll_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_frame_reporter_frame_type : chrome_frame_reporter_frame_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_frame_reporter_frame_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_frame_reporter : chrome_frame_reporter -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_frame_reporter v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_keyed_service : chrome_keyed_service -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_keyed_service v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_latency_info_step : chrome_latency_info_step -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_latency_info_step v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_latency_info_latency_component_type : chrome_latency_info_latency_component_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_latency_info_latency_component_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_latency_info_component_info : chrome_latency_info_component_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_latency_info_component_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_latency_info_input_type : chrome_latency_info_input_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_latency_info_input_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_latency_info : chrome_latency_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_latency_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_legacy_ipc_message_class : chrome_legacy_ipc_message_class -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_legacy_ipc_message_class v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_legacy_ipc : chrome_legacy_ipc -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_legacy_ipc v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_message_pump : chrome_message_pump -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_message_pump v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_mojo_event_info : chrome_mojo_event_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_mojo_event_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_railmode : chrome_railmode -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_railmode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_renderer_scheduler_state : chrome_renderer_scheduler_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_renderer_scheduler_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_user_event : chrome_user_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_user_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_window_handle_event_info : chrome_window_handle_event_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_window_handle_event_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_screenshot : screenshot -> Pbrt.Encoder.t -> unit
(** [encode_pb_screenshot v encoder] encodes [v] with the given [encoder] *)

val encode_pb_task_execution : task_execution -> Pbrt.Encoder.t -> unit
(** [encode_pb_task_execution v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_type : track_event_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_callstack_frame : track_event_callstack_frame -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_callstack_frame v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_callstack : track_event_callstack -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_callstack v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_legacy_event_flow_direction : track_event_legacy_event_flow_direction -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_legacy_event_flow_direction v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_legacy_event_instant_event_scope : track_event_legacy_event_instant_event_scope -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_legacy_event_instant_event_scope v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_legacy_event_id : track_event_legacy_event_id -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_legacy_event_id v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_legacy_event : track_event_legacy_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_legacy_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_name_field : track_event_name_field -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_name_field v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_counter_value_field : track_event_counter_value_field -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_counter_value_field v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_correlation_id_field : track_event_correlation_id_field -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_correlation_id_field v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_callstack_field : track_event_callstack_field -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_callstack_field v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_source_location_field : track_event_source_location_field -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_source_location_field v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_timestamp : track_event_timestamp -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_timestamp v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_thread_time : track_event_thread_time -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_thread_time v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_thread_instruction_count : track_event_thread_instruction_count -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_thread_instruction_count v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event : track_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_defaults : track_event_defaults -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_defaults v encoder] encodes [v] with the given [encoder] *)

val encode_pb_event_category : event_category -> Pbrt.Encoder.t -> unit
(** [encode_pb_event_category v encoder] encodes [v] with the given [encoder] *)

val encode_pb_event_name : event_name -> Pbrt.Encoder.t -> unit
(** [encode_pb_event_name v encoder] encodes [v] with the given [encoder] *)

val encode_pb_interned_data : interned_data -> Pbrt.Encoder.t -> unit
(** [encode_pb_interned_data v encoder] encodes [v] with the given [encoder] *)

val encode_pb_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units -> Pbrt.Encoder.t -> unit
(** [encode_pb_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry_units v encoder] encodes [v] with the given [encoder] *)

val encode_pb_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry : memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry -> Pbrt.Encoder.t -> unit
(** [encode_pb_memory_tracker_snapshot_process_snapshot_memory_node_memory_node_entry v encoder] encodes [v] with the given [encoder] *)

val encode_pb_memory_tracker_snapshot_process_snapshot_memory_node : memory_tracker_snapshot_process_snapshot_memory_node -> Pbrt.Encoder.t -> unit
(** [encode_pb_memory_tracker_snapshot_process_snapshot_memory_node v encoder] encodes [v] with the given [encoder] *)

val encode_pb_memory_tracker_snapshot_process_snapshot_memory_edge : memory_tracker_snapshot_process_snapshot_memory_edge -> Pbrt.Encoder.t -> unit
(** [encode_pb_memory_tracker_snapshot_process_snapshot_memory_edge v encoder] encodes [v] with the given [encoder] *)

val encode_pb_memory_tracker_snapshot_process_snapshot : memory_tracker_snapshot_process_snapshot -> Pbrt.Encoder.t -> unit
(** [encode_pb_memory_tracker_snapshot_process_snapshot v encoder] encodes [v] with the given [encoder] *)

val encode_pb_memory_tracker_snapshot_level_of_detail : memory_tracker_snapshot_level_of_detail -> Pbrt.Encoder.t -> unit
(** [encode_pb_memory_tracker_snapshot_level_of_detail v encoder] encodes [v] with the given [encoder] *)

val encode_pb_memory_tracker_snapshot : memory_tracker_snapshot -> Pbrt.Encoder.t -> unit
(** [encode_pb_memory_tracker_snapshot v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perfetto_metatrace_arg_key_or_interned_key : perfetto_metatrace_arg_key_or_interned_key -> Pbrt.Encoder.t -> unit
(** [encode_pb_perfetto_metatrace_arg_key_or_interned_key v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perfetto_metatrace_arg_value_or_interned_value : perfetto_metatrace_arg_value_or_interned_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_perfetto_metatrace_arg_value_or_interned_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perfetto_metatrace_arg : perfetto_metatrace_arg -> Pbrt.Encoder.t -> unit
(** [encode_pb_perfetto_metatrace_arg v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perfetto_metatrace_interned_string : perfetto_metatrace_interned_string -> Pbrt.Encoder.t -> unit
(** [encode_pb_perfetto_metatrace_interned_string v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perfetto_metatrace_record_type : perfetto_metatrace_record_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_perfetto_metatrace_record_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perfetto_metatrace : perfetto_metatrace -> Pbrt.Encoder.t -> unit
(** [encode_pb_perfetto_metatrace v encoder] encodes [v] with the given [encoder] *)

val encode_pb_tracing_service_event_data_sources_data_source : tracing_service_event_data_sources_data_source -> Pbrt.Encoder.t -> unit
(** [encode_pb_tracing_service_event_data_sources_data_source v encoder] encodes [v] with the given [encoder] *)

val encode_pb_tracing_service_event_data_sources : tracing_service_event_data_sources -> Pbrt.Encoder.t -> unit
(** [encode_pb_tracing_service_event_data_sources v encoder] encodes [v] with the given [encoder] *)

val encode_pb_tracing_service_event : tracing_service_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_tracing_service_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_android_energy_consumer : android_energy_consumer -> Pbrt.Encoder.t -> unit
(** [encode_pb_android_energy_consumer v encoder] encodes [v] with the given [encoder] *)

val encode_pb_android_energy_consumer_descriptor : android_energy_consumer_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_android_energy_consumer_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_android_energy_estimation_breakdown_energy_uid_breakdown : android_energy_estimation_breakdown_energy_uid_breakdown -> Pbrt.Encoder.t -> unit
(** [encode_pb_android_energy_estimation_breakdown_energy_uid_breakdown v encoder] encodes [v] with the given [encoder] *)

val encode_pb_android_energy_estimation_breakdown : android_energy_estimation_breakdown -> Pbrt.Encoder.t -> unit
(** [encode_pb_android_energy_estimation_breakdown v encoder] encodes [v] with the given [encoder] *)

val encode_pb_entity_state_residency_power_entity_state : entity_state_residency_power_entity_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_entity_state_residency_power_entity_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_entity_state_residency_state_residency : entity_state_residency_state_residency -> Pbrt.Encoder.t -> unit
(** [encode_pb_entity_state_residency_state_residency v encoder] encodes [v] with the given [encoder] *)

val encode_pb_entity_state_residency : entity_state_residency -> Pbrt.Encoder.t -> unit
(** [encode_pb_entity_state_residency v encoder] encodes [v] with the given [encoder] *)

val encode_pb_battery_counters : battery_counters -> Pbrt.Encoder.t -> unit
(** [encode_pb_battery_counters v encoder] encodes [v] with the given [encoder] *)

val encode_pb_power_rails_rail_descriptor : power_rails_rail_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_power_rails_rail_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_power_rails_energy_data : power_rails_energy_data -> Pbrt.Encoder.t -> unit
(** [encode_pb_power_rails_energy_data v encoder] encodes [v] with the given [encoder] *)

val encode_pb_power_rails : power_rails -> Pbrt.Encoder.t -> unit
(** [encode_pb_power_rails v encoder] encodes [v] with the given [encoder] *)

val encode_pb_obfuscated_member : obfuscated_member -> Pbrt.Encoder.t -> unit
(** [encode_pb_obfuscated_member v encoder] encodes [v] with the given [encoder] *)

val encode_pb_obfuscated_class : obfuscated_class -> Pbrt.Encoder.t -> unit
(** [encode_pb_obfuscated_class v encoder] encodes [v] with the given [encoder] *)

val encode_pb_deobfuscation_mapping : deobfuscation_mapping -> Pbrt.Encoder.t -> unit
(** [encode_pb_deobfuscation_mapping v encoder] encodes [v] with the given [encoder] *)

val encode_pb_heap_graph_root_type : heap_graph_root_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_heap_graph_root_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_heap_graph_root : heap_graph_root -> Pbrt.Encoder.t -> unit
(** [encode_pb_heap_graph_root v encoder] encodes [v] with the given [encoder] *)

val encode_pb_heap_graph_type_kind : heap_graph_type_kind -> Pbrt.Encoder.t -> unit
(** [encode_pb_heap_graph_type_kind v encoder] encodes [v] with the given [encoder] *)

val encode_pb_heap_graph_type : heap_graph_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_heap_graph_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_heap_graph_object_heap_type : heap_graph_object_heap_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_heap_graph_object_heap_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_heap_graph_object_identifier : heap_graph_object_identifier -> Pbrt.Encoder.t -> unit
(** [encode_pb_heap_graph_object_identifier v encoder] encodes [v] with the given [encoder] *)

val encode_pb_heap_graph_object : heap_graph_object -> Pbrt.Encoder.t -> unit
(** [encode_pb_heap_graph_object v encoder] encodes [v] with the given [encoder] *)

val encode_pb_heap_graph : heap_graph -> Pbrt.Encoder.t -> unit
(** [encode_pb_heap_graph v encoder] encodes [v] with the given [encoder] *)

val encode_pb_profile_packet_heap_sample : profile_packet_heap_sample -> Pbrt.Encoder.t -> unit
(** [encode_pb_profile_packet_heap_sample v encoder] encodes [v] with the given [encoder] *)

val encode_pb_profile_packet_histogram_bucket : profile_packet_histogram_bucket -> Pbrt.Encoder.t -> unit
(** [encode_pb_profile_packet_histogram_bucket v encoder] encodes [v] with the given [encoder] *)

val encode_pb_profile_packet_histogram : profile_packet_histogram -> Pbrt.Encoder.t -> unit
(** [encode_pb_profile_packet_histogram v encoder] encodes [v] with the given [encoder] *)

val encode_pb_profile_packet_process_stats : profile_packet_process_stats -> Pbrt.Encoder.t -> unit
(** [encode_pb_profile_packet_process_stats v encoder] encodes [v] with the given [encoder] *)

val encode_pb_profile_packet_process_heap_samples_client_error : profile_packet_process_heap_samples_client_error -> Pbrt.Encoder.t -> unit
(** [encode_pb_profile_packet_process_heap_samples_client_error v encoder] encodes [v] with the given [encoder] *)

val encode_pb_profile_packet_process_heap_samples : profile_packet_process_heap_samples -> Pbrt.Encoder.t -> unit
(** [encode_pb_profile_packet_process_heap_samples v encoder] encodes [v] with the given [encoder] *)

val encode_pb_profile_packet : profile_packet -> Pbrt.Encoder.t -> unit
(** [encode_pb_profile_packet v encoder] encodes [v] with the given [encoder] *)

val encode_pb_streaming_allocation : streaming_allocation -> Pbrt.Encoder.t -> unit
(** [encode_pb_streaming_allocation v encoder] encodes [v] with the given [encoder] *)

val encode_pb_streaming_free : streaming_free -> Pbrt.Encoder.t -> unit
(** [encode_pb_streaming_free v encoder] encodes [v] with the given [encoder] *)

val encode_pb_streaming_profile_packet : streaming_profile_packet -> Pbrt.Encoder.t -> unit
(** [encode_pb_streaming_profile_packet v encoder] encodes [v] with the given [encoder] *)

val encode_pb_profiling_cpu_mode : profiling_cpu_mode -> Pbrt.Encoder.t -> unit
(** [encode_pb_profiling_cpu_mode v encoder] encodes [v] with the given [encoder] *)

val encode_pb_profiling_stack_unwind_error : profiling_stack_unwind_error -> Pbrt.Encoder.t -> unit
(** [encode_pb_profiling_stack_unwind_error v encoder] encodes [v] with the given [encoder] *)

val encode_pb_profiling : profiling -> Pbrt.Encoder.t -> unit
(** [encode_pb_profiling v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perf_sample_sample_skip_reason : perf_sample_sample_skip_reason -> Pbrt.Encoder.t -> unit
(** [encode_pb_perf_sample_sample_skip_reason v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perf_sample_producer_event_data_source_stop_reason : perf_sample_producer_event_data_source_stop_reason -> Pbrt.Encoder.t -> unit
(** [encode_pb_perf_sample_producer_event_data_source_stop_reason v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perf_sample_producer_event : perf_sample_producer_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_perf_sample_producer_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perf_sample_optional_unwind_error : perf_sample_optional_unwind_error -> Pbrt.Encoder.t -> unit
(** [encode_pb_perf_sample_optional_unwind_error v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perf_sample_optional_sample_skipped_reason : perf_sample_optional_sample_skipped_reason -> Pbrt.Encoder.t -> unit
(** [encode_pb_perf_sample_optional_sample_skipped_reason v encoder] encodes [v] with the given [encoder] *)

val encode_pb_perf_sample : perf_sample -> Pbrt.Encoder.t -> unit
(** [encode_pb_perf_sample v encoder] encodes [v] with the given [encoder] *)

val encode_pb_smaps_entry : smaps_entry -> Pbrt.Encoder.t -> unit
(** [encode_pb_smaps_entry v encoder] encodes [v] with the given [encoder] *)

val encode_pb_smaps_packet : smaps_packet -> Pbrt.Encoder.t -> unit
(** [encode_pb_smaps_packet v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_stats_thread : process_stats_thread -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_stats_thread v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_stats_fdinfo : process_stats_fdinfo -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_stats_fdinfo v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_stats_process : process_stats_process -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_stats_process v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_stats : process_stats -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_stats v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_tree_thread : process_tree_thread -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_tree_thread v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_tree_process : process_tree_process -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_tree_process v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_tree : process_tree -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_tree v encoder] encodes [v] with the given [encoder] *)

val encode_pb_remote_clock_sync_synced_clocks : remote_clock_sync_synced_clocks -> Pbrt.Encoder.t -> unit
(** [encode_pb_remote_clock_sync_synced_clocks v encoder] encodes [v] with the given [encoder] *)

val encode_pb_remote_clock_sync : remote_clock_sync -> Pbrt.Encoder.t -> unit
(** [encode_pb_remote_clock_sync v encoder] encodes [v] with the given [encoder] *)

val encode_pb_atom : atom -> Pbrt.Encoder.t -> unit
(** [encode_pb_atom v encoder] encodes [v] with the given [encoder] *)

val encode_pb_statsd_atom : statsd_atom -> Pbrt.Encoder.t -> unit
(** [encode_pb_statsd_atom v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_meminfo_value : sys_stats_meminfo_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_meminfo_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_vmstat_value : sys_stats_vmstat_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_vmstat_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_cpu_times : sys_stats_cpu_times -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_cpu_times v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_interrupt_count : sys_stats_interrupt_count -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_interrupt_count v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_devfreq_value : sys_stats_devfreq_value -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_devfreq_value v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_buddy_info : sys_stats_buddy_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_buddy_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_disk_stat : sys_stats_disk_stat -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_disk_stat v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_psi_sample_psi_resource : sys_stats_psi_sample_psi_resource -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_psi_sample_psi_resource v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_psi_sample : sys_stats_psi_sample -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_psi_sample v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_thermal_zone : sys_stats_thermal_zone -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_thermal_zone v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_cpu_idle_state_entry : sys_stats_cpu_idle_state_entry -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_cpu_idle_state_entry v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats_cpu_idle_state : sys_stats_cpu_idle_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats_cpu_idle_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_sys_stats : sys_stats -> Pbrt.Encoder.t -> unit
(** [encode_pb_sys_stats v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cpu_info_arm_cpu_identifier : cpu_info_arm_cpu_identifier -> Pbrt.Encoder.t -> unit
(** [encode_pb_cpu_info_arm_cpu_identifier v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cpu_info_cpu_identifier : cpu_info_cpu_identifier -> Pbrt.Encoder.t -> unit
(** [encode_pb_cpu_info_cpu_identifier v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cpu_info_cpu : cpu_info_cpu -> Pbrt.Encoder.t -> unit
(** [encode_pb_cpu_info_cpu v encoder] encodes [v] with the given [encoder] *)

val encode_pb_cpu_info : cpu_info -> Pbrt.Encoder.t -> unit
(** [encode_pb_cpu_info v encoder] encodes [v] with the given [encoder] *)

val encode_pb_test_event_test_payload : test_event_test_payload -> Pbrt.Encoder.t -> unit
(** [encode_pb_test_event_test_payload v encoder] encodes [v] with the given [encoder] *)

val encode_pb_test_event : test_event -> Pbrt.Encoder.t -> unit
(** [encode_pb_test_event v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_packet_defaults : trace_packet_defaults -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_packet_defaults v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_uuid : trace_uuid -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_uuid v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_descriptor_chrome_process_type : process_descriptor_chrome_process_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_descriptor_chrome_process_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_descriptor : process_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_event_range_of_interest : track_event_range_of_interest -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_event_range_of_interest v encoder] encodes [v] with the given [encoder] *)

val encode_pb_thread_descriptor_chrome_thread_type : thread_descriptor_chrome_thread_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_thread_descriptor_chrome_thread_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_thread_descriptor : thread_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_thread_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_process_descriptor : chrome_process_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_process_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_thread_descriptor : chrome_thread_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_thread_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_counter_descriptor_builtin_counter_type : counter_descriptor_builtin_counter_type -> Pbrt.Encoder.t -> unit
(** [encode_pb_counter_descriptor_builtin_counter_type v encoder] encodes [v] with the given [encoder] *)

val encode_pb_counter_descriptor_unit : counter_descriptor_unit -> Pbrt.Encoder.t -> unit
(** [encode_pb_counter_descriptor_unit v encoder] encodes [v] with the given [encoder] *)

val encode_pb_counter_descriptor : counter_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_counter_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_descriptor_child_tracks_ordering : track_descriptor_child_tracks_ordering -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_descriptor_child_tracks_ordering v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_descriptor_sibling_merge_behavior : track_descriptor_sibling_merge_behavior -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_descriptor_sibling_merge_behavior v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_descriptor_static_or_dynamic_name : track_descriptor_static_or_dynamic_name -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_descriptor_static_or_dynamic_name v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_descriptor_sibling_merge_key_field : track_descriptor_sibling_merge_key_field -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_descriptor_sibling_merge_key_field v encoder] encodes [v] with the given [encoder] *)

val encode_pb_track_descriptor : track_descriptor -> Pbrt.Encoder.t -> unit
(** [encode_pb_track_descriptor v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_historgram_translation_table : chrome_historgram_translation_table -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_historgram_translation_table v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_user_event_translation_table : chrome_user_event_translation_table -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_user_event_translation_table v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_performance_mark_translation_table : chrome_performance_mark_translation_table -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_performance_mark_translation_table v encoder] encodes [v] with the given [encoder] *)

val encode_pb_slice_name_translation_table : slice_name_translation_table -> Pbrt.Encoder.t -> unit
(** [encode_pb_slice_name_translation_table v encoder] encodes [v] with the given [encoder] *)

val encode_pb_process_track_name_translation_table : process_track_name_translation_table -> Pbrt.Encoder.t -> unit
(** [encode_pb_process_track_name_translation_table v encoder] encodes [v] with the given [encoder] *)

val encode_pb_chrome_study_translation_table : chrome_study_translation_table -> Pbrt.Encoder.t -> unit
(** [encode_pb_chrome_study_translation_table v encoder] encodes [v] with the given [encoder] *)

val encode_pb_translation_table : translation_table -> Pbrt.Encoder.t -> unit
(** [encode_pb_translation_table v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trigger : trigger -> Pbrt.Encoder.t -> unit
(** [encode_pb_trigger v encoder] encodes [v] with the given [encoder] *)

val encode_pb_ui_state_highlight_process : ui_state_highlight_process -> Pbrt.Encoder.t -> unit
(** [encode_pb_ui_state_highlight_process v encoder] encodes [v] with the given [encoder] *)

val encode_pb_ui_state : ui_state -> Pbrt.Encoder.t -> unit
(** [encode_pb_ui_state v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_packet_sequence_flags : trace_packet_sequence_flags -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_packet_sequence_flags v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_packet_data : trace_packet_data -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_packet_data v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_packet_optional_trusted_uid : trace_packet_optional_trusted_uid -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_packet_optional_trusted_uid v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_packet_optional_trusted_packet_sequence_id : trace_packet_optional_trusted_packet_sequence_id -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_packet_optional_trusted_packet_sequence_id v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace_packet : trace_packet -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace_packet v encoder] encodes [v] with the given [encoder] *)

val encode_pb_trace : trace -> Pbrt.Encoder.t -> unit
(** [encode_pb_trace v encoder] encodes [v] with the given [encoder] *)


(** {2 Protobuf Decoding} *)
