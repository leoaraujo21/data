--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.2)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


--
-- Name: component; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- Name: credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


--
-- Name: org; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000)
);


--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
47138e55-9338-46e3-9336-193efca24a03	\N	auth-cookie	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	667eda56-2926-4fb7-a829-ee32d2640fb1	2	10	f	\N	\N
72432467-8577-4ad0-9405-e819ebc4e70c	\N	auth-spnego	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	667eda56-2926-4fb7-a829-ee32d2640fb1	3	20	f	\N	\N
d8ce9e13-fc10-45f1-962d-f0f29165d342	\N	identity-provider-redirector	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	667eda56-2926-4fb7-a829-ee32d2640fb1	2	25	f	\N	\N
96d9c579-f3b7-4e46-889d-07201f0f0354	\N	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	667eda56-2926-4fb7-a829-ee32d2640fb1	2	30	t	51509e8e-d053-4969-bff8-ae21f0ee5cb9	\N
dcbb98da-8803-405d-939d-5926af2529ca	\N	auth-username-password-form	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	51509e8e-d053-4969-bff8-ae21f0ee5cb9	0	10	f	\N	\N
6b917c8e-098d-45a2-96c6-f6c60069d85d	\N	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	51509e8e-d053-4969-bff8-ae21f0ee5cb9	1	20	t	1308157b-9619-46a6-af09-bfdf4c784094	\N
49b4290f-bec7-4d42-8f3c-f646f003fa57	\N	conditional-user-configured	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	1308157b-9619-46a6-af09-bfdf4c784094	0	10	f	\N	\N
a1878bee-d091-4a00-be98-d7a5c137aae0	\N	auth-otp-form	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	1308157b-9619-46a6-af09-bfdf4c784094	0	20	f	\N	\N
591500f9-6e0f-4a13-a9c4-4ad204d5ae95	\N	direct-grant-validate-username	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	9426d063-5d1b-4b67-a473-0fb056c38056	0	10	f	\N	\N
46f757e0-10ba-4d9b-950b-c94de402e6d5	\N	direct-grant-validate-password	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	9426d063-5d1b-4b67-a473-0fb056c38056	0	20	f	\N	\N
fe106675-af42-41f6-a1fb-676a80f93c55	\N	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	9426d063-5d1b-4b67-a473-0fb056c38056	1	30	t	ff091486-fd02-453a-aac1-c858adce4198	\N
e569ab0c-e8eb-4cc3-a235-d0fe84c40dab	\N	conditional-user-configured	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	ff091486-fd02-453a-aac1-c858adce4198	0	10	f	\N	\N
0dd79c3c-16c9-4f6f-9370-ebd5bfa0d0ba	\N	direct-grant-validate-otp	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	ff091486-fd02-453a-aac1-c858adce4198	0	20	f	\N	\N
3703c16d-b64e-4517-a9c9-a019dd35dabf	\N	registration-page-form	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	31a19008-28de-4083-a46c-f2d66bb2239d	0	10	t	8617fc70-8916-4d12-b1cb-b6efe9e3c67e	\N
bc42e751-4028-4a84-97ea-a46dc6345ccf	\N	registration-user-creation	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	8617fc70-8916-4d12-b1cb-b6efe9e3c67e	0	20	f	\N	\N
bd15cca5-2df3-4d93-a570-cd66f15589f4	\N	registration-password-action	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	8617fc70-8916-4d12-b1cb-b6efe9e3c67e	0	50	f	\N	\N
f383f59c-bf8c-430b-8bb0-a92ca3ed760b	\N	registration-recaptcha-action	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	8617fc70-8916-4d12-b1cb-b6efe9e3c67e	3	60	f	\N	\N
f78d9bb9-4918-402f-98ef-cbef6c22e3f5	\N	registration-terms-and-conditions	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	8617fc70-8916-4d12-b1cb-b6efe9e3c67e	3	70	f	\N	\N
07332658-94c3-4ce8-b261-0c4506215766	\N	reset-credentials-choose-user	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	d5a8bf4d-f4bf-4188-9ab2-6650a671af82	0	10	f	\N	\N
6b2b8cae-3c94-4a88-bade-ec65c59be09b	\N	reset-credential-email	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	d5a8bf4d-f4bf-4188-9ab2-6650a671af82	0	20	f	\N	\N
a9979e3d-a543-4fe1-b84f-1784ced00e30	\N	reset-password	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	d5a8bf4d-f4bf-4188-9ab2-6650a671af82	0	30	f	\N	\N
4611ff21-26ec-485c-b32d-73178ae5d531	\N	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	d5a8bf4d-f4bf-4188-9ab2-6650a671af82	1	40	t	52f8c3b9-f41a-4e9a-b955-17895784658f	\N
6d233cc4-32f6-4295-8d2b-a34d9fe6f8e5	\N	conditional-user-configured	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	52f8c3b9-f41a-4e9a-b955-17895784658f	0	10	f	\N	\N
87e77fa0-e4d8-4145-8053-566233fb496c	\N	reset-otp	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	52f8c3b9-f41a-4e9a-b955-17895784658f	0	20	f	\N	\N
1f86c9b2-2c86-4363-952a-05ab92235064	\N	client-secret	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	65f165d1-74a8-48f5-a3bc-3096e70c4c37	2	10	f	\N	\N
0c3ab3f2-b8e2-4cd3-8994-fd559acd6d64	\N	client-jwt	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	65f165d1-74a8-48f5-a3bc-3096e70c4c37	2	20	f	\N	\N
8b2fe360-66dc-427b-8a25-d906a62f1539	\N	client-secret-jwt	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	65f165d1-74a8-48f5-a3bc-3096e70c4c37	2	30	f	\N	\N
dc368bde-6cee-40af-bd0c-e17ce9364d0d	\N	client-x509	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	65f165d1-74a8-48f5-a3bc-3096e70c4c37	2	40	f	\N	\N
0d9a916e-a9da-4658-807b-f4c8dffe862f	\N	idp-review-profile	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	5e000103-921d-410a-9d7f-39fcc5817ed5	0	10	f	\N	60fbe942-759d-46f8-ab47-0f886fd7cd3c
9e53118a-c585-485a-ba7b-09cb18e8d59f	\N	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	5e000103-921d-410a-9d7f-39fcc5817ed5	0	20	t	425a9e76-56da-4d33-8363-851ad2688fd2	\N
3f20d542-1a44-493f-a9ed-58492fb245f0	\N	idp-create-user-if-unique	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	425a9e76-56da-4d33-8363-851ad2688fd2	2	10	f	\N	11fe9e06-9c13-4706-8d71-b5fe71948b0c
4b4dfffd-b361-4f82-a805-e2babe3b0d2a	\N	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	425a9e76-56da-4d33-8363-851ad2688fd2	2	20	t	c58c3fa5-0ae1-4838-a2b9-54f68d364229	\N
a4ae58f7-0e8a-416a-aeeb-c4707f85db74	\N	idp-confirm-link	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c58c3fa5-0ae1-4838-a2b9-54f68d364229	0	10	f	\N	\N
7fd3ac39-5336-42d9-9808-1d738696f6ba	\N	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c58c3fa5-0ae1-4838-a2b9-54f68d364229	0	20	t	50300a60-6285-43f0-bef7-0c9f9a355b12	\N
3b82eabe-920f-437d-b23a-5d72307e1118	\N	idp-email-verification	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	50300a60-6285-43f0-bef7-0c9f9a355b12	2	10	f	\N	\N
e3a9caee-8485-4f3a-9c04-cd42b081bdea	\N	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	50300a60-6285-43f0-bef7-0c9f9a355b12	2	20	t	67ad8dd2-7b9e-4ec6-9c61-edcc17f96bf8	\N
609e5d0c-a178-4124-bcbb-bb1ba4ea1847	\N	idp-username-password-form	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	67ad8dd2-7b9e-4ec6-9c61-edcc17f96bf8	0	10	f	\N	\N
581c6eb1-9c0a-4b14-9d36-dd2d3952414c	\N	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	67ad8dd2-7b9e-4ec6-9c61-edcc17f96bf8	1	20	t	6726a81e-8efb-4ecf-adf7-ffc01e4a230d	\N
926a5c47-e3d0-491a-9074-1b2f4806fe57	\N	conditional-user-configured	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	6726a81e-8efb-4ecf-adf7-ffc01e4a230d	0	10	f	\N	\N
8f30b92d-6b71-4b68-a9c2-90ffa6f66a6c	\N	auth-otp-form	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	6726a81e-8efb-4ecf-adf7-ffc01e4a230d	0	20	f	\N	\N
2e098c3c-75d3-451d-9ce6-92e0799b50c7	\N	http-basic-authenticator	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	bdc0d7dc-9c79-4f51-b1e4-6c37086c01ed	0	10	f	\N	\N
8b2e8cb6-6d60-4b1f-b01f-9cb6db01cc43	\N	docker-http-basic-authenticator	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	fdfd1610-7794-4c07-9fa4-f39c96b1e9a0	0	10	f	\N	\N
cb11cc86-5e60-4acc-8f6c-f7ff3ea430d1	\N	idp-email-verification	4cdda7bb-b16f-4448-915c-4ad90afbffb2	65b6b567-cc01-43a9-a054-83cd2ca9f814	2	10	f	\N	\N
957c0bcc-b3a8-45bf-b7e2-0156a7ddeb1d	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	65b6b567-cc01-43a9-a054-83cd2ca9f814	2	20	t	8b103602-eb3c-4e96-8f12-0c2ff1704aba	\N
c081c4d2-fa79-4d9a-930b-fb0dc8263ef6	\N	conditional-user-configured	4cdda7bb-b16f-4448-915c-4ad90afbffb2	80c1992b-d285-477d-9d2a-81dcefeb2328	0	10	f	\N	\N
dff5cbd7-4720-402e-aaf3-84211587595b	\N	auth-otp-form	4cdda7bb-b16f-4448-915c-4ad90afbffb2	80c1992b-d285-477d-9d2a-81dcefeb2328	0	20	f	\N	\N
1a511648-9dc2-4425-aa69-d1724f7051ca	\N	conditional-user-configured	4cdda7bb-b16f-4448-915c-4ad90afbffb2	1e9eedde-aa65-4124-bebf-eb4b2aae521b	0	10	f	\N	\N
88a6b752-0c40-45b9-97dc-fc64641495b5	\N	direct-grant-validate-otp	4cdda7bb-b16f-4448-915c-4ad90afbffb2	1e9eedde-aa65-4124-bebf-eb4b2aae521b	0	20	f	\N	\N
b806f6d5-7094-45ed-8ce3-2f30b5955218	\N	conditional-user-configured	4cdda7bb-b16f-4448-915c-4ad90afbffb2	ef43dbaa-0a87-45ab-8ff7-ec7714b16e3e	0	10	f	\N	\N
2488b040-9207-4fa8-b03a-732e7af10c29	\N	auth-otp-form	4cdda7bb-b16f-4448-915c-4ad90afbffb2	ef43dbaa-0a87-45ab-8ff7-ec7714b16e3e	0	20	f	\N	\N
8274497d-e0b1-4218-a46e-7f6976732a84	\N	idp-confirm-link	4cdda7bb-b16f-4448-915c-4ad90afbffb2	b9de21cc-b3fe-4efa-9f31-ff558f566d70	0	10	f	\N	\N
4e27f4d8-ee58-4b90-924b-e821f2e53acc	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	b9de21cc-b3fe-4efa-9f31-ff558f566d70	0	20	t	65b6b567-cc01-43a9-a054-83cd2ca9f814	\N
c94786e2-7eb5-4736-bb7f-0aca3c09e88c	\N	conditional-user-configured	4cdda7bb-b16f-4448-915c-4ad90afbffb2	564c0777-ef78-4ab0-ba9e-89785267b7b2	0	10	f	\N	\N
a78acd4a-9840-4819-b814-bdcfc11f1164	\N	reset-otp	4cdda7bb-b16f-4448-915c-4ad90afbffb2	564c0777-ef78-4ab0-ba9e-89785267b7b2	0	20	f	\N	\N
64428723-f13c-456f-bcd1-26ad57c993ea	\N	idp-create-user-if-unique	4cdda7bb-b16f-4448-915c-4ad90afbffb2	68e7845d-54a5-4fc6-ad93-1e6bf7a188f0	2	10	f	\N	7b1fa458-8315-453a-8e66-4cca964f766b
e5758997-b49d-491d-a03f-fbc5d3f460bd	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	68e7845d-54a5-4fc6-ad93-1e6bf7a188f0	2	20	t	b9de21cc-b3fe-4efa-9f31-ff558f566d70	\N
4548fd09-12ee-4bf1-bbdb-565728e38325	\N	idp-username-password-form	4cdda7bb-b16f-4448-915c-4ad90afbffb2	8b103602-eb3c-4e96-8f12-0c2ff1704aba	0	10	f	\N	\N
76c515f8-5a64-4188-b35d-b5878802b573	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	8b103602-eb3c-4e96-8f12-0c2ff1704aba	1	20	t	ef43dbaa-0a87-45ab-8ff7-ec7714b16e3e	\N
d08a73de-0dd8-4187-908e-6ec22ef8b205	\N	auth-cookie	4cdda7bb-b16f-4448-915c-4ad90afbffb2	be7df27c-e6b9-4171-8b24-60c9c8fc3857	2	10	f	\N	\N
7d9ff840-e3eb-4dc9-907c-5442902afe08	\N	auth-spnego	4cdda7bb-b16f-4448-915c-4ad90afbffb2	be7df27c-e6b9-4171-8b24-60c9c8fc3857	3	20	f	\N	\N
ec901285-a01c-42b3-8d12-c372b6909159	\N	identity-provider-redirector	4cdda7bb-b16f-4448-915c-4ad90afbffb2	be7df27c-e6b9-4171-8b24-60c9c8fc3857	2	25	f	\N	\N
22567aa4-13c4-410c-9df8-76a800be93c4	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	be7df27c-e6b9-4171-8b24-60c9c8fc3857	2	30	t	89f649f5-3c93-4807-ab1f-0ed26bdc48f7	\N
b52a166c-08e0-447d-9764-71cab5a580a9	\N	client-secret	4cdda7bb-b16f-4448-915c-4ad90afbffb2	9bd766fc-337a-4a92-acf3-4efdfbf5ec82	2	10	f	\N	\N
ad33595d-b29c-4291-b28f-a929b7540653	\N	client-jwt	4cdda7bb-b16f-4448-915c-4ad90afbffb2	9bd766fc-337a-4a92-acf3-4efdfbf5ec82	2	20	f	\N	\N
7bf468aa-844d-4622-97a2-54b36367a7b0	\N	client-secret-jwt	4cdda7bb-b16f-4448-915c-4ad90afbffb2	9bd766fc-337a-4a92-acf3-4efdfbf5ec82	2	30	f	\N	\N
b5df5ea7-d0a9-46b1-b464-ec51fec9395f	\N	client-x509	4cdda7bb-b16f-4448-915c-4ad90afbffb2	9bd766fc-337a-4a92-acf3-4efdfbf5ec82	2	40	f	\N	\N
f068535d-b61e-4ac6-b407-d7610cb467f9	\N	direct-grant-validate-username	4cdda7bb-b16f-4448-915c-4ad90afbffb2	9d39d6ed-eaba-4d17-aba9-3eef2f97082d	0	10	f	\N	\N
844f8f45-ba96-4e7a-8a2b-7121d004bcda	\N	direct-grant-validate-password	4cdda7bb-b16f-4448-915c-4ad90afbffb2	9d39d6ed-eaba-4d17-aba9-3eef2f97082d	0	20	f	\N	\N
d9516fec-0bc4-445b-86be-923b3eb0bcdc	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	9d39d6ed-eaba-4d17-aba9-3eef2f97082d	1	30	t	1e9eedde-aa65-4124-bebf-eb4b2aae521b	\N
05b97e71-2dcc-4205-a91b-fb50d44bd930	\N	docker-http-basic-authenticator	4cdda7bb-b16f-4448-915c-4ad90afbffb2	9e91afc9-1c94-4ad1-b2b5-7ce4a2b8a3d3	0	10	f	\N	\N
a9972db6-67ce-4369-80e9-ec8448562976	\N	idp-review-profile	4cdda7bb-b16f-4448-915c-4ad90afbffb2	30f219ab-2998-419b-8457-9d01df1d96d0	0	10	f	\N	bbd99a30-2ba7-4063-9080-6d7786955dc8
6caeda98-6f53-4835-bb0f-08d5a5d02dd3	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	30f219ab-2998-419b-8457-9d01df1d96d0	0	20	t	68e7845d-54a5-4fc6-ad93-1e6bf7a188f0	\N
380b6c68-a3f1-4ca2-a9a6-1524bdd1a4a8	\N	auth-username-password-form	4cdda7bb-b16f-4448-915c-4ad90afbffb2	89f649f5-3c93-4807-ab1f-0ed26bdc48f7	0	10	f	\N	\N
d6953411-4c03-460c-9729-2dc7414c9b5a	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	89f649f5-3c93-4807-ab1f-0ed26bdc48f7	1	20	t	80c1992b-d285-477d-9d2a-81dcefeb2328	\N
a525b110-181d-4e7f-9164-f28c87b221d2	\N	registration-page-form	4cdda7bb-b16f-4448-915c-4ad90afbffb2	ace4bb7d-ecb4-4dc7-8694-6e7ac6cdacbf	0	10	t	49e44eff-a2ff-4ff5-82e1-c3fc378cc0ec	\N
30c7e648-e17f-4482-ac86-6e4cef3b3fa4	\N	registration-user-creation	4cdda7bb-b16f-4448-915c-4ad90afbffb2	49e44eff-a2ff-4ff5-82e1-c3fc378cc0ec	0	20	f	\N	\N
2e80fdf7-8fd5-4bb2-aa60-d2aeb45e69e6	\N	registration-password-action	4cdda7bb-b16f-4448-915c-4ad90afbffb2	49e44eff-a2ff-4ff5-82e1-c3fc378cc0ec	0	50	f	\N	\N
265b3124-c1f0-4902-8a51-309399c6acaa	\N	registration-recaptcha-action	4cdda7bb-b16f-4448-915c-4ad90afbffb2	49e44eff-a2ff-4ff5-82e1-c3fc378cc0ec	3	60	f	\N	\N
49f7ef37-831c-4620-b45c-45000be8c559	\N	registration-terms-and-conditions	4cdda7bb-b16f-4448-915c-4ad90afbffb2	49e44eff-a2ff-4ff5-82e1-c3fc378cc0ec	3	70	f	\N	\N
0ca66511-0ff3-4ca5-a238-d62f31509dfb	\N	reset-credentials-choose-user	4cdda7bb-b16f-4448-915c-4ad90afbffb2	77ce2972-d3ec-4b95-b882-4f8b687edf85	0	10	f	\N	\N
e114be5c-e2cc-4c97-aa4b-c8c464520164	\N	reset-credential-email	4cdda7bb-b16f-4448-915c-4ad90afbffb2	77ce2972-d3ec-4b95-b882-4f8b687edf85	0	20	f	\N	\N
23b8fe24-9354-4b1c-8b84-4edf33c4b8d8	\N	reset-password	4cdda7bb-b16f-4448-915c-4ad90afbffb2	77ce2972-d3ec-4b95-b882-4f8b687edf85	0	30	f	\N	\N
fe8a2434-c57b-4ab0-b2d4-a556009e0600	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	77ce2972-d3ec-4b95-b882-4f8b687edf85	1	40	t	564c0777-ef78-4ab0-ba9e-89785267b7b2	\N
f38e8b16-caba-4322-805f-9198d49f456d	\N	http-basic-authenticator	4cdda7bb-b16f-4448-915c-4ad90afbffb2	a36a56a9-0582-4161-90a9-e95bceb2636d	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
667eda56-2926-4fb7-a829-ee32d2640fb1	browser	browser based authentication	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	t	t
51509e8e-d053-4969-bff8-ae21f0ee5cb9	forms	Username, password, otp and other auth forms.	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	f	t
1308157b-9619-46a6-af09-bfdf4c784094	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	f	t
9426d063-5d1b-4b67-a473-0fb056c38056	direct grant	OpenID Connect Resource Owner Grant	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	t	t
ff091486-fd02-453a-aac1-c858adce4198	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	f	t
31a19008-28de-4083-a46c-f2d66bb2239d	registration	registration flow	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	t	t
8617fc70-8916-4d12-b1cb-b6efe9e3c67e	registration form	registration form	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	form-flow	f	t
d5a8bf4d-f4bf-4188-9ab2-6650a671af82	reset credentials	Reset credentials for a user if they forgot their password or something	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	t	t
52f8c3b9-f41a-4e9a-b955-17895784658f	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	f	t
65f165d1-74a8-48f5-a3bc-3096e70c4c37	clients	Base authentication for clients	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	client-flow	t	t
5e000103-921d-410a-9d7f-39fcc5817ed5	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	t	t
425a9e76-56da-4d33-8363-851ad2688fd2	User creation or linking	Flow for the existing/non-existing user alternatives	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	f	t
c58c3fa5-0ae1-4838-a2b9-54f68d364229	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	f	t
50300a60-6285-43f0-bef7-0c9f9a355b12	Account verification options	Method with which to verity the existing account	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	f	t
67ad8dd2-7b9e-4ec6-9c61-edcc17f96bf8	Verify Existing Account by Re-authentication	Reauthentication of existing account	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	f	t
6726a81e-8efb-4ecf-adf7-ffc01e4a230d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	f	t
bdc0d7dc-9c79-4f51-b1e4-6c37086c01ed	saml ecp	SAML ECP Profile Authentication Flow	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	t	t
fdfd1610-7794-4c07-9fa4-f39c96b1e9a0	docker auth	Used by Docker clients to authenticate against the IDP	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	basic-flow	t	t
65b6b567-cc01-43a9-a054-83cd2ca9f814	Account verification options	Method with which to verity the existing account	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	f	t
80c1992b-d285-477d-9d2a-81dcefeb2328	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	f	t
1e9eedde-aa65-4124-bebf-eb4b2aae521b	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	f	t
ef43dbaa-0a87-45ab-8ff7-ec7714b16e3e	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	f	t
b9de21cc-b3fe-4efa-9f31-ff558f566d70	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	f	t
564c0777-ef78-4ab0-ba9e-89785267b7b2	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	f	t
68e7845d-54a5-4fc6-ad93-1e6bf7a188f0	User creation or linking	Flow for the existing/non-existing user alternatives	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	f	t
8b103602-eb3c-4e96-8f12-0c2ff1704aba	Verify Existing Account by Re-authentication	Reauthentication of existing account	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	f	t
be7df27c-e6b9-4171-8b24-60c9c8fc3857	browser	browser based authentication	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	t	t
9bd766fc-337a-4a92-acf3-4efdfbf5ec82	clients	Base authentication for clients	4cdda7bb-b16f-4448-915c-4ad90afbffb2	client-flow	t	t
9d39d6ed-eaba-4d17-aba9-3eef2f97082d	direct grant	OpenID Connect Resource Owner Grant	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	t	t
9e91afc9-1c94-4ad1-b2b5-7ce4a2b8a3d3	docker auth	Used by Docker clients to authenticate against the IDP	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	t	t
30f219ab-2998-419b-8457-9d01df1d96d0	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	t	t
89f649f5-3c93-4807-ab1f-0ed26bdc48f7	forms	Username, password, otp and other auth forms.	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	f	t
ace4bb7d-ecb4-4dc7-8694-6e7ac6cdacbf	registration	registration flow	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	t	t
49e44eff-a2ff-4ff5-82e1-c3fc378cc0ec	registration form	registration form	4cdda7bb-b16f-4448-915c-4ad90afbffb2	form-flow	f	t
77ce2972-d3ec-4b95-b882-4f8b687edf85	reset credentials	Reset credentials for a user if they forgot their password or something	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	t	t
a36a56a9-0582-4161-90a9-e95bceb2636d	saml ecp	SAML ECP Profile Authentication Flow	4cdda7bb-b16f-4448-915c-4ad90afbffb2	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
60fbe942-759d-46f8-ab47-0f886fd7cd3c	review profile config	483ac10f-3abc-4a20-9938-9b40ad1c4a5d
11fe9e06-9c13-4706-8d71-b5fe71948b0c	create unique user config	483ac10f-3abc-4a20-9938-9b40ad1c4a5d
7b1fa458-8315-453a-8e66-4cca964f766b	create unique user config	4cdda7bb-b16f-4448-915c-4ad90afbffb2
bbd99a30-2ba7-4063-9080-6d7786955dc8	review profile config	4cdda7bb-b16f-4448-915c-4ad90afbffb2
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
11fe9e06-9c13-4706-8d71-b5fe71948b0c	false	require.password.update.after.registration
60fbe942-759d-46f8-ab47-0f886fd7cd3c	missing	update.profile.on.first.login
7b1fa458-8315-453a-8e66-4cca964f766b	false	require.password.update.after.registration
bbd99a30-2ba7-4063-9080-6d7786955dc8	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
79b09991-4e56-4792-9cb0-f2948988c907	t	f	master-realm	0	f	\N	\N	t	\N	f	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
39f21afe-a1fc-4125-94bf-7b361860bcc8	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ceaf3397-b419-4940-b783-4d8d3c73a8dd	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	t	f	broker	0	f	\N	\N	t	\N	f	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	t	f	admin-cli	0	t	\N	\N	f	\N	f	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
c5603804-5783-4f30-80cc-add804474cc2	t	f	daniele-banco-realm	0	f	\N	\N	t	\N	f	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N	0	f	f	daniele-banco Realm	f	client-secret	\N	\N	\N	t	f	f	f
0a7d8d6a-4193-451a-85ac-721665940ae0	t	f	account	0	t	\N	/realms/Daniele%20Banco/account/	f	\N	f	4cdda7bb-b16f-4448-915c-4ad90afbffb2	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5903c266-32ac-43b8-8e2e-bd8f8922a41a	t	f	account-console	0	t	\N	/realms/Daniele%20Banco/account/	f	\N	f	4cdda7bb-b16f-4448-915c-4ad90afbffb2	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2729f46a-15d6-4e98-9956-39c417407b44	t	f	admin-cli	0	t	\N	\N	f	\N	f	4cdda7bb-b16f-4448-915c-4ad90afbffb2	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
34d14c6c-c3cc-4504-859d-4d290900aa1a	t	t	modulos-rpa	0	f	WDbWYVVS1j9m3AYbTN0G832YxZuGQV4b		f	https://auth.bpm-daniele.g4tech.com.br	f	4cdda7bb-b16f-4448-915c-4ad90afbffb2	openid-connect	-1	t	f	modulos-rpa	t	client-secret	https://auth.bpm-daniele.g4tech.com.br	Cliente para o serviços que contém os módulos RPA	\N	t	f	t	f
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	t	t	camunda-identity-service	0	f	BnjcXOejztGbuzUVcV2W29DYwDnpGYDS	/	f	https://auth.bpm-daniele.g4tech.com.br	f	4cdda7bb-b16f-4448-915c-4ad90afbffb2	openid-connect	-1	t	f	camunda-identity-service	t	client-secret	https://auth.bpm-daniele.g4tech.com.br	Cliente para login no Camunda	\N	t	f	t	f
5e60f5dc-26e1-488a-a092-bd431f33fffa	t	f	broker	0	f	\N	\N	t	\N	f	4cdda7bb-b16f-4448-915c-4ad90afbffb2	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
4c676429-06af-45e5-9e72-04bb4050bde7	t	t	bpm-api	0	f	3NqCd8tbMjjYahWPTfQn6xMWyoNQAiLZ		f	https://auth.bpm-daniele.g4tech.com.br	f	4cdda7bb-b16f-4448-915c-4ad90afbffb2	openid-connect	-1	t	f	bpm-api	f	client-secret	https://auth.bpm-daniele.g4tech.com.br	Cliente para login na BPM API (Spring)	\N	t	f	t	f
d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	f	realm-management	0	f	\N	\N	t	\N	f	4cdda7bb-b16f-4448-915c-4ad90afbffb2	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	t	f	security-admin-console	0	t	\N	/admin/Daniele%20Banco/console/	f	\N	f	4cdda7bb-b16f-4448-915c-4ad90afbffb2	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
6eda79eb-7f71-42e0-9719-9e9fa18d350f	t	t	bpm-app	0	t	\N	https://app.bpm-daniele.g4tech.com.br	f	https://auth.bpm-daniele.g4tech.com.br	f	4cdda7bb-b16f-4448-915c-4ad90afbffb2	openid-connect	-1	t	f	bpm-app	f	client-secret	https://auth.bpm-daniele.g4tech.com.br		\N	t	t	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
39f21afe-a1fc-4125-94bf-7b361860bcc8	post.logout.redirect.uris	+
ceaf3397-b419-4940-b783-4d8d3c73a8dd	post.logout.redirect.uris	+
ceaf3397-b419-4940-b783-4d8d3c73a8dd	pkce.code.challenge.method	S256
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	post.logout.redirect.uris	+
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	pkce.code.challenge.method	S256
0a7d8d6a-4193-451a-85ac-721665940ae0	post.logout.redirect.uris	+
5903c266-32ac-43b8-8e2e-bd8f8922a41a	post.logout.redirect.uris	+
5903c266-32ac-43b8-8e2e-bd8f8922a41a	pkce.code.challenge.method	S256
2729f46a-15d6-4e98-9956-39c417407b44	post.logout.redirect.uris	+
4c676429-06af-45e5-9e72-04bb4050bde7	oidc.ciba.grant.enabled	false
4c676429-06af-45e5-9e72-04bb4050bde7	backchannel.logout.session.required	true
4c676429-06af-45e5-9e72-04bb4050bde7	oauth2.device.authorization.grant.enabled	false
4c676429-06af-45e5-9e72-04bb4050bde7	backchannel.logout.revoke.offline.tokens	false
4c676429-06af-45e5-9e72-04bb4050bde7	post.logout.redirect.uris	+
5e60f5dc-26e1-488a-a092-bd431f33fffa	post.logout.redirect.uris	+
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	client.introspection.response.allow.jwt.claim.enabled	false
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	post.logout.redirect.uris	/*
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	oauth2.device.authorization.grant.enabled	false
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	backchannel.logout.revoke.offline.tokens	false
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	use.refresh.tokens	true
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	oidc.ciba.grant.enabled	true
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	client.use.lightweight.access.token.enabled	false
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	backchannel.logout.session.required	true
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	client_credentials.use_refresh_token	false
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	acr.loa.map	{}
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	require.pushed.authorization.requests	false
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	tls.client.certificate.bound.access.tokens	false
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	display.on.consent.screen	false
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	token.response.type.bearer.lower-case	false
34d14c6c-c3cc-4504-859d-4d290900aa1a	oidc.ciba.grant.enabled	false
34d14c6c-c3cc-4504-859d-4d290900aa1a	backchannel.logout.session.required	true
34d14c6c-c3cc-4504-859d-4d290900aa1a	oauth2.device.authorization.grant.enabled	false
34d14c6c-c3cc-4504-859d-4d290900aa1a	backchannel.logout.revoke.offline.tokens	false
34d14c6c-c3cc-4504-859d-4d290900aa1a	post.logout.redirect.uris	+
d7c80418-90c3-4ea5-97ff-aece5ab026bf	post.logout.redirect.uris	+
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	post.logout.redirect.uris	+
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	pkce.code.challenge.method	S256
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	client.secret.creation.time	1744138807
4c676429-06af-45e5-9e72-04bb4050bde7	client.secret.creation.time	1744199828
34d14c6c-c3cc-4504-859d-4d290900aa1a	client.secret.creation.time	1744199929
4c676429-06af-45e5-9e72-04bb4050bde7	display.on.consent.screen	false
34d14c6c-c3cc-4504-859d-4d290900aa1a	display.on.consent.screen	false
6eda79eb-7f71-42e0-9719-9e9fa18d350f	client.secret.creation.time	1744201600
6eda79eb-7f71-42e0-9719-9e9fa18d350f	oidc.ciba.grant.enabled	false
6eda79eb-7f71-42e0-9719-9e9fa18d350f	backchannel.logout.session.required	true
6eda79eb-7f71-42e0-9719-9e9fa18d350f	backchannel.logout.revoke.offline.tokens	false
6eda79eb-7f71-42e0-9719-9e9fa18d350f	display.on.consent.screen	false
6eda79eb-7f71-42e0-9719-9e9fa18d350f	post.logout.redirect.uris	/*##*
6eda79eb-7f71-42e0-9719-9e9fa18d350f	oauth2.device.authorization.grant.enabled	true
6eda79eb-7f71-42e0-9719-9e9fa18d350f	login_theme	danielebanco-custom
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
3160c129-6afe-4724-b7bf-08ae27d3a164	offline_access	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	OpenID Connect built-in scope: offline_access	openid-connect
3fef793e-f831-4624-a617-d11d0af78586	role_list	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	SAML role list	saml
eea44f0f-3db3-405e-925e-4ab150fb5844	profile	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	OpenID Connect built-in scope: profile	openid-connect
be2b373a-def4-4c22-bed3-b5073cf42092	email	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	OpenID Connect built-in scope: email	openid-connect
24049a07-b501-4c2e-a999-a7abb967050b	address	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	OpenID Connect built-in scope: address	openid-connect
00e0183d-c34e-446d-a775-15a2c78d255b	phone	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	OpenID Connect built-in scope: phone	openid-connect
9230a8bf-272a-4782-b5d5-a960a0a66eba	roles	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	OpenID Connect scope for add user roles to the access token	openid-connect
d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd	web-origins	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	OpenID Connect scope for add allowed web origins to the access token	openid-connect
34b3b8d3-310a-45c0-bc5f-a71bd6f656b1	microprofile-jwt	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	Microprofile - JWT built-in scope	openid-connect
d3e78bdf-cfdc-4387-8faf-607105bb8cf0	acr	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
75b9de11-dbdf-456b-8bd5-86c6aae3888b	basic	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	OpenID Connect scope for add all basic claims to the token	openid-connect
14378f41-c569-482d-8f9c-3cef47bd0db4	acr	4cdda7bb-b16f-4448-915c-4ad90afbffb2	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
2b179738-6741-4083-927f-b6b2d9339fe5	address	4cdda7bb-b16f-4448-915c-4ad90afbffb2	OpenID Connect built-in scope: address	openid-connect
1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	web-origins	4cdda7bb-b16f-4448-915c-4ad90afbffb2	OpenID Connect scope for add allowed web origins to the access token	openid-connect
4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	basic	4cdda7bb-b16f-4448-915c-4ad90afbffb2	OpenID Connect scope for add all basic claims to the token	openid-connect
a107389c-8359-494f-bb1d-bd74d2bb9b13	offline_access	4cdda7bb-b16f-4448-915c-4ad90afbffb2	OpenID Connect built-in scope: offline_access	openid-connect
ce7a5a46-b4de-4f72-bb9a-29af1d358324	roles	4cdda7bb-b16f-4448-915c-4ad90afbffb2	OpenID Connect scope for add user roles to the access token	openid-connect
2dfe5fb6-8931-4949-be56-b56cf9be2f89	profile	4cdda7bb-b16f-4448-915c-4ad90afbffb2	OpenID Connect built-in scope: profile	openid-connect
9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	email	4cdda7bb-b16f-4448-915c-4ad90afbffb2	OpenID Connect built-in scope: email	openid-connect
891f7bda-5070-4db6-a750-6ea9a504b3d6	phone	4cdda7bb-b16f-4448-915c-4ad90afbffb2	OpenID Connect built-in scope: phone	openid-connect
a6852ef6-16ff-44a8-b1aa-d483e1a47bf6	role_list	4cdda7bb-b16f-4448-915c-4ad90afbffb2	SAML role list	saml
31b1a221-3acf-459d-956a-02fa1b35fd60	microprofile-jwt	4cdda7bb-b16f-4448-915c-4ad90afbffb2	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
3160c129-6afe-4724-b7bf-08ae27d3a164	true	display.on.consent.screen
3160c129-6afe-4724-b7bf-08ae27d3a164	${offlineAccessScopeConsentText}	consent.screen.text
3fef793e-f831-4624-a617-d11d0af78586	true	display.on.consent.screen
3fef793e-f831-4624-a617-d11d0af78586	${samlRoleListScopeConsentText}	consent.screen.text
eea44f0f-3db3-405e-925e-4ab150fb5844	true	display.on.consent.screen
eea44f0f-3db3-405e-925e-4ab150fb5844	${profileScopeConsentText}	consent.screen.text
eea44f0f-3db3-405e-925e-4ab150fb5844	true	include.in.token.scope
be2b373a-def4-4c22-bed3-b5073cf42092	true	display.on.consent.screen
be2b373a-def4-4c22-bed3-b5073cf42092	${emailScopeConsentText}	consent.screen.text
be2b373a-def4-4c22-bed3-b5073cf42092	true	include.in.token.scope
24049a07-b501-4c2e-a999-a7abb967050b	true	display.on.consent.screen
24049a07-b501-4c2e-a999-a7abb967050b	${addressScopeConsentText}	consent.screen.text
24049a07-b501-4c2e-a999-a7abb967050b	true	include.in.token.scope
00e0183d-c34e-446d-a775-15a2c78d255b	true	display.on.consent.screen
00e0183d-c34e-446d-a775-15a2c78d255b	${phoneScopeConsentText}	consent.screen.text
00e0183d-c34e-446d-a775-15a2c78d255b	true	include.in.token.scope
9230a8bf-272a-4782-b5d5-a960a0a66eba	true	display.on.consent.screen
9230a8bf-272a-4782-b5d5-a960a0a66eba	${rolesScopeConsentText}	consent.screen.text
9230a8bf-272a-4782-b5d5-a960a0a66eba	false	include.in.token.scope
d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd	false	display.on.consent.screen
d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd		consent.screen.text
d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd	false	include.in.token.scope
34b3b8d3-310a-45c0-bc5f-a71bd6f656b1	false	display.on.consent.screen
34b3b8d3-310a-45c0-bc5f-a71bd6f656b1	true	include.in.token.scope
d3e78bdf-cfdc-4387-8faf-607105bb8cf0	false	display.on.consent.screen
d3e78bdf-cfdc-4387-8faf-607105bb8cf0	false	include.in.token.scope
75b9de11-dbdf-456b-8bd5-86c6aae3888b	false	display.on.consent.screen
75b9de11-dbdf-456b-8bd5-86c6aae3888b	false	include.in.token.scope
14378f41-c569-482d-8f9c-3cef47bd0db4	false	include.in.token.scope
14378f41-c569-482d-8f9c-3cef47bd0db4	false	display.on.consent.screen
2b179738-6741-4083-927f-b6b2d9339fe5	true	include.in.token.scope
2b179738-6741-4083-927f-b6b2d9339fe5	${addressScopeConsentText}	consent.screen.text
2b179738-6741-4083-927f-b6b2d9339fe5	true	display.on.consent.screen
1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	false	include.in.token.scope
1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3		consent.screen.text
1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	false	display.on.consent.screen
4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	false	include.in.token.scope
4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	false	display.on.consent.screen
a107389c-8359-494f-bb1d-bd74d2bb9b13	${offlineAccessScopeConsentText}	consent.screen.text
a107389c-8359-494f-bb1d-bd74d2bb9b13	true	display.on.consent.screen
ce7a5a46-b4de-4f72-bb9a-29af1d358324	false	include.in.token.scope
ce7a5a46-b4de-4f72-bb9a-29af1d358324	${rolesScopeConsentText}	consent.screen.text
ce7a5a46-b4de-4f72-bb9a-29af1d358324	true	display.on.consent.screen
2dfe5fb6-8931-4949-be56-b56cf9be2f89	true	include.in.token.scope
2dfe5fb6-8931-4949-be56-b56cf9be2f89	${profileScopeConsentText}	consent.screen.text
2dfe5fb6-8931-4949-be56-b56cf9be2f89	true	display.on.consent.screen
9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	true	include.in.token.scope
9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	${emailScopeConsentText}	consent.screen.text
9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	true	display.on.consent.screen
891f7bda-5070-4db6-a750-6ea9a504b3d6	true	include.in.token.scope
891f7bda-5070-4db6-a750-6ea9a504b3d6	${phoneScopeConsentText}	consent.screen.text
891f7bda-5070-4db6-a750-6ea9a504b3d6	true	display.on.consent.screen
a6852ef6-16ff-44a8-b1aa-d483e1a47bf6	${samlRoleListScopeConsentText}	consent.screen.text
a6852ef6-16ff-44a8-b1aa-d483e1a47bf6	true	display.on.consent.screen
31b1a221-3acf-459d-956a-02fa1b35fd60	true	include.in.token.scope
31b1a221-3acf-459d-956a-02fa1b35fd60	false	display.on.consent.screen
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
39f21afe-a1fc-4125-94bf-7b361860bcc8	d3e78bdf-cfdc-4387-8faf-607105bb8cf0	t
39f21afe-a1fc-4125-94bf-7b361860bcc8	eea44f0f-3db3-405e-925e-4ab150fb5844	t
39f21afe-a1fc-4125-94bf-7b361860bcc8	be2b373a-def4-4c22-bed3-b5073cf42092	t
39f21afe-a1fc-4125-94bf-7b361860bcc8	d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd	t
39f21afe-a1fc-4125-94bf-7b361860bcc8	75b9de11-dbdf-456b-8bd5-86c6aae3888b	t
39f21afe-a1fc-4125-94bf-7b361860bcc8	9230a8bf-272a-4782-b5d5-a960a0a66eba	t
39f21afe-a1fc-4125-94bf-7b361860bcc8	34b3b8d3-310a-45c0-bc5f-a71bd6f656b1	f
39f21afe-a1fc-4125-94bf-7b361860bcc8	00e0183d-c34e-446d-a775-15a2c78d255b	f
39f21afe-a1fc-4125-94bf-7b361860bcc8	24049a07-b501-4c2e-a999-a7abb967050b	f
39f21afe-a1fc-4125-94bf-7b361860bcc8	3160c129-6afe-4724-b7bf-08ae27d3a164	f
ceaf3397-b419-4940-b783-4d8d3c73a8dd	d3e78bdf-cfdc-4387-8faf-607105bb8cf0	t
ceaf3397-b419-4940-b783-4d8d3c73a8dd	eea44f0f-3db3-405e-925e-4ab150fb5844	t
ceaf3397-b419-4940-b783-4d8d3c73a8dd	be2b373a-def4-4c22-bed3-b5073cf42092	t
ceaf3397-b419-4940-b783-4d8d3c73a8dd	d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd	t
ceaf3397-b419-4940-b783-4d8d3c73a8dd	75b9de11-dbdf-456b-8bd5-86c6aae3888b	t
ceaf3397-b419-4940-b783-4d8d3c73a8dd	9230a8bf-272a-4782-b5d5-a960a0a66eba	t
ceaf3397-b419-4940-b783-4d8d3c73a8dd	34b3b8d3-310a-45c0-bc5f-a71bd6f656b1	f
ceaf3397-b419-4940-b783-4d8d3c73a8dd	00e0183d-c34e-446d-a775-15a2c78d255b	f
ceaf3397-b419-4940-b783-4d8d3c73a8dd	24049a07-b501-4c2e-a999-a7abb967050b	f
ceaf3397-b419-4940-b783-4d8d3c73a8dd	3160c129-6afe-4724-b7bf-08ae27d3a164	f
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	d3e78bdf-cfdc-4387-8faf-607105bb8cf0	t
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	eea44f0f-3db3-405e-925e-4ab150fb5844	t
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	be2b373a-def4-4c22-bed3-b5073cf42092	t
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd	t
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	75b9de11-dbdf-456b-8bd5-86c6aae3888b	t
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	9230a8bf-272a-4782-b5d5-a960a0a66eba	t
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	34b3b8d3-310a-45c0-bc5f-a71bd6f656b1	f
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	00e0183d-c34e-446d-a775-15a2c78d255b	f
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	24049a07-b501-4c2e-a999-a7abb967050b	f
8f5f82d9-98a8-4d27-a925-3ac8084cd98d	3160c129-6afe-4724-b7bf-08ae27d3a164	f
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	d3e78bdf-cfdc-4387-8faf-607105bb8cf0	t
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	eea44f0f-3db3-405e-925e-4ab150fb5844	t
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	be2b373a-def4-4c22-bed3-b5073cf42092	t
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd	t
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	75b9de11-dbdf-456b-8bd5-86c6aae3888b	t
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	9230a8bf-272a-4782-b5d5-a960a0a66eba	t
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	34b3b8d3-310a-45c0-bc5f-a71bd6f656b1	f
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	00e0183d-c34e-446d-a775-15a2c78d255b	f
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	24049a07-b501-4c2e-a999-a7abb967050b	f
d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	3160c129-6afe-4724-b7bf-08ae27d3a164	f
79b09991-4e56-4792-9cb0-f2948988c907	d3e78bdf-cfdc-4387-8faf-607105bb8cf0	t
79b09991-4e56-4792-9cb0-f2948988c907	eea44f0f-3db3-405e-925e-4ab150fb5844	t
79b09991-4e56-4792-9cb0-f2948988c907	be2b373a-def4-4c22-bed3-b5073cf42092	t
79b09991-4e56-4792-9cb0-f2948988c907	d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd	t
79b09991-4e56-4792-9cb0-f2948988c907	75b9de11-dbdf-456b-8bd5-86c6aae3888b	t
79b09991-4e56-4792-9cb0-f2948988c907	9230a8bf-272a-4782-b5d5-a960a0a66eba	t
79b09991-4e56-4792-9cb0-f2948988c907	34b3b8d3-310a-45c0-bc5f-a71bd6f656b1	f
79b09991-4e56-4792-9cb0-f2948988c907	00e0183d-c34e-446d-a775-15a2c78d255b	f
79b09991-4e56-4792-9cb0-f2948988c907	24049a07-b501-4c2e-a999-a7abb967050b	f
79b09991-4e56-4792-9cb0-f2948988c907	3160c129-6afe-4724-b7bf-08ae27d3a164	f
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	d3e78bdf-cfdc-4387-8faf-607105bb8cf0	t
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	eea44f0f-3db3-405e-925e-4ab150fb5844	t
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	be2b373a-def4-4c22-bed3-b5073cf42092	t
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd	t
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	75b9de11-dbdf-456b-8bd5-86c6aae3888b	t
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	9230a8bf-272a-4782-b5d5-a960a0a66eba	t
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	34b3b8d3-310a-45c0-bc5f-a71bd6f656b1	f
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	00e0183d-c34e-446d-a775-15a2c78d255b	f
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	24049a07-b501-4c2e-a999-a7abb967050b	f
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	3160c129-6afe-4724-b7bf-08ae27d3a164	f
6eda79eb-7f71-42e0-9719-9e9fa18d350f	14378f41-c569-482d-8f9c-3cef47bd0db4	t
6eda79eb-7f71-42e0-9719-9e9fa18d350f	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
6eda79eb-7f71-42e0-9719-9e9fa18d350f	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
6eda79eb-7f71-42e0-9719-9e9fa18d350f	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
6eda79eb-7f71-42e0-9719-9e9fa18d350f	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
6eda79eb-7f71-42e0-9719-9e9fa18d350f	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
6eda79eb-7f71-42e0-9719-9e9fa18d350f	2b179738-6741-4083-927f-b6b2d9339fe5	f
6eda79eb-7f71-42e0-9719-9e9fa18d350f	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
6eda79eb-7f71-42e0-9719-9e9fa18d350f	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
6eda79eb-7f71-42e0-9719-9e9fa18d350f	31b1a221-3acf-459d-956a-02fa1b35fd60	f
0a7d8d6a-4193-451a-85ac-721665940ae0	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
0a7d8d6a-4193-451a-85ac-721665940ae0	14378f41-c569-482d-8f9c-3cef47bd0db4	t
0a7d8d6a-4193-451a-85ac-721665940ae0	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
0a7d8d6a-4193-451a-85ac-721665940ae0	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
0a7d8d6a-4193-451a-85ac-721665940ae0	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
0a7d8d6a-4193-451a-85ac-721665940ae0	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
0a7d8d6a-4193-451a-85ac-721665940ae0	2b179738-6741-4083-927f-b6b2d9339fe5	f
0a7d8d6a-4193-451a-85ac-721665940ae0	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
0a7d8d6a-4193-451a-85ac-721665940ae0	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
0a7d8d6a-4193-451a-85ac-721665940ae0	31b1a221-3acf-459d-956a-02fa1b35fd60	f
5903c266-32ac-43b8-8e2e-bd8f8922a41a	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
5903c266-32ac-43b8-8e2e-bd8f8922a41a	14378f41-c569-482d-8f9c-3cef47bd0db4	t
5903c266-32ac-43b8-8e2e-bd8f8922a41a	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
5903c266-32ac-43b8-8e2e-bd8f8922a41a	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
5903c266-32ac-43b8-8e2e-bd8f8922a41a	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
5903c266-32ac-43b8-8e2e-bd8f8922a41a	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
5903c266-32ac-43b8-8e2e-bd8f8922a41a	2b179738-6741-4083-927f-b6b2d9339fe5	f
5903c266-32ac-43b8-8e2e-bd8f8922a41a	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
5903c266-32ac-43b8-8e2e-bd8f8922a41a	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
5903c266-32ac-43b8-8e2e-bd8f8922a41a	31b1a221-3acf-459d-956a-02fa1b35fd60	f
2729f46a-15d6-4e98-9956-39c417407b44	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
2729f46a-15d6-4e98-9956-39c417407b44	14378f41-c569-482d-8f9c-3cef47bd0db4	t
2729f46a-15d6-4e98-9956-39c417407b44	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
2729f46a-15d6-4e98-9956-39c417407b44	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
2729f46a-15d6-4e98-9956-39c417407b44	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
2729f46a-15d6-4e98-9956-39c417407b44	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
2729f46a-15d6-4e98-9956-39c417407b44	2b179738-6741-4083-927f-b6b2d9339fe5	f
2729f46a-15d6-4e98-9956-39c417407b44	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
2729f46a-15d6-4e98-9956-39c417407b44	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
2729f46a-15d6-4e98-9956-39c417407b44	31b1a221-3acf-459d-956a-02fa1b35fd60	f
4c676429-06af-45e5-9e72-04bb4050bde7	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
4c676429-06af-45e5-9e72-04bb4050bde7	14378f41-c569-482d-8f9c-3cef47bd0db4	t
4c676429-06af-45e5-9e72-04bb4050bde7	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
4c676429-06af-45e5-9e72-04bb4050bde7	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
4c676429-06af-45e5-9e72-04bb4050bde7	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
4c676429-06af-45e5-9e72-04bb4050bde7	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
4c676429-06af-45e5-9e72-04bb4050bde7	2b179738-6741-4083-927f-b6b2d9339fe5	f
4c676429-06af-45e5-9e72-04bb4050bde7	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
4c676429-06af-45e5-9e72-04bb4050bde7	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
4c676429-06af-45e5-9e72-04bb4050bde7	31b1a221-3acf-459d-956a-02fa1b35fd60	f
5e60f5dc-26e1-488a-a092-bd431f33fffa	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
5e60f5dc-26e1-488a-a092-bd431f33fffa	14378f41-c569-482d-8f9c-3cef47bd0db4	t
5e60f5dc-26e1-488a-a092-bd431f33fffa	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
5e60f5dc-26e1-488a-a092-bd431f33fffa	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
5e60f5dc-26e1-488a-a092-bd431f33fffa	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
5e60f5dc-26e1-488a-a092-bd431f33fffa	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
5e60f5dc-26e1-488a-a092-bd431f33fffa	2b179738-6741-4083-927f-b6b2d9339fe5	f
5e60f5dc-26e1-488a-a092-bd431f33fffa	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
5e60f5dc-26e1-488a-a092-bd431f33fffa	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
5e60f5dc-26e1-488a-a092-bd431f33fffa	31b1a221-3acf-459d-956a-02fa1b35fd60	f
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	14378f41-c569-482d-8f9c-3cef47bd0db4	t
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	2b179738-6741-4083-927f-b6b2d9339fe5	f
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	31b1a221-3acf-459d-956a-02fa1b35fd60	f
34d14c6c-c3cc-4504-859d-4d290900aa1a	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
34d14c6c-c3cc-4504-859d-4d290900aa1a	14378f41-c569-482d-8f9c-3cef47bd0db4	t
34d14c6c-c3cc-4504-859d-4d290900aa1a	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
34d14c6c-c3cc-4504-859d-4d290900aa1a	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
34d14c6c-c3cc-4504-859d-4d290900aa1a	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
34d14c6c-c3cc-4504-859d-4d290900aa1a	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
34d14c6c-c3cc-4504-859d-4d290900aa1a	2b179738-6741-4083-927f-b6b2d9339fe5	f
34d14c6c-c3cc-4504-859d-4d290900aa1a	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
34d14c6c-c3cc-4504-859d-4d290900aa1a	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
34d14c6c-c3cc-4504-859d-4d290900aa1a	31b1a221-3acf-459d-956a-02fa1b35fd60	f
d7c80418-90c3-4ea5-97ff-aece5ab026bf	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
d7c80418-90c3-4ea5-97ff-aece5ab026bf	14378f41-c569-482d-8f9c-3cef47bd0db4	t
d7c80418-90c3-4ea5-97ff-aece5ab026bf	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
d7c80418-90c3-4ea5-97ff-aece5ab026bf	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
d7c80418-90c3-4ea5-97ff-aece5ab026bf	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
d7c80418-90c3-4ea5-97ff-aece5ab026bf	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
d7c80418-90c3-4ea5-97ff-aece5ab026bf	2b179738-6741-4083-927f-b6b2d9339fe5	f
d7c80418-90c3-4ea5-97ff-aece5ab026bf	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
d7c80418-90c3-4ea5-97ff-aece5ab026bf	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
d7c80418-90c3-4ea5-97ff-aece5ab026bf	31b1a221-3acf-459d-956a-02fa1b35fd60	f
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	14378f41-c569-482d-8f9c-3cef47bd0db4	t
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	2b179738-6741-4083-927f-b6b2d9339fe5	f
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	31b1a221-3acf-459d-956a-02fa1b35fd60	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
3160c129-6afe-4724-b7bf-08ae27d3a164	1e280247-23c3-48a4-a2dc-a1939e96f83b
a107389c-8359-494f-bb1d-bd74d2bb9b13	f09fb9e1-c0ba-4838-9452-d7feba18fbb4
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
4735afae-4ee1-492d-990e-16758f984bec	Trusted Hosts	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	anonymous
53867a43-57df-45a6-ba92-4cf723a9d972	Consent Required	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	anonymous
e988dca3-02a3-48b3-bf16-a21d343dd36e	Full Scope Disabled	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	anonymous
8f5e07e6-6562-49ff-bde0-ba0d622c2a9c	Max Clients Limit	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	anonymous
b009124a-7969-4a4b-b044-54823106a03f	Allowed Protocol Mapper Types	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	anonymous
55c16853-2d86-4ea7-b890-77cb8add1fdc	Allowed Client Scopes	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	anonymous
ab61eb16-377e-4fd3-8fcb-8f097197bc54	Allowed Protocol Mapper Types	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	authenticated
f452bb9b-25d0-4470-bc17-2bf1ec20f35a	Allowed Client Scopes	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	authenticated
1755f536-2e17-4ef4-bbe0-9c6f65085c2c	rsa-generated	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	rsa-generated	org.keycloak.keys.KeyProvider	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N
dd67bfb7-80b8-412e-b25d-57685f234835	rsa-enc-generated	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	rsa-enc-generated	org.keycloak.keys.KeyProvider	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N
3811f49d-c210-465c-a1cf-b862ab4531c6	hmac-generated-hs512	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	hmac-generated	org.keycloak.keys.KeyProvider	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N
0b5f0498-12d0-49a6-b028-c927377e9391	aes-generated	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	aes-generated	org.keycloak.keys.KeyProvider	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N
5fc710f2-7593-49de-ac1d-45683be0926a	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N
d55745b5-c7e8-4b82-a550-bc98436ac1d1	Max Clients Limit	4cdda7bb-b16f-4448-915c-4ad90afbffb2	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cdda7bb-b16f-4448-915c-4ad90afbffb2	anonymous
0e0e9145-7a68-4e14-8aca-9c15f0f37756	Allowed Client Scopes	4cdda7bb-b16f-4448-915c-4ad90afbffb2	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cdda7bb-b16f-4448-915c-4ad90afbffb2	authenticated
36f1aa9e-b05d-4149-b23b-fe3cdf5ddd89	Allowed Protocol Mapper Types	4cdda7bb-b16f-4448-915c-4ad90afbffb2	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cdda7bb-b16f-4448-915c-4ad90afbffb2	authenticated
80630855-9955-4a35-94a5-6b05d8a70dcd	Full Scope Disabled	4cdda7bb-b16f-4448-915c-4ad90afbffb2	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cdda7bb-b16f-4448-915c-4ad90afbffb2	anonymous
a8362636-2dcb-4c30-a7f2-76938b2be2e7	Allowed Client Scopes	4cdda7bb-b16f-4448-915c-4ad90afbffb2	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cdda7bb-b16f-4448-915c-4ad90afbffb2	anonymous
821a8834-d0bf-47f3-8a55-a16d3b6d58b3	Allowed Protocol Mapper Types	4cdda7bb-b16f-4448-915c-4ad90afbffb2	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cdda7bb-b16f-4448-915c-4ad90afbffb2	anonymous
9293e359-5a45-47e0-ad42-25f7aaff07d9	Consent Required	4cdda7bb-b16f-4448-915c-4ad90afbffb2	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cdda7bb-b16f-4448-915c-4ad90afbffb2	anonymous
92a487d0-b3d5-4486-a4dd-09a982f1789a	Trusted Hosts	4cdda7bb-b16f-4448-915c-4ad90afbffb2	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cdda7bb-b16f-4448-915c-4ad90afbffb2	anonymous
a44b2c6b-1fc2-4bf5-a1f3-7ff53991f2d1	rsa-generated	4cdda7bb-b16f-4448-915c-4ad90afbffb2	rsa-generated	org.keycloak.keys.KeyProvider	4cdda7bb-b16f-4448-915c-4ad90afbffb2	\N
e6d2f9fc-3883-424e-a6a8-f6ef097fd906	aes-generated	4cdda7bb-b16f-4448-915c-4ad90afbffb2	aes-generated	org.keycloak.keys.KeyProvider	4cdda7bb-b16f-4448-915c-4ad90afbffb2	\N
311c6d77-f0dc-4a12-bcfd-9c6d5ee16358	rsa-enc-generated	4cdda7bb-b16f-4448-915c-4ad90afbffb2	rsa-enc-generated	org.keycloak.keys.KeyProvider	4cdda7bb-b16f-4448-915c-4ad90afbffb2	\N
1967d12f-50b7-4ae6-8e8c-91a5d0ff93a1	hmac-generated-hs512	4cdda7bb-b16f-4448-915c-4ad90afbffb2	hmac-generated	org.keycloak.keys.KeyProvider	4cdda7bb-b16f-4448-915c-4ad90afbffb2	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
a52d5d3a-9265-4ea5-b20d-a7e7a0e575ca	f452bb9b-25d0-4470-bc17-2bf1ec20f35a	allow-default-scopes	true
fbcadc65-7631-4652-8c54-99e265da8c54	55c16853-2d86-4ea7-b890-77cb8add1fdc	allow-default-scopes	true
d32e16d3-57b3-4102-8047-d7f2b7570aff	4735afae-4ee1-492d-990e-16758f984bec	client-uris-must-match	true
9ba1bfff-adc1-4ad4-b297-c568cc5e2cd0	4735afae-4ee1-492d-990e-16758f984bec	host-sending-registration-request-must-match	true
f1295266-24ad-4ed5-873a-a5ebb238a39c	ab61eb16-377e-4fd3-8fcb-8f097197bc54	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
861c8b8f-4593-4839-974b-421c5b5511f1	ab61eb16-377e-4fd3-8fcb-8f097197bc54	allowed-protocol-mapper-types	saml-user-attribute-mapper
b9792ce3-a18d-40be-b143-a70c75ebbe9a	ab61eb16-377e-4fd3-8fcb-8f097197bc54	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
02811b02-0e2a-46eb-9937-d54f52694076	ab61eb16-377e-4fd3-8fcb-8f097197bc54	allowed-protocol-mapper-types	oidc-address-mapper
9fa7ff11-eac5-4e1a-8754-e3b846d2ada3	ab61eb16-377e-4fd3-8fcb-8f097197bc54	allowed-protocol-mapper-types	saml-role-list-mapper
a1714725-9e31-4c18-9c0a-e918b17391e0	ab61eb16-377e-4fd3-8fcb-8f097197bc54	allowed-protocol-mapper-types	oidc-full-name-mapper
79135a0a-526b-44aa-b1cc-ca92f48cc08a	ab61eb16-377e-4fd3-8fcb-8f097197bc54	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c1862af7-dbd2-481f-a747-29b21137b75e	ab61eb16-377e-4fd3-8fcb-8f097197bc54	allowed-protocol-mapper-types	saml-user-property-mapper
029a0843-bbd9-4f41-a849-3069dff6cfc0	b009124a-7969-4a4b-b044-54823106a03f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8996e87b-7fb9-4c2b-8d86-7a8f2fc400c3	b009124a-7969-4a4b-b044-54823106a03f	allowed-protocol-mapper-types	oidc-address-mapper
b377fba9-8585-4c98-b92a-d350e7d954d0	b009124a-7969-4a4b-b044-54823106a03f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
fb9b7baf-b999-426a-b2e0-c046cb8b16fc	b009124a-7969-4a4b-b044-54823106a03f	allowed-protocol-mapper-types	saml-role-list-mapper
3b403c49-487d-405e-93fd-05d5eecad511	b009124a-7969-4a4b-b044-54823106a03f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d8b901de-8588-472c-a8e5-5362c5bf03b7	b009124a-7969-4a4b-b044-54823106a03f	allowed-protocol-mapper-types	saml-user-attribute-mapper
4a9fece0-c1d5-49ff-9bed-10e13ea4085f	b009124a-7969-4a4b-b044-54823106a03f	allowed-protocol-mapper-types	oidc-full-name-mapper
adc01a6e-8967-4297-bee3-1a4bee323fa0	b009124a-7969-4a4b-b044-54823106a03f	allowed-protocol-mapper-types	saml-user-property-mapper
80dbe4c0-acbf-49b4-8b91-52d2acf07a0f	8f5e07e6-6562-49ff-bde0-ba0d622c2a9c	max-clients	200
51954f51-a408-46e3-9ac9-3c06cc684aec	0b5f0498-12d0-49a6-b028-c927377e9391	priority	100
3bffb53e-8214-4514-97cd-c6badba71553	0b5f0498-12d0-49a6-b028-c927377e9391	kid	124cd3c9-1d94-4adb-b170-9f1b2c8e039b
e17c3793-c9a7-4a9c-9010-aeb2124171b0	0b5f0498-12d0-49a6-b028-c927377e9391	secret	OgfgxqrOX95Kb0z-iO4HMg
70c04ac2-ffd8-422f-8031-86a478694d51	1755f536-2e17-4ef4-bbe0-9c6f65085c2c	priority	100
9e97001f-ece6-4a62-92a6-d7c755d7ab37	1755f536-2e17-4ef4-bbe0-9c6f65085c2c	certificate	MIICmzCCAYMCBgGWFfHyvTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNDA4MTUwNjQwWhcNMzUwNDA4MTUwODIwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDjmZaaziO7MKiikwkWAZogZu1UBMqhTw+huJbEYFlDr1MG86LkqfZ5ezPFv5UvIqWlDRxcCIfrbs2O46y5KGYAb4MY97GBBPLgbffWzAUVcG+080QL0XrL/8Ic7zHQTA1RxCpFfzD0AKdh7gnoDFJaBS8W3hvtRPDfVnyOFZ9mQrg6FPlJLIK3OtcrPtJdj4oPfj5t5oKjJHCse/gDggh3inLIiu3olwq6RveS8mG1qWOKBldYrUmJjFxGdGgAnVgigncT7KzhKnjzpOtHdt+5ynoV+hojUxSS4BjIMvPM8PCdUW/Ucbhp69Sl5VVCm5Iv1Ba8eNWGV+OridPwh/lxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAE/gZzJgEgRVbj5Rpot8ZXAUREOHUViRZuqznhqTPg8RJ9d3gexn6gGhla5G5Nguw2uSn/q/ucCZ3tD5xqBabSiM6oMVDqmGbvvbtT5aBtphYbjwgxbrUILBDMkGvPWy16GRxVMsNPmj4iIfYN5PPOhQaL9vCee4Y+5EXfZNkkyq3VaaDYDlM6K9icmhSVME4zabpHLKzGSoiaC/WastrJbQOLFfHQ65uknwdbg5+EoPmmOkJcsX/kO4Zzi2ccqiQXft1XzFN0jDDkYH1FWaTOkiRy6sU9nNHkC0+arwEZ81WZkcilAM39TauTp4OhDYCyjZbE2P0igqGjQAEyw4z3o=
ce28e3a6-bbba-43a8-9df0-7b0e070cb4e2	1755f536-2e17-4ef4-bbe0-9c6f65085c2c	keyUse	SIG
532ea517-c25b-42c6-b57f-3c24d7b3dea8	1755f536-2e17-4ef4-bbe0-9c6f65085c2c	privateKey	MIIEpAIBAAKCAQEA45mWms4juzCoopMJFgGaIGbtVATKoU8PobiWxGBZQ69TBvOi5Kn2eXszxb+VLyKlpQ0cXAiH627NjuOsuShmAG+DGPexgQTy4G331swFFXBvtPNEC9F6y//CHO8x0EwNUcQqRX8w9ACnYe4J6AxSWgUvFt4b7UTw31Z8jhWfZkK4OhT5SSyCtzrXKz7SXY+KD34+beaCoyRwrHv4A4IId4pyyIrt6JcKukb3kvJhtaljigZXWK1JiYxcRnRoAJ1YIoJ3E+ys4Sp486TrR3bfucp6FfoaI1MUkuAYyDLzzPDwnVFv1HG4aevUpeVVQpuSL9QWvHjVhlfjq4nT8If5cQIDAQABAoIBAAl8u6eR+TD9MG0FG7IEThQ/W3GO+OgBdNbabBpyeQtrvFZurcxsqJ6xZoaTMQOeekYnhkDwhW3obVQhTxqxbD26EukQW3X+f/tKn4lKHC95GNxI7v4JH4kaYlE0x/Wf/fF5xQNRmneerAYr1yjfk/KMWG/9FoVCREIjB50f70g4DUWX8Zpy3WsrEp0gTpVaDXBM7S+8YBET/dUc0aBYUD2ajC8eSATLS12+El5VgQ5ZYCRZvgcnVEsYYDeQNENphQ0x1TJiMA+OsMExLel/Ox8R6l52AdoUf5IzvsggFStbMNep2nWtpxRD8IU4hX0s7m09yhwBelpOE9rKND6XcJkCgYEA/2+hpa4bKjW4XceNsS5g+At6HU32QLvBilV3R41D4XXQUipHBPqz3J6EIqR+QFJe9Tvlb4joE7hknuqLIed6lTNh8a0/P3YnpTPrC9m871vB9a7+F36TTw8MbnlUS3IKR10KpDFZ2KrDQJVDYWPJM0f5GFY0Jxhi7oKYJ+UXXD0CgYEA5Bo5bTbZEdhxLINTkmL9pGWIsvAYAkt2jlYlJy1TkpvyV5BGRWH2+BjIpaHjj9a7cihH0niaK8wQPG95BolLs1OwTEe7lTTGutVFGbMe6nt0ahDUZ3egTVQpSVSVSU7DWFifbvx3Zx5RuLTG/sjmrjsItPs2S2X/gCzr09v9YUUCgYBErOq09L5w9sh+ziwWOvXvOoa2YkOW2+QJITlUj3J0p4w+ywcVG6JH6oZ0Ge2ntX26SURCXHio9KZ4425My0N14b6vj3i1wzqde/vxz7SwVecr+sRt5KYOV2lsOkqjjiGdVjKKOoqBakfckUTwZjeuBee+105mRHQ00/+8midRsQKBgQDTPGHf/QIKn6k28qsrDlcbrhdotiVVwrKY37fqTvRs+dP0ORyKVk2Stcjickg9xTqzXhAdHiiP1JtYjFbEsdKT0DWcfnV9mHFNRgGG6jUAKrHFI66/3q1pzz2othbF25XVs8R50H121kIRzf/WpQ/TW8IVb+p46o0xEuiVus0sDQKBgQDPdb8PPaUE+xMzbKV90esm07gDktKOyiEj9/ZqwpWYE3drwHj8tPXYSsfm8Di/+ocCw2BqktAF/s1HpCoz2lGAO9zBK5ea3l+x/KGbzRke4fJUefHvxmMBQXD7lR0+mGwnzAbWmBuiRoGZGGSw3jW232O0EHjdPZ4SNh2CsxC3Pw==
6b95fe69-6db5-41c8-9c71-f0ab69ace4d4	5fc710f2-7593-49de-ac1d-45683be0926a	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
5791b57c-7e5e-432c-ac79-7da96f80c035	dd67bfb7-80b8-412e-b25d-57685f234835	privateKey	MIIEpAIBAAKCAQEAqg/04Y/aS8OxKf/MDTApPKRtRZzllukVuiDxv3D4T3yERtqIuCuQAz8U5liWqEVRmS8DPldFJ6I5+UkKKMOSaGpF3VhUDcDbHCALRVrWaLpt/1JzLP6tNWNoWJZqwLaPneEQKPBYwtCeFzAQ49T5KlStWwqaJJxt5+hK+BTMylVqol9I3PgO1JdlL1jYjL1r4/fQ2POtVObtBBFHikdH5C2WaURJGKwFBbyIlZzMoVIgo6i4VOenVAODYwkKAUjj+AvqBooNYyYE0dYxi3FzwQA0k0ic1ez9daYbSzVb3mH4A3pYzQnWpm7xV9kGK/BcdF3mGtFDPMmkIraCYb/XRwIDAQABAoIBABpiyBOTQUMjcBfcc2l8a87X6DML0+d6mf9mCybb5/r/48971V4AjE35+fZ/ZOi40J9G1xGoyAxiiZeEXfTTMKJ4vVxJeckkf2/kB5D8NhYhDt4K3zSU/doxu/KQFqzN5oc6xfTEIybJkth1gbldGvJsGaBC4IWxAQXMBI3B6cBestmGsqICJm66yFSFrCArgiyMu8LTzcf5+lrWq5YAcvByAERe0G67EF/607DWxaJITomlg5wwnM5Ig11ReC1cRIaygyeZf9pq6RW3wKjK9doGuaPCwcSEUa1M/dB6CvHgM94w/kc2AJ2gdLnXcIKJf9lInv1twU1Ebe/jChC9tSECgYEA3X47lCsKXw44W2oMrmVJyfpCOKWBajtC5Jc+hHB4xUBdxbPlZaq9WF/pMKA3wgTF6sPzOvbdWoHee+H+8HRouSJiaQR5lFB/hctcIOMnx7+FyaM7nHIZz9HUgCEYzh9ZkiGfPD8kahoNQRTkdFSFwsWBf0J5y+Cu/tqwN5pmEJECgYEAxI6FM2wyI1QKa2Epzto2QKwuWTrES8h4aTcloaiFc1GSLsp9z0qhlQxUXxvPcOJfBhDAOaAqA4kb3ZtRtrAJHXVjKlT8ltEBU+H1aRq7SMUZeyFrcwbuUl1iVTJJ/HKx4dkscat86eBeGshvdnEkXaStjOKT+LB57rIRPI9H1lcCgYEAgYyf1F4IRujOVcmFeUuNCTHzIabMNxJKYeGEk3olaVnofwZlmj1vWg1fGy3a7wRTrqjFzyss9Q8YzmS09Hdh+Ub/QGV5pyIeNGdpj2LNlauT2Qg8iZjDOCaGoBq7o3P6s9ouhNJ5vgVW00YhCVmWkwFqaMC89F6KfE3029DW+cECgYEAmbzPupTZ8n/9Vle9F6nd3V/PMMOiXZQDemhD6tmg573ZlPeUx9ob4DSwmWNrMWQd5uSbNXds5S8MuJyPoVC3EG+MjMPEfUIkw7Ns/DSIYDap44EURfgZ2BpqmzCmZepf78Kp3I7BOTzg3hn/9KgyRXxUsmlWS6Hc/TISAUggbCkCgYBDGGgyfKX7yk6747zXjE54HbgBBn5HeVvenMNbnulgNFE8Yni48CEQOn/7RQVIihDj71LGLisjleyk9CZ03izf40Jl1+r8+LMF+uodMwkFvD85JVEsfhu2dnObR5EUgMICZeU6GBOSturRUX7iV4ENavd3UZL8eju/VrU7dVzBfg==
18a49b53-3324-445c-ab96-5e8eac82e30f	dd67bfb7-80b8-412e-b25d-57685f234835	keyUse	ENC
46cadef9-9403-4810-bb91-62aa3de47c79	dd67bfb7-80b8-412e-b25d-57685f234835	certificate	MIICmzCCAYMCBgGWFfHzMjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNDA4MTUwNjQwWhcNMzUwNDA4MTUwODIwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqD/Thj9pLw7Ep/8wNMCk8pG1FnOWW6RW6IPG/cPhPfIRG2oi4K5ADPxTmWJaoRVGZLwM+V0Unojn5SQoow5JoakXdWFQNwNscIAtFWtZoum3/UnMs/q01Y2hYlmrAto+d4RAo8FjC0J4XMBDj1PkqVK1bCpoknG3n6Er4FMzKVWqiX0jc+A7Ul2UvWNiMvWvj99DY861U5u0EEUeKR0fkLZZpREkYrAUFvIiVnMyhUiCjqLhU56dUA4NjCQoBSOP4C+oGig1jJgTR1jGLcXPBADSTSJzV7P11phtLNVveYfgDeljNCdambvFX2QYr8Fx0XeYa0UM8yaQitoJhv9dHAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACFkRVU4UabjGcARRZF3henCw5UzyYlxxUYgkJ3jpMwDX4N6jWdSqQiXAO109FAiTVfU1pgfCledq7tRl55YoSAROjVRSAOzEGEI5jU7iVSjNZEZuc5JZhBt7YRAikNPvb/ptqLAu5ajqQieyckUwkuqcR0a0Ti592hpTUhYBR+Z4EBbTlGLAvTvqiXZm1HFleesZKUb12T7clcOyt6u1GLwRhvGm6N6/1w/vVLZQn+JOIW2Xg20vBMsIvFLGU1a3sN3WB1yh+MuN2au99UfL6lg2/YfVm5aZN6CABNpjrpbsAvnZh+rVFIYwwsbMiOE5JkJZARuhANkhBlkyvlAU6c=
15deaddc-b1a7-4c17-8930-2e1752292814	dd67bfb7-80b8-412e-b25d-57685f234835	priority	100
bac8313d-8e14-43c7-978d-e00b4447f327	dd67bfb7-80b8-412e-b25d-57685f234835	algorithm	RSA-OAEP
08da28c8-dca1-467d-a8e0-b7b1917873bd	3811f49d-c210-465c-a1cf-b862ab4531c6	algorithm	HS512
c2b7b42c-eb43-4072-b128-77e1ff4a8160	3811f49d-c210-465c-a1cf-b862ab4531c6	kid	14e45798-c872-44bf-a5a9-b577dfec48ab
42b047a0-32fc-459c-aac9-995e51a1f0e9	3811f49d-c210-465c-a1cf-b862ab4531c6	secret	VV5tzMDyc87t9h3y_swBaaoHgnCCPQbtsY1HbNhssUEXZIg3nCu5xYC8jHZ5_XAN4pk_COlN0gTOom7U_6iaJKqxzjbTv5ysPrXfof4osBeR61i6usquem2km4iiiElL4eiXt1LzZGhHkEJl9BnA-hQw5j3gsZj9UbP_C20kYnc
9fb266be-7cbb-4221-a602-db34425649a4	3811f49d-c210-465c-a1cf-b862ab4531c6	priority	100
ef25c912-a86f-4251-871f-a856ac012a3f	a44b2c6b-1fc2-4bf5-a1f3-7ff53991f2d1	certificate	MIICqTCCAZECBgGWFo0GCjANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1kYW5pZWxlLWJhbmNvMB4XDTI1MDQwODE3NTYwM1oXDTM1MDQwODE3NTc0M1owGDEWMBQGA1UEAwwNZGFuaWVsZS1iYW5jbzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMkHxXG2DWM4fg15M7d1xCodvDfR1dMUZYUWtT7RszIuV2XgmIXz1C6g/bzagyuUvwHqS7vshkdSUnv7luWQVe/zSM5LWvR7ctoR3sPVslkeYCDMkRJzLWMrgXqdaGOkfYMq1ucTdk2AvFlBw96J697Bx/rQ2u1AjNJ1lOh9wxgD+gD6hkuQa4hK6m/AR9iaSQ57MIwIZNevVpn8nApEyfV8pWij0PgH0pllzPzOdv0rBqFr4HUSfBJTBUNEyJAQyeDvOJOMoZaabpz9rdL5XgGz6P1zpaBKyc79DtPp+eZsbb5rlsHMVgVtr7jBH8gJUrMUrVBwq+J4f79Ofu22dScCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAeoFf08/ErQer6bBYXYX06i0I0OwLKnNbeicXSC4aGuM0P+Od05dKCTghzG4URzWECkSF/IMAxYgN4/NKhH0sXxdCC6+hUCyWp/2jIiNfSnWGNRkk2DD8urbT86DUod3ajynVy7s15Oc5qBoEDlxQhaXqGuFcRCtxcmqQiR4OBQ+xh4MAiVRA6KWDyqib7r+cCbksI9JU07yisCzFgfHkknxB3NUnM5yHVYHglfvpP5U6XGnc1swBFsOEuN/7zDohHr10Bn1So1dG6YkrCC9oTY8KgiRfBeZnkZ2263Xii6gFMLp2EHBniCBUqL6APk50dlRsxMNpc/5lhxWRChRDcg==
293b7202-2df1-4825-8a13-ba9dba3dab70	a44b2c6b-1fc2-4bf5-a1f3-7ff53991f2d1	priority	100
512df506-35fb-4a50-a193-634207295f4a	a44b2c6b-1fc2-4bf5-a1f3-7ff53991f2d1	privateKey	MIIEowIBAAKCAQEAyQfFcbYNYzh+DXkzt3XEKh28N9HV0xRlhRa1PtGzMi5XZeCYhfPULqD9vNqDK5S/AepLu+yGR1JSe/uW5ZBV7/NIzkta9Hty2hHew9WyWR5gIMyREnMtYyuBep1oY6R9gyrW5xN2TYC8WUHD3onr3sHH+tDa7UCM0nWU6H3DGAP6APqGS5BriErqb8BH2JpJDnswjAhk169WmfycCkTJ9XylaKPQ+AfSmWXM/M52/SsGoWvgdRJ8ElMFQ0TIkBDJ4O84k4yhlppunP2t0vleAbPo/XOloErJzv0O0+n55mxtvmuWwcxWBW2vuMEfyAlSsxStUHCr4nh/v05+7bZ1JwIDAQABAoIBABUuPW5aqRRwKk/PGlTVEqMBWQhkkmvX9U5NczE4NPIvkcPJIyjR5OQ40CMqvrFDzdAs2GfnZspy8P/hJSfwyi0q69vYcq/ZpeM2CMuHY3AiVCyAgTR5cCnHtq+tkAcXmKXOSLA2C7vkuXOKC1ISJAjnT+OsR7TBnVS7UMIiJgEMkhpPMeZCZbN7/3rJfS98m2185Yki1Fho9O/lm4khRLm2d4/1lIE6QAF7P7lJfYMWkzcZJQb4mwYzM5iYrfiAnyhO6VyQdyCQ9kmmMsA6tMY1FMw7EkWc3QV0KW1HIhQBQ234R9q3/wnePnxRkmYRIdwrZ6bYqfOY5Y+oHaZKuJECgYEA/d/ELcLcPFhv44Hkt2kON/5G18nYKLPJTCvsIkrxjq3W3oE9KtJ6Mb5UhvhjCQiVaD7f/7bZlSnb3XYUtxVb14pMXEsSIpznxjW5ywHO2LUZjhbudVXkmIGlDoN9OIkB+WwNq7GSGnFfmsxep0Z1Av5GoyhhzaTtTwe2BywFAR8CgYEAyra5GaN/bbx0G/7WyFhYnDzeCUT5WMC//UYdZgiOAAkO/AQXZ0Z8C9zpaSTjmH7ekfohixiyp7P/HZOQSvmqUZ9pOMQ9aJTHDeQTyRJKCLHb5xrf2rv0IK5S9qiRQraHzSTQHUyqIgB82PPyG69PR/vK+BeC2Ex9in3FbYvF4vkCgYEA2K2mY6Q/kmWswZG4ou3QS+wDjONiUYL5GMEYHkC2oJ8wl+HYUfcogdI/lJ7k7+3ajwmy5y6p0EzUsdS5Y3WgWHtaJx+Pj+k5TIvIUkLtxznyYLqjtZOksqFcPeHt+1W8UKRvmo3I9Da1cYpicwSIlBBwO4sYxoqwXFZpfv+MGeMCgYBPBeQqhn4KfUiWEUYRW79PSLsVyfmaC6nMRiT3vaX9hYp92+pzrBp3VWr4PhUrQWnqZiPlYX9juNte4EODtsgagZY3Nujpd/YRCDReUe7ibNNYyDUzw8lrZAmbdiMKarWN1yf6BATetGn2+UIMYM77NMDu7dtoDolyD42DItXFoQKBgFCnL6vkW7HizU5oATVBZjOILYuTGVn8ToiqpdOdru/Ed1V2idjGy9r06lrB/ZgfiKnkeY1g/q9PznfxjkweQwq5rJe5f9gpdtkYv1++HvSC2YkDSkRFz9k74NgC3TP0JIaHd7Asuh2nWufqGTfxOZInSw6I8rmWmcJBns5wdxgd
d2d26b54-e574-4b04-ba02-d5b85c12ee8e	a8362636-2dcb-4c30-a7f2-76938b2be2e7	allow-default-scopes	true
b3840026-06ed-4587-aaab-22eb13c50519	311c6d77-f0dc-4a12-bcfd-9c6d5ee16358	privateKey	MIIEogIBAAKCAQEAig2jfN1+usdsHLS1IHix7ddJ+IheyRdwliN0nz5eMhzY1nJYET5vh9XThLurz4WURFnotFCi/omeL1Jb+2QZObXP/5CUdwdLvtq/pXbCUgjOb3Hkb4YbT3tkxQ856BLPqKKjpXU1Z3oc5J8bh9/oIdqMHbP7CU9xKJX2KtWO5+0ORpCsGILMLuDJBcheTVHN/EDh9ceV1WjL/qPlefkxiguk4RXGc8QrZgDR1yzYNAM+SjokJ6imeUc7rwNUHCrP2qM3BZpER3Byu5M0kI1+ydO14Tp/VVwQhqtL6cyahl7UrOXdqC7XPzEv/QcB1LdJcWzQBsG745OuO4Rqk4dd9wIDAQABAoIBADC6wbOIh3wsekfjrW+Jytx2OsEEedincnE8kKTJIfy0XAHOGLH1hO7Alknq6Kl2sDA0QEStlesc7n4rpxYkbhcFyyadhRpCtATpN+6S7eKBA0UpQYXwI2G534cDaeA2C6Ctz+/OYIxm+R3l35Tlfw28E+tEJV9S8FFwJZVXDntkmATfSMeaJqGxZY5SLi+1z3yjjQtpaUDQ1KPRWq2jw47x0Yo60Q+dl4d94LsPjKehTqzNGksGk5OnNxJ2UbVY5uMgbU7F3UFFfI6Ri3+j2MNSRQYzPm93RMLEZXB5Hdat7xkL47sKQS3OtCMwAj9BDgpnRD698Et2W04m8qTb7HECgYEAvhSA9WA0wFqbZDpcCbu3LhfaaKTTTGF9BoZI+e3jcxD1NSSJDO5UrFUcL7K9NBLB0TWIIQDprChIpj5qB7u9gK1oc5xLcvQ6ali2sxXb4sNK/GqzOlx61OXK3td49/ZIRNdHzizRMPR7+PNieKG6z/BHiv5UHfmztshQGim0aekCgYEAue4krWzmHmDWMgOLRDmPNoBhoVrjCb2lCmr/fqdK3FsJv7w8Y+Ji7Ft0S6L6TopBH7mnedwSM6vUgx4Mxlf3KU6XZUzU/3tOwdCbKzQH3jCekNgN0bq+uanqjLCalu8sa6iQ6n+mEOITckQ3PSt4AYzcjlNsZi20d4ytLx3YvN8CgYAsvCadmUbQ/oIT1KhUohk6f+KnPiN8lnUWVARYzeP58MPE/hRDNtQ2utEnaKme18tFsZOYMN7N5a0zcv0BVO4Emss6ak5Xf6M/5CEbhMl7VPsQ7QvBcIJ4GJzmVU/jC9N2YDRGEcYp/2At9xn1yhptVd+Altq1M09YdUxk2+vaAQKBgFOqsUCFN4xGAT0iUSITULmyzbwhPPdeKo1klrI0r8A3C00HdJlx/xfjE5MRtNdw6VtQXOe+O0abNRcHh7IdVXB2GDSSfWq13zviFmE7marHcCM3xggxo6/CoXRL6FSxLekIQqXzaRRB14Rc5AqXq/nunDVDnwzf1kzRtgD0ylo7AoGAHaWyupq8uI3lGx/9mUAfPaeDGqrZtqBKko/ObbGmTK52UZboBKR9gHKxalB1SFVrcFK06LllheGslzxCMq/qY1PLbLymG4DGRu8IEcJABZnjYw6Qo0wdWnFjBbA865befRObF+FAD28FIGXvjQMw4F2xe0K3yffrOMMFOluyZm4=
4f4a3eaf-761a-4527-8ec4-d1a2af7a4d0e	311c6d77-f0dc-4a12-bcfd-9c6d5ee16358	certificate	MIICqTCCAZECBgGWFo0GmTANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1kYW5pZWxlLWJhbmNvMB4XDTI1MDQwODE3NTYwM1oXDTM1MDQwODE3NTc0M1owGDEWMBQGA1UEAwwNZGFuaWVsZS1iYW5jbzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIoNo3zdfrrHbBy0tSB4se3XSfiIXskXcJYjdJ8+XjIc2NZyWBE+b4fV04S7q8+FlERZ6LRQov6Jni9SW/tkGTm1z/+QlHcHS77av6V2wlIIzm9x5G+GG097ZMUPOegSz6iio6V1NWd6HOSfG4ff6CHajB2z+wlPcSiV9irVjuftDkaQrBiCzC7gyQXIXk1RzfxA4fXHldVoy/6j5Xn5MYoLpOEVxnPEK2YA0dcs2DQDPko6JCeopnlHO68DVBwqz9qjNwWaREdwcruTNJCNfsnTteE6f1VcEIarS+nMmoZe1Kzl3agu1z8xL/0HAdS3SXFs0AbBu+OTrjuEapOHXfcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAS+T3gqeqdQGwWi2e/d6JeActjma166e3r29UI9f9nUs/tH/JOwhaVlq3FAob2Wf9ipW/mW3jg+xhiG3C/7L6M+fZ9znDITsmgJ2sho3Ev6aWV5woU5/RKURFlThReojlBVgpALYWdEBlv+JkAjxMvrwJhZeY/jkzcwCyF1g/0fP/19d5+VcPbfVG6T60HvZSM2HIg+3GVl0bq/DocYTsuH2FY+1mnMnvNph/I39GbIOm2j2SuGebC54u/v0raY8OY7QUk/UOITeIYrNEqvYr92FqgrLraMjuu0H/RXgTXvHk+xKzaimavX9XSavw08jlUJ7SvThurRoqH3vt0ZWrGA==
8c8fc579-69f5-4298-a502-9f14a94ebfc5	311c6d77-f0dc-4a12-bcfd-9c6d5ee16358	algorithm	RSA-OAEP
9297c92c-7ccf-4c6f-886a-f6800e258a02	311c6d77-f0dc-4a12-bcfd-9c6d5ee16358	priority	100
a0fbc01d-efd6-42ff-a7f5-862107e53ac9	821a8834-d0bf-47f3-8a55-a16d3b6d58b3	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e683f11f-dd9f-4088-88f5-e044f009a524	821a8834-d0bf-47f3-8a55-a16d3b6d58b3	allowed-protocol-mapper-types	oidc-address-mapper
108c28a8-b481-4487-9705-b0b0c9988e6d	821a8834-d0bf-47f3-8a55-a16d3b6d58b3	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
e4278eab-a328-4ccf-8cd5-f70df205d5c2	821a8834-d0bf-47f3-8a55-a16d3b6d58b3	allowed-protocol-mapper-types	oidc-full-name-mapper
fef95f70-20c3-428f-a1a3-37fb55e3cfc7	821a8834-d0bf-47f3-8a55-a16d3b6d58b3	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
75caa2f6-0f15-45df-8e74-b3a49dc984eb	821a8834-d0bf-47f3-8a55-a16d3b6d58b3	allowed-protocol-mapper-types	saml-user-property-mapper
fae8bdfd-a0e9-4bdd-96cc-e776b6a307a1	821a8834-d0bf-47f3-8a55-a16d3b6d58b3	allowed-protocol-mapper-types	saml-user-attribute-mapper
37d6a649-f6c2-43a0-8976-3b950c79b3a4	821a8834-d0bf-47f3-8a55-a16d3b6d58b3	allowed-protocol-mapper-types	saml-role-list-mapper
35e65d84-f21c-4a36-83f3-a977073ab1b4	d55745b5-c7e8-4b82-a550-bc98436ac1d1	max-clients	200
bf5487e1-f8a0-4ea4-bbfc-f82f92b76a39	0e0e9145-7a68-4e14-8aca-9c15f0f37756	allow-default-scopes	true
1dc02beb-677c-4840-b53c-8546ffbc40b0	92a487d0-b3d5-4486-a4dd-09a982f1789a	client-uris-must-match	true
15f51ae2-480d-45af-87f5-7a19fe4f376f	92a487d0-b3d5-4486-a4dd-09a982f1789a	host-sending-registration-request-must-match	true
b0e189e4-b835-436c-b0e5-72c870b91b19	1967d12f-50b7-4ae6-8e8c-91a5d0ff93a1	secret	wHWbjd9R7RHYzDNI3jOMLYh2OKDPalM95NrHXyxB5y0sL59wqAOVWtRNduhJH_lfGNWQndV9wt6Vs_gPP6hRBf3nInVrGXWOWTMGYDP7EXcH_QhgzztLkUvEqvcIEIdzg4mNEzDHmD9ouVV2t9w8KREHopE4iQEWU24i0UPq1V0
d4119187-0014-43c8-ab55-a2027a34b64a	1967d12f-50b7-4ae6-8e8c-91a5d0ff93a1	kid	a6ac1f7e-779f-4af0-856d-bd491c40b6cf
4fdaad2b-a9fa-453a-99fa-ee8581632a7d	1967d12f-50b7-4ae6-8e8c-91a5d0ff93a1	algorithm	HS512
6fbc0dac-4c84-40d4-8133-d997f47fadc9	1967d12f-50b7-4ae6-8e8c-91a5d0ff93a1	priority	100
c01ced2a-3f88-49a8-aed7-f9c89cb874ce	36f1aa9e-b05d-4149-b23b-fe3cdf5ddd89	allowed-protocol-mapper-types	saml-user-attribute-mapper
2f396c12-afbd-4b12-a398-9386e9467a8a	36f1aa9e-b05d-4149-b23b-fe3cdf5ddd89	allowed-protocol-mapper-types	saml-role-list-mapper
ff7e14c0-50f1-4bdb-9729-fd0316c14485	36f1aa9e-b05d-4149-b23b-fe3cdf5ddd89	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8088139c-2e1b-4565-b9ef-6d4048c0c69b	36f1aa9e-b05d-4149-b23b-fe3cdf5ddd89	allowed-protocol-mapper-types	oidc-full-name-mapper
439c0cb8-b2a2-4972-843c-5c69102e46d0	36f1aa9e-b05d-4149-b23b-fe3cdf5ddd89	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7d59b9c1-8a25-4dee-8067-2dd05a678817	36f1aa9e-b05d-4149-b23b-fe3cdf5ddd89	allowed-protocol-mapper-types	saml-user-property-mapper
7366c043-1292-48ad-b886-48d6a264e358	36f1aa9e-b05d-4149-b23b-fe3cdf5ddd89	allowed-protocol-mapper-types	oidc-address-mapper
f68b4603-ae67-4d17-a2ed-78666bfae835	36f1aa9e-b05d-4149-b23b-fe3cdf5ddd89	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ada030c4-5ce3-4770-81f4-26da083ae08f	e6d2f9fc-3883-424e-a6a8-f6ef097fd906	secret	JNDuFJ_bNXIzfD5v6FtYjw
65d4c720-f2ea-48d4-a19e-3306ebd3ab04	e6d2f9fc-3883-424e-a6a8-f6ef097fd906	kid	a982daa1-bffe-442f-878f-ba7a3b0ffe4e
34b05a7d-d80b-44fd-a48a-9016b0637222	e6d2f9fc-3883-424e-a6a8-f6ef097fd906	priority	100
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.composite_role (composite, child_role) FROM stdin;
2e381316-04ae-4ea6-be18-af56a1328a83	a8ae3e19-a842-424d-a219-ba9cc821864f
2e381316-04ae-4ea6-be18-af56a1328a83	04a0fac2-6f7d-460c-a22d-af87bf9edcf7
2e381316-04ae-4ea6-be18-af56a1328a83	a20e9f4d-4ca2-41e7-b9a1-2c9fc95ca34c
2e381316-04ae-4ea6-be18-af56a1328a83	bdb25fb2-9d1b-4096-89d0-2a4d448c1767
2e381316-04ae-4ea6-be18-af56a1328a83	2adb7432-c6db-4d9c-8d5d-d6322ccc385a
2e381316-04ae-4ea6-be18-af56a1328a83	c09528ae-6d40-433e-b473-4d8a2beeea4c
2e381316-04ae-4ea6-be18-af56a1328a83	0bf224a3-3991-4c50-8ffb-40e7f7375b00
2e381316-04ae-4ea6-be18-af56a1328a83	e6427ba1-be8f-4f23-80c3-9b100bbfe334
2e381316-04ae-4ea6-be18-af56a1328a83	bb69750f-35bb-47e6-950e-a5cbc5ea107e
2e381316-04ae-4ea6-be18-af56a1328a83	4310bf48-898c-4b1b-9353-ee862bf2facb
2e381316-04ae-4ea6-be18-af56a1328a83	74da661a-3e2e-4382-a4f8-5dc264d3ac92
2e381316-04ae-4ea6-be18-af56a1328a83	0ddf802e-c13e-42e3-a299-bb1b7e91241e
2e381316-04ae-4ea6-be18-af56a1328a83	bb455830-8950-42bd-abce-77f0ab1eba0c
2e381316-04ae-4ea6-be18-af56a1328a83	f9ed0025-1157-459a-8dc5-1688e7198db3
2e381316-04ae-4ea6-be18-af56a1328a83	3560100f-2f86-4e91-b3a7-b8947a81820e
2e381316-04ae-4ea6-be18-af56a1328a83	920c4e77-de9b-46e2-ae11-dddd43c28edd
2e381316-04ae-4ea6-be18-af56a1328a83	aa1344d8-1c24-4143-b1e9-4f459d8073a1
2e381316-04ae-4ea6-be18-af56a1328a83	279c2dbd-dab2-4a50-aa65-b2967e42f2ae
0dfa2f7b-0116-4b92-ba18-a012db5d9ce6	5bc0f53c-aeaa-4302-9433-06743052d16d
2adb7432-c6db-4d9c-8d5d-d6322ccc385a	920c4e77-de9b-46e2-ae11-dddd43c28edd
bdb25fb2-9d1b-4096-89d0-2a4d448c1767	3560100f-2f86-4e91-b3a7-b8947a81820e
bdb25fb2-9d1b-4096-89d0-2a4d448c1767	279c2dbd-dab2-4a50-aa65-b2967e42f2ae
0dfa2f7b-0116-4b92-ba18-a012db5d9ce6	5f78b0e7-fe83-428f-9add-2adfced61917
5f78b0e7-fe83-428f-9add-2adfced61917	38978e87-a82e-45e9-bfa6-0036a3d6fe63
997b789c-e166-4a31-b60b-12d08a491095	3202bb01-753e-48fe-97e0-4b1b5adf94cf
2e381316-04ae-4ea6-be18-af56a1328a83	9bc89fb6-c2cf-4651-a9a3-d95728bb553c
0dfa2f7b-0116-4b92-ba18-a012db5d9ce6	1e280247-23c3-48a4-a2dc-a1939e96f83b
0dfa2f7b-0116-4b92-ba18-a012db5d9ce6	1a50c4c4-405a-483a-a129-19c46d67af93
2e381316-04ae-4ea6-be18-af56a1328a83	dd8b4d57-f784-49d8-811d-37b038c0ffac
2e381316-04ae-4ea6-be18-af56a1328a83	1c9de3ca-ce4f-41b1-920a-a121a09524e6
2e381316-04ae-4ea6-be18-af56a1328a83	6ade017c-e837-4654-81ff-6909976bd46f
2e381316-04ae-4ea6-be18-af56a1328a83	d7af7e5b-1e1c-4d3e-bd73-d1a18780f822
2e381316-04ae-4ea6-be18-af56a1328a83	e5e851bb-453e-4a22-89c5-436fba3a5384
2e381316-04ae-4ea6-be18-af56a1328a83	75909d00-5833-4c35-9c68-8c758d9f9333
2e381316-04ae-4ea6-be18-af56a1328a83	050dcdbd-1b55-4136-a077-ee6c5281790a
2e381316-04ae-4ea6-be18-af56a1328a83	93708e97-ebf8-41b1-bc5e-bf6afde4eed2
2e381316-04ae-4ea6-be18-af56a1328a83	7309b38f-0520-4361-b704-532b97d0f692
2e381316-04ae-4ea6-be18-af56a1328a83	c65befec-8f3a-4b2f-9dff-1ad49d0de413
2e381316-04ae-4ea6-be18-af56a1328a83	4ac2ee6d-4860-4800-8923-9b5bb878c499
2e381316-04ae-4ea6-be18-af56a1328a83	cf8d638a-71d2-4c1f-a326-7581abf1048f
2e381316-04ae-4ea6-be18-af56a1328a83	85eab9bb-8ab6-4dd9-ba4b-800324db28a1
2e381316-04ae-4ea6-be18-af56a1328a83	b8239d54-b2aa-420e-84e0-86d9c6fa1956
2e381316-04ae-4ea6-be18-af56a1328a83	7331b0e5-2d04-477c-935c-35870dc3d5a6
2e381316-04ae-4ea6-be18-af56a1328a83	85c7227a-20f6-458f-90ed-b63d6d3e2dff
2e381316-04ae-4ea6-be18-af56a1328a83	47d1b47a-8636-4910-834e-c780b9b3d3ca
6ade017c-e837-4654-81ff-6909976bd46f	b8239d54-b2aa-420e-84e0-86d9c6fa1956
6ade017c-e837-4654-81ff-6909976bd46f	47d1b47a-8636-4910-834e-c780b9b3d3ca
d7af7e5b-1e1c-4d3e-bd73-d1a18780f822	7331b0e5-2d04-477c-935c-35870dc3d5a6
971ddae5-1113-4fcd-9e93-415f64cd06e1	4fb62339-354f-436d-9247-008eafc8fc3f
971ddae5-1113-4fcd-9e93-415f64cd06e1	85a8b9c9-2010-477c-87b8-0d20610d0db5
a4e82a01-8421-4a34-b090-6c87bae7573d	f951ff83-0930-4060-8910-6067fe4cc3fe
a791c54f-7a7f-4e9e-a6d7-5ff12591cf50	c0da2205-b5ff-4dd2-9335-0ab4cf617d88
cba70f92-165f-49b7-b58a-51913282817e	f09fb9e1-c0ba-4838-9452-d7feba18fbb4
cba70f92-165f-49b7-b58a-51913282817e	e81de3ea-ae49-4627-9a7c-9369eba228e4
cba70f92-165f-49b7-b58a-51913282817e	eec83cfc-115d-4a9a-be21-6d018e491041
cba70f92-165f-49b7-b58a-51913282817e	e6091c3b-8fe7-4527-b8fd-0c091cf48d00
cf7b04d1-bcdf-41d5-bac4-153ab309a171	9d7894da-7058-4678-8610-76b3223b103f
cf7b04d1-bcdf-41d5-bac4-153ab309a171	e0cbde81-6d5d-4e60-808f-8d1d9180e3b8
cf7b04d1-bcdf-41d5-bac4-153ab309a171	85a8b9c9-2010-477c-87b8-0d20610d0db5
cf7b04d1-bcdf-41d5-bac4-153ab309a171	971ddae5-1113-4fcd-9e93-415f64cd06e1
cf7b04d1-bcdf-41d5-bac4-153ab309a171	64f88a96-4bd1-4858-b66a-28bed3b2f760
cf7b04d1-bcdf-41d5-bac4-153ab309a171	d46dffaf-ea13-4355-824a-aed2c880fbb7
cf7b04d1-bcdf-41d5-bac4-153ab309a171	a7ff2549-9bd4-4b7d-96f0-d36e9ffdcd36
cf7b04d1-bcdf-41d5-bac4-153ab309a171	0a544a05-60c3-4695-8948-c9817bbaa45e
cf7b04d1-bcdf-41d5-bac4-153ab309a171	4d1adfee-cf07-4bff-b07f-f0b6a643185e
cf7b04d1-bcdf-41d5-bac4-153ab309a171	3ece207d-0e16-4bdc-b8bb-5722e1f3f624
cf7b04d1-bcdf-41d5-bac4-153ab309a171	db93c065-5ef8-4423-987d-cbf78ca95650
cf7b04d1-bcdf-41d5-bac4-153ab309a171	51cb4412-8328-4ad5-82e2-048ecffd5d7e
cf7b04d1-bcdf-41d5-bac4-153ab309a171	4fb62339-354f-436d-9247-008eafc8fc3f
cf7b04d1-bcdf-41d5-bac4-153ab309a171	8dc616a9-f8eb-4cca-916f-6874275bcb03
cf7b04d1-bcdf-41d5-bac4-153ab309a171	c0da2205-b5ff-4dd2-9335-0ab4cf617d88
cf7b04d1-bcdf-41d5-bac4-153ab309a171	5807ddcd-9279-437d-97de-21c06d8d3d11
cf7b04d1-bcdf-41d5-bac4-153ab309a171	a791c54f-7a7f-4e9e-a6d7-5ff12591cf50
cf7b04d1-bcdf-41d5-bac4-153ab309a171	65ad2c9b-ec22-4b71-b73b-62e14274f8ee
eec83cfc-115d-4a9a-be21-6d018e491041	e249b6fb-3d11-4c4c-be5e-0642f84f913c
2e381316-04ae-4ea6-be18-af56a1328a83	4f16f6e1-cd29-47c7-8b51-ca57a3a55dcd
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
8ca33993-9bf1-432e-901e-2698bf9417c4	\N	password	e81b490d-cfea-4f3e-8648-fe607086ef9e	1744124900626	\N	{"value":"cTu9+xW1lLc0BZpTmjcmFW44181HddEtKGetxij4wnY=","salt":"soil8RAc1war7a6ceiIHcg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
4696a3d3-b0cd-43ea-9f22-a4ba024645d6	\N	password	6c3ae6a2-38f9-4556-ae77-5e331585e058	1744135123556	My password	{"value":"DI86nollaqBeD3SBbaJW2slSOoyf2FYXQ6OZtj5/K9s=","salt":"kED7Kz4Jo597IEcMU+dwRA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
902fdaef-0294-415c-8aba-799f6eaa567c	\N	password	cfbdb0fa-29de-4312-ade3-c0e86958a301	1744135232051	My password	{"value":"eLKiNbj7B4fGQsKGYvElAam84BeQC11jM49PZhXVkes=","salt":"82GPlkbjj4D5Q935lQ5KMg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
13649644-57f0-4e6d-82e7-9201be42c2c2	\N	password	cfcf6a02-ff46-413c-aa18-49ccdc545ac3	1744200211773	My password	{"value":"DIQyX/3TbNRnJVeaZm0qhFiqxwm9Oi+16g3ixq00JCo=","salt":"uYiwuCs51v94AK5oeUaXkw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
8a758d2b-ab79-44f6-9f30-2322733e8dbf	\N	password	2a1aa6e6-313d-48ae-b4cd-6a2987f4ec1b	1744204121575	My password	{"value":"8lJlS3fYud5cGgYdQVh2Sfw4uhaRv5ITENzUkuynLKU=","salt":"LQ6yYYdzKTaPHbobD9zCCA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-04-08 15:08:16.850415	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	4124896481
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-04-08 15:08:16.864841	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	4124896481
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-04-08 15:08:16.903921	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	4124896481
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-04-08 15:08:16.9079	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	4124896481
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-04-08 15:08:16.998642	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	4124896481
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-04-08 15:08:17.00451	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	4124896481
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-04-08 15:08:17.082254	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	4124896481
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-04-08 15:08:17.094189	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	4124896481
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-04-08 15:08:17.100138	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	4124896481
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-04-08 15:08:17.181418	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	4124896481
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-04-08 15:08:17.232679	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	4124896481
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-04-08 15:08:17.236861	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	4124896481
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-04-08 15:08:17.256473	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	4124896481
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-04-08 15:08:17.272666	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	4124896481
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-04-08 15:08:17.274647	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	4124896481
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-04-08 15:08:17.27758	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	4124896481
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-04-08 15:08:17.280096	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	4124896481
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-04-08 15:08:17.3159	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	4124896481
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-04-08 15:08:17.347414	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	4124896481
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-04-08 15:08:17.351591	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	4124896481
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-04-08 15:08:17.354762	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	4124896481
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-04-08 15:08:17.356905	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	4124896481
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-04-08 15:08:17.376063	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	4124896481
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-04-08 15:08:17.380894	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	4124896481
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-04-08 15:08:17.382231	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	4124896481
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-04-08 15:08:17.403483	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	4124896481
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-04-08 15:08:17.456714	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	4124896481
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-04-08 15:08:17.459628	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	4124896481
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-04-08 15:08:17.502606	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	4124896481
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-04-08 15:08:17.514183	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	4124896481
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-04-08 15:08:17.532323	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	4124896481
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-04-08 15:08:17.537989	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	4124896481
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-04-08 15:08:17.543432	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	4124896481
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-04-08 15:08:17.545187	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	4124896481
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-04-08 15:08:17.565495	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	4124896481
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-04-08 15:08:17.570315	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	4124896481
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-04-08 15:08:17.574865	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	4124896481
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-04-08 15:08:17.578026	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	4124896481
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-04-08 15:08:17.580865	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	4124896481
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-04-08 15:08:17.582032	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	4124896481
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-04-08 15:08:17.584824	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	4124896481
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-04-08 15:08:17.591104	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	4124896481
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-04-08 15:08:17.679676	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	4124896481
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-04-08 15:08:17.683921	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	4124896481
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-04-08 15:08:17.687979	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	4124896481
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-04-08 15:08:17.694206	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	4124896481
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-04-08 15:08:17.695719	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	4124896481
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-04-08 15:08:17.725215	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	4124896481
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-04-08 15:08:17.729248	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	4124896481
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-04-08 15:08:17.761409	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	4124896481
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-04-08 15:08:17.782458	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	4124896481
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-04-08 15:08:17.785904	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	4124896481
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-04-08 15:08:17.788762	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	4124896481
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-04-08 15:08:17.791373	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	4124896481
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-04-08 15:08:17.796327	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	4124896481
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-04-08 15:08:17.801056	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	4124896481
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-04-08 15:08:17.817848	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	4124896481
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-04-08 15:08:17.901445	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	4124896481
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-04-08 15:08:17.920661	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	4124896481
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-04-08 15:08:17.926392	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	4124896481
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-04-08 15:08:17.935265	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	4124896481
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-04-08 15:08:17.940231	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	4124896481
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-04-08 15:08:17.943645	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	4124896481
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-04-08 15:08:17.946508	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	4124896481
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-04-08 15:08:17.948877	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	4124896481
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-04-08 15:08:17.959988	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	4124896481
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-04-08 15:08:17.964736	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	4124896481
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-04-08 15:08:17.968335	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	4124896481
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-04-08 15:08:17.97907	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	4124896481
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-04-08 15:08:17.984425	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	4124896481
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-04-08 15:08:17.988794	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	4124896481
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-04-08 15:08:17.994939	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	4124896481
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-04-08 15:08:18.001885	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	4124896481
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-04-08 15:08:18.004442	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	4124896481
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-04-08 15:08:18.020806	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	4124896481
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-04-08 15:08:18.02737	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	4124896481
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-04-08 15:08:18.030264	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	4124896481
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-04-08 15:08:18.031579	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	4124896481
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-04-08 15:08:18.047895	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	4124896481
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-04-08 15:08:18.050043	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	4124896481
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-04-08 15:08:18.055073	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	4124896481
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-04-08 15:08:18.056619	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	4124896481
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-04-08 15:08:18.060561	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	4124896481
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-04-08 15:08:18.061823	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	4124896481
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-04-08 15:08:18.06687	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	4124896481
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-04-08 15:08:18.071775	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	4124896481
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-04-08 15:08:18.077515	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	4124896481
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-04-08 15:08:18.085678	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	4124896481
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-08 15:08:18.093716	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	4124896481
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-08 15:08:18.098117	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	4124896481
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-08 15:08:18.103183	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	4124896481
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-08 15:08:18.109471	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	4124896481
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-08 15:08:18.110813	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	4124896481
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-08 15:08:18.119329	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	4124896481
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-08 15:08:18.121209	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	4124896481
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-04-08 15:08:18.126896	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	4124896481
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-08 15:08:18.135775	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	4124896481
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-08 15:08:18.13735	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	4124896481
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-08 15:08:18.148508	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	4124896481
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-08 15:08:18.154622	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	4124896481
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-08 15:08:18.155987	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	4124896481
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-08 15:08:18.161582	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	4124896481
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-04-08 15:08:18.167315	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	4124896481
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-04-08 15:08:18.172525	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	4124896481
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-04-08 15:08:18.177911	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	4124896481
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-04-08 15:08:18.183223	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	4124896481
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-04-08 15:08:18.195201	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.25.1	\N	\N	4124896481
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-04-08 15:08:18.201931	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	4124896481
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-04-08 15:08:18.208411	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	4124896481
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-04-08 15:08:18.210347	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	4124896481
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-04-08 15:08:18.216937	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	4124896481
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-04-08 15:08:18.224592	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	4124896481
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-04-08 15:08:18.247581	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	4124896481
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-04-08 15:08:18.250353	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	4124896481
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-04-08 15:08:18.256659	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	4124896481
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-04-08 15:08:18.258135	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	4124896481
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-04-08 15:08:18.263596	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	4124896481
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-04-08 15:08:18.266575	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	4124896481
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-04-08 15:08:18.281681	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	4124896481
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-04-08 15:08:18.289086	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	4124896481
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-04-08 15:08:18.296788	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	4124896481
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-04-08 15:08:18.302293	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	4124896481
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-04-08 15:08:18.309325	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	4124896481
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-04-08 15:08:18.310779	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	4124896481
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-04-08 15:08:18.312574	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	4124896481
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-08 15:08:18.31879	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.25.1	\N	\N	4124896481
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-08 15:08:18.324296	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	4124896481
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-08 15:08:18.330398	128	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.25.1	\N	\N	4124896481
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-08 15:08:18.332561	129	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	4124896481
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-08 15:08:18.338096	130	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	4124896481
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-08 15:08:18.352355	131	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.25.1	\N	\N	4124896481
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-08 15:08:18.362982	132	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	4124896481
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-08 15:08:18.364852	133	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	4124896481
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-04-08 15:08:18.371922	134	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.25.1	\N	\N	4124896481
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	3160c129-6afe-4724-b7bf-08ae27d3a164	f
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	3fef793e-f831-4624-a617-d11d0af78586	t
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	eea44f0f-3db3-405e-925e-4ab150fb5844	t
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	be2b373a-def4-4c22-bed3-b5073cf42092	t
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	24049a07-b501-4c2e-a999-a7abb967050b	f
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	00e0183d-c34e-446d-a775-15a2c78d255b	f
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	9230a8bf-272a-4782-b5d5-a960a0a66eba	t
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd	t
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	34b3b8d3-310a-45c0-bc5f-a71bd6f656b1	f
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	d3e78bdf-cfdc-4387-8faf-607105bb8cf0	t
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	75b9de11-dbdf-456b-8bd5-86c6aae3888b	t
4cdda7bb-b16f-4448-915c-4ad90afbffb2	a6852ef6-16ff-44a8-b1aa-d483e1a47bf6	t
4cdda7bb-b16f-4448-915c-4ad90afbffb2	2dfe5fb6-8931-4949-be56-b56cf9be2f89	t
4cdda7bb-b16f-4448-915c-4ad90afbffb2	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2	t
4cdda7bb-b16f-4448-915c-4ad90afbffb2	ce7a5a46-b4de-4f72-bb9a-29af1d358324	t
4cdda7bb-b16f-4448-915c-4ad90afbffb2	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3	t
4cdda7bb-b16f-4448-915c-4ad90afbffb2	14378f41-c569-482d-8f9c-3cef47bd0db4	t
4cdda7bb-b16f-4448-915c-4ad90afbffb2	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e	t
4cdda7bb-b16f-4448-915c-4ad90afbffb2	a107389c-8359-494f-bb1d-bd74d2bb9b13	f
4cdda7bb-b16f-4448-915c-4ad90afbffb2	2b179738-6741-4083-927f-b6b2d9339fe5	f
4cdda7bb-b16f-4448-915c-4ad90afbffb2	891f7bda-5070-4db6-a750-6ea9a504b3d6	f
4cdda7bb-b16f-4448-915c-4ad90afbffb2	31b1a221-3acf-459d-956a-02fa1b35fd60	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
11d51146-62ba-433a-afad-2ad64605182f	analistas	 	4cdda7bb-b16f-4448-915c-4ad90afbffb2
cceec5c1-c974-4f3d-aa4b-147fcbaf401d	camunda-admin	 	4cdda7bb-b16f-4448-915c-4ad90afbffb2
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
0dfa2f7b-0116-4b92-ba18-a012db5d9ce6	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	f	${role_default-roles}	default-roles-master	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N	\N
2e381316-04ae-4ea6-be18-af56a1328a83	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	f	${role_admin}	admin	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N	\N
a8ae3e19-a842-424d-a219-ba9cc821864f	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	f	${role_create-realm}	create-realm	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N	\N
04a0fac2-6f7d-460c-a22d-af87bf9edcf7	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_create-client}	create-client	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
a20e9f4d-4ca2-41e7-b9a1-2c9fc95ca34c	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_view-realm}	view-realm	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
bdb25fb2-9d1b-4096-89d0-2a4d448c1767	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_view-users}	view-users	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
2adb7432-c6db-4d9c-8d5d-d6322ccc385a	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_view-clients}	view-clients	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
c09528ae-6d40-433e-b473-4d8a2beeea4c	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_view-events}	view-events	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
0bf224a3-3991-4c50-8ffb-40e7f7375b00	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_view-identity-providers}	view-identity-providers	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
e6427ba1-be8f-4f23-80c3-9b100bbfe334	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_view-authorization}	view-authorization	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
bb69750f-35bb-47e6-950e-a5cbc5ea107e	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_manage-realm}	manage-realm	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
4310bf48-898c-4b1b-9353-ee862bf2facb	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_manage-users}	manage-users	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
74da661a-3e2e-4382-a4f8-5dc264d3ac92	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_manage-clients}	manage-clients	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
0ddf802e-c13e-42e3-a299-bb1b7e91241e	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_manage-events}	manage-events	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
bb455830-8950-42bd-abce-77f0ab1eba0c	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_manage-identity-providers}	manage-identity-providers	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
f9ed0025-1157-459a-8dc5-1688e7198db3	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_manage-authorization}	manage-authorization	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
3560100f-2f86-4e91-b3a7-b8947a81820e	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_query-users}	query-users	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
920c4e77-de9b-46e2-ae11-dddd43c28edd	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_query-clients}	query-clients	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
aa1344d8-1c24-4143-b1e9-4f459d8073a1	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_query-realms}	query-realms	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
279c2dbd-dab2-4a50-aa65-b2967e42f2ae	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_query-groups}	query-groups	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
5bc0f53c-aeaa-4302-9433-06743052d16d	39f21afe-a1fc-4125-94bf-7b361860bcc8	t	${role_view-profile}	view-profile	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	39f21afe-a1fc-4125-94bf-7b361860bcc8	\N
5f78b0e7-fe83-428f-9add-2adfced61917	39f21afe-a1fc-4125-94bf-7b361860bcc8	t	${role_manage-account}	manage-account	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	39f21afe-a1fc-4125-94bf-7b361860bcc8	\N
38978e87-a82e-45e9-bfa6-0036a3d6fe63	39f21afe-a1fc-4125-94bf-7b361860bcc8	t	${role_manage-account-links}	manage-account-links	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	39f21afe-a1fc-4125-94bf-7b361860bcc8	\N
d2f77606-41b0-4878-8231-a44b07eb6b85	39f21afe-a1fc-4125-94bf-7b361860bcc8	t	${role_view-applications}	view-applications	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	39f21afe-a1fc-4125-94bf-7b361860bcc8	\N
3202bb01-753e-48fe-97e0-4b1b5adf94cf	39f21afe-a1fc-4125-94bf-7b361860bcc8	t	${role_view-consent}	view-consent	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	39f21afe-a1fc-4125-94bf-7b361860bcc8	\N
997b789c-e166-4a31-b60b-12d08a491095	39f21afe-a1fc-4125-94bf-7b361860bcc8	t	${role_manage-consent}	manage-consent	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	39f21afe-a1fc-4125-94bf-7b361860bcc8	\N
f33a4d08-504b-4e8f-8444-7a9dac6b22c3	39f21afe-a1fc-4125-94bf-7b361860bcc8	t	${role_view-groups}	view-groups	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	39f21afe-a1fc-4125-94bf-7b361860bcc8	\N
296447fa-c892-4de4-98f8-3513c98f1a81	39f21afe-a1fc-4125-94bf-7b361860bcc8	t	${role_delete-account}	delete-account	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	39f21afe-a1fc-4125-94bf-7b361860bcc8	\N
5f9eef09-6226-40b2-a622-ab88b769b160	d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	t	${role_read-token}	read-token	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	d1ec1e56-a77d-4bdd-a9d3-420f802b0f68	\N
9bc89fb6-c2cf-4651-a9a3-d95728bb553c	79b09991-4e56-4792-9cb0-f2948988c907	t	${role_impersonation}	impersonation	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	79b09991-4e56-4792-9cb0-f2948988c907	\N
1e280247-23c3-48a4-a2dc-a1939e96f83b	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	f	${role_offline-access}	offline_access	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N	\N
1a50c4c4-405a-483a-a129-19c46d67af93	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	f	${role_uma_authorization}	uma_authorization	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	\N	\N
cba70f92-165f-49b7-b58a-51913282817e	4cdda7bb-b16f-4448-915c-4ad90afbffb2	f	${role_default-roles}	default-roles-daniele banco	4cdda7bb-b16f-4448-915c-4ad90afbffb2	\N	\N
dd8b4d57-f784-49d8-811d-37b038c0ffac	c5603804-5783-4f30-80cc-add804474cc2	t	${role_create-client}	create-client	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
1c9de3ca-ce4f-41b1-920a-a121a09524e6	c5603804-5783-4f30-80cc-add804474cc2	t	${role_view-realm}	view-realm	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
6ade017c-e837-4654-81ff-6909976bd46f	c5603804-5783-4f30-80cc-add804474cc2	t	${role_view-users}	view-users	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
d7af7e5b-1e1c-4d3e-bd73-d1a18780f822	c5603804-5783-4f30-80cc-add804474cc2	t	${role_view-clients}	view-clients	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
e5e851bb-453e-4a22-89c5-436fba3a5384	c5603804-5783-4f30-80cc-add804474cc2	t	${role_view-events}	view-events	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
75909d00-5833-4c35-9c68-8c758d9f9333	c5603804-5783-4f30-80cc-add804474cc2	t	${role_view-identity-providers}	view-identity-providers	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
050dcdbd-1b55-4136-a077-ee6c5281790a	c5603804-5783-4f30-80cc-add804474cc2	t	${role_view-authorization}	view-authorization	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
93708e97-ebf8-41b1-bc5e-bf6afde4eed2	c5603804-5783-4f30-80cc-add804474cc2	t	${role_manage-realm}	manage-realm	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
7309b38f-0520-4361-b704-532b97d0f692	c5603804-5783-4f30-80cc-add804474cc2	t	${role_manage-users}	manage-users	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
c65befec-8f3a-4b2f-9dff-1ad49d0de413	c5603804-5783-4f30-80cc-add804474cc2	t	${role_manage-clients}	manage-clients	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
4ac2ee6d-4860-4800-8923-9b5bb878c499	c5603804-5783-4f30-80cc-add804474cc2	t	${role_manage-events}	manage-events	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
cf8d638a-71d2-4c1f-a326-7581abf1048f	c5603804-5783-4f30-80cc-add804474cc2	t	${role_manage-identity-providers}	manage-identity-providers	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
85eab9bb-8ab6-4dd9-ba4b-800324db28a1	c5603804-5783-4f30-80cc-add804474cc2	t	${role_manage-authorization}	manage-authorization	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
b8239d54-b2aa-420e-84e0-86d9c6fa1956	c5603804-5783-4f30-80cc-add804474cc2	t	${role_query-users}	query-users	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
7331b0e5-2d04-477c-935c-35870dc3d5a6	c5603804-5783-4f30-80cc-add804474cc2	t	${role_query-clients}	query-clients	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
85c7227a-20f6-458f-90ed-b63d6d3e2dff	c5603804-5783-4f30-80cc-add804474cc2	t	${role_query-realms}	query-realms	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
47d1b47a-8636-4910-834e-c780b9b3d3ca	c5603804-5783-4f30-80cc-add804474cc2	t	${role_query-groups}	query-groups	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
f09fb9e1-c0ba-4838-9452-d7feba18fbb4	4cdda7bb-b16f-4448-915c-4ad90afbffb2	f	${role_offline-access}	offline_access	4cdda7bb-b16f-4448-915c-4ad90afbffb2	\N	\N
e81de3ea-ae49-4627-9a7c-9369eba228e4	4cdda7bb-b16f-4448-915c-4ad90afbffb2	f	${role_uma_authorization}	uma_authorization	4cdda7bb-b16f-4448-915c-4ad90afbffb2	\N	\N
9d7894da-7058-4678-8610-76b3223b103f	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_manage-realm}	manage-realm	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
e0cbde81-6d5d-4e60-808f-8d1d9180e3b8	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_manage-authorization}	manage-authorization	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
cf7b04d1-bcdf-41d5-bac4-153ab309a171	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_realm-admin}	realm-admin	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
85a8b9c9-2010-477c-87b8-0d20610d0db5	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_query-users}	query-users	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
971ddae5-1113-4fcd-9e93-415f64cd06e1	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_view-users}	view-users	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
64f88a96-4bd1-4858-b66a-28bed3b2f760	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_view-realm}	view-realm	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
d46dffaf-ea13-4355-824a-aed2c880fbb7	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_create-client}	create-client	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
a7ff2549-9bd4-4b7d-96f0-d36e9ffdcd36	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_manage-events}	manage-events	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
0a544a05-60c3-4695-8948-c9817bbaa45e	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_manage-identity-providers}	manage-identity-providers	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
4d1adfee-cf07-4bff-b07f-f0b6a643185e	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_manage-clients}	manage-clients	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
3ece207d-0e16-4bdc-b8bb-5722e1f3f624	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_query-realms}	query-realms	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
db93c065-5ef8-4423-987d-cbf78ca95650	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_view-events}	view-events	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
51cb4412-8328-4ad5-82e2-048ecffd5d7e	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_manage-users}	manage-users	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
4fb62339-354f-436d-9247-008eafc8fc3f	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_query-groups}	query-groups	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
8dc616a9-f8eb-4cca-916f-6874275bcb03	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_impersonation}	impersonation	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
c0da2205-b5ff-4dd2-9335-0ab4cf617d88	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_query-clients}	query-clients	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
5807ddcd-9279-437d-97de-21c06d8d3d11	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_view-authorization}	view-authorization	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
a791c54f-7a7f-4e9e-a6d7-5ff12591cf50	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_view-clients}	view-clients	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
65ad2c9b-ec22-4b71-b73b-62e14274f8ee	d7c80418-90c3-4ea5-97ff-aece5ab026bf	t	${role_view-identity-providers}	view-identity-providers	4cdda7bb-b16f-4448-915c-4ad90afbffb2	d7c80418-90c3-4ea5-97ff-aece5ab026bf	\N
c048c496-22d7-4ad4-8642-c70986d6bff9	a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	t	\N	uma_protection	4cdda7bb-b16f-4448-915c-4ad90afbffb2	a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	\N
54717636-0a9f-4f63-becd-908f88adcfaf	5e60f5dc-26e1-488a-a092-bd431f33fffa	t	${role_read-token}	read-token	4cdda7bb-b16f-4448-915c-4ad90afbffb2	5e60f5dc-26e1-488a-a092-bd431f33fffa	\N
e132b7f0-5079-48b1-a21d-1cdfe6a9f7ae	0a7d8d6a-4193-451a-85ac-721665940ae0	t	${role_view-applications}	view-applications	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0a7d8d6a-4193-451a-85ac-721665940ae0	\N
eec83cfc-115d-4a9a-be21-6d018e491041	0a7d8d6a-4193-451a-85ac-721665940ae0	t	${role_manage-account}	manage-account	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0a7d8d6a-4193-451a-85ac-721665940ae0	\N
a4e82a01-8421-4a34-b090-6c87bae7573d	0a7d8d6a-4193-451a-85ac-721665940ae0	t	${role_manage-consent}	manage-consent	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0a7d8d6a-4193-451a-85ac-721665940ae0	\N
e6091c3b-8fe7-4527-b8fd-0c091cf48d00	0a7d8d6a-4193-451a-85ac-721665940ae0	t	${role_view-profile}	view-profile	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0a7d8d6a-4193-451a-85ac-721665940ae0	\N
e249b6fb-3d11-4c4c-be5e-0642f84f913c	0a7d8d6a-4193-451a-85ac-721665940ae0	t	${role_manage-account-links}	manage-account-links	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0a7d8d6a-4193-451a-85ac-721665940ae0	\N
f951ff83-0930-4060-8910-6067fe4cc3fe	0a7d8d6a-4193-451a-85ac-721665940ae0	t	${role_view-consent}	view-consent	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0a7d8d6a-4193-451a-85ac-721665940ae0	\N
ac2e5ce4-80de-4b3a-9e39-f695855a7898	0a7d8d6a-4193-451a-85ac-721665940ae0	t	${role_delete-account}	delete-account	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0a7d8d6a-4193-451a-85ac-721665940ae0	\N
2cb94a31-65d6-44ff-a5b7-aca328ed03e0	0a7d8d6a-4193-451a-85ac-721665940ae0	t	${role_view-groups}	view-groups	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0a7d8d6a-4193-451a-85ac-721665940ae0	\N
4f16f6e1-cd29-47c7-8b51-ca57a3a55dcd	c5603804-5783-4f30-80cc-add804474cc2	t	${role_impersonation}	impersonation	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	c5603804-5783-4f30-80cc-add804474cc2	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migration_model (id, version, update_time) FROM stdin;
3ssnf	25.0.6	1744124898
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.org (id, enabled, realm_id, group_id, name, description) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
31e6541d-ede7-4f3c-a011-040cc6259331	audience resolve	openid-connect	oidc-audience-resolve-mapper	ceaf3397-b419-4940-b783-4d8d3c73a8dd	\N
92f8c9ec-c648-491e-81c0-9ce56b8c238b	locale	openid-connect	oidc-usermodel-attribute-mapper	d7d45b11-e281-4a96-bbe3-2c960e3fb30a	\N
ac61a355-31fa-4f4c-aaac-7826b81c91ad	role list	saml	saml-role-list-mapper	\N	3fef793e-f831-4624-a617-d11d0af78586
8d112b56-98a8-47f7-b13e-53fb7fda26c9	full name	openid-connect	oidc-full-name-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
e4df8866-81a9-41bd-8978-b9329ac3a7fa	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
ced2a05e-02b3-4bbe-939d-034c34732838	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
41758784-31b2-49f1-9343-e206bfe12bf1	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
e3c9febc-da6b-4a76-ae55-5f6ad481932b	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
9034c522-41d8-4f51-8659-00dda16f849c	username	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
3a519318-336f-4c73-9836-97168af5fc62	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
7603dca0-cfc5-4ad8-bc18-a1517a84de1b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
2f5f7c55-ad00-456b-83d3-401fbfe2c397	website	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
cd79c8a9-2d27-414f-8c17-0ee3b60846f3	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
8077b7e2-e377-478a-a16e-2e88ae3baf18	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
50340705-504b-4d61-bf01-d6b80ae15d4a	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
05c796bc-74b6-46b8-935e-d3a285ae0895	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
fc11d840-907a-48e5-85a2-5b717dd26115	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	eea44f0f-3db3-405e-925e-4ab150fb5844
20535f64-0719-4c47-b3d2-4a5f9acc6c30	email	openid-connect	oidc-usermodel-attribute-mapper	\N	be2b373a-def4-4c22-bed3-b5073cf42092
fc911088-e9f4-45ff-9e02-a6f55094b2ac	email verified	openid-connect	oidc-usermodel-property-mapper	\N	be2b373a-def4-4c22-bed3-b5073cf42092
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	address	openid-connect	oidc-address-mapper	\N	24049a07-b501-4c2e-a999-a7abb967050b
a7550d86-a690-404e-a68d-0a3c7cc8995f	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	00e0183d-c34e-446d-a775-15a2c78d255b
fba44cc5-85f3-4e27-b8bd-f9595e4b4b59	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	00e0183d-c34e-446d-a775-15a2c78d255b
913656a0-983d-487c-b9a2-18f046eb506f	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	9230a8bf-272a-4782-b5d5-a960a0a66eba
ca41ae80-9695-4be4-bd4f-ddaf323485ed	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	9230a8bf-272a-4782-b5d5-a960a0a66eba
eaf8b238-2f3d-4b0e-9fcd-95e0f5326f23	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	9230a8bf-272a-4782-b5d5-a960a0a66eba
4f9ee167-32ac-492f-af32-0b7645aa3b82	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	d94b7ba6-7a1e-40c9-ac86-0fd5a6e123dd
3acaa1b6-b187-4470-a1f0-d005e4b2d48b	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	34b3b8d3-310a-45c0-bc5f-a71bd6f656b1
0801917c-e608-4b74-b087-24a3d7d8f60f	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	34b3b8d3-310a-45c0-bc5f-a71bd6f656b1
9953be20-69a0-463f-bb84-240e48439007	acr loa level	openid-connect	oidc-acr-mapper	\N	d3e78bdf-cfdc-4387-8faf-607105bb8cf0
a0c06bca-7e77-4ec0-85a4-8ac438a83ab8	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	75b9de11-dbdf-456b-8bd5-86c6aae3888b
2a9eaaff-9623-41c2-8e07-8c928d3a027c	sub	openid-connect	oidc-sub-mapper	\N	75b9de11-dbdf-456b-8bd5-86c6aae3888b
9506d6fd-b6c7-41dc-bace-98893320decc	acr loa level	openid-connect	oidc-acr-mapper	\N	14378f41-c569-482d-8f9c-3cef47bd0db4
b0c612f9-218c-4a0d-b829-ad27c0392c02	address	openid-connect	oidc-address-mapper	\N	2b179738-6741-4083-927f-b6b2d9339fe5
0f34359b-96d3-48cc-845d-39a75e95a094	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	1b3d8c6a-8fe4-4f17-9aa8-afd63ddd4eb3
7086ecd3-f401-42a3-9f3e-2910c2ca2891	sub	openid-connect	oidc-sub-mapper	\N	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e
b721208c-3da6-44a7-a21b-363b06ab679f	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	4ecd6d58-d9e8-4d46-814c-7c756b0e4c6e
f3d13da6-a7fa-4ad9-ac72-78b4c7dfcf7d	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	ce7a5a46-b4de-4f72-bb9a-29af1d358324
14fbbc54-fdd9-4ce0-a637-0307ca65caf6	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	ce7a5a46-b4de-4f72-bb9a-29af1d358324
053ec2c8-a03a-421c-978d-d87f23308539	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	ce7a5a46-b4de-4f72-bb9a-29af1d358324
491101d9-00b3-4840-b706-234b5189bb12	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
588c7b24-b48a-4dfe-8189-5a63a9d910f7	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
5e9477a9-e50f-40db-b605-8336a602ef29	website	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
9998604c-8fa5-417d-becd-ff2250a9651c	full name	openid-connect	oidc-full-name-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
e786ef0d-d4ed-48e8-9024-59a38ea387d4	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
e3666cdb-4427-4737-b04d-b81ca36496c9	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
86b10742-3279-4459-a68a-937dab261a40	username	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
8b616e83-9474-4f8e-8017-4047a5165191	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
fe728c5a-31cf-4ab6-bd31-e4788856bc9f	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
d617456c-14bb-4c1f-9233-04fca1cee991	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
8fdcaf4c-3231-45a4-9467-29fb7ad576dd	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
be8fe56d-3271-4e97-9f29-ed91e7822576	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
9238f055-0fbb-48b7-9b23-63245b562a85	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
2b0c9741-83a3-425d-93a6-ea53d502af5f	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	2dfe5fb6-8931-4949-be56-b56cf9be2f89
20d2493c-15d6-4bae-8868-b188019d1bc0	email	openid-connect	oidc-usermodel-attribute-mapper	\N	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2
42d6709a-6802-4d8c-8914-14a30af58ef3	email verified	openid-connect	oidc-usermodel-property-mapper	\N	9cd74c63-f9fb-4b96-a5c9-5d2d82b8bed2
c1e80456-00aa-4f8e-9653-4e02271f575e	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	891f7bda-5070-4db6-a750-6ea9a504b3d6
37f793cc-0505-4beb-8be2-13228d1cd20c	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	891f7bda-5070-4db6-a750-6ea9a504b3d6
acc5c569-5c6b-45ee-988a-e060b67bd57b	role list	saml	saml-role-list-mapper	\N	a6852ef6-16ff-44a8-b1aa-d483e1a47bf6
0f501610-975c-457b-9de4-42489f88aad5	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	31b1a221-3acf-459d-956a-02fa1b35fd60
c851c7da-d0fb-4ff5-9dd4-b8c930028bf6	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	31b1a221-3acf-459d-956a-02fa1b35fd60
df82076f-182c-4fcd-9455-2fefcff4d118	audience resolve	openid-connect	oidc-audience-resolve-mapper	5903c266-32ac-43b8-8e2e-bd8f8922a41a	\N
a3200efe-2083-4edb-bd36-320dda5d3fc3	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	\N
78b14a64-9a60-4b02-9f7e-c28f11f17b39	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	\N
5ede2cd5-c31c-4add-a46f-484165988e97	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	\N
8fa9d132-ab2f-47be-80d2-00d7cc29db65	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	34d14c6c-c3cc-4504-859d-4d290900aa1a	\N
399da553-810e-47b0-8b49-90dd51fbdaef	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	34d14c6c-c3cc-4504-859d-4d290900aa1a	\N
377f05a3-9bf1-4a32-a88f-8566ad26c951	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	34d14c6c-c3cc-4504-859d-4d290900aa1a	\N
958de294-45a1-4939-8e2b-402a81969a26	locale	openid-connect	oidc-usermodel-attribute-mapper	726c80f2-9ba7-47e6-89e5-72ffbd9106c6	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
92f8c9ec-c648-491e-81c0-9ce56b8c238b	true	introspection.token.claim
92f8c9ec-c648-491e-81c0-9ce56b8c238b	true	userinfo.token.claim
92f8c9ec-c648-491e-81c0-9ce56b8c238b	locale	user.attribute
92f8c9ec-c648-491e-81c0-9ce56b8c238b	true	id.token.claim
92f8c9ec-c648-491e-81c0-9ce56b8c238b	true	access.token.claim
92f8c9ec-c648-491e-81c0-9ce56b8c238b	locale	claim.name
92f8c9ec-c648-491e-81c0-9ce56b8c238b	String	jsonType.label
ac61a355-31fa-4f4c-aaac-7826b81c91ad	false	single
ac61a355-31fa-4f4c-aaac-7826b81c91ad	Basic	attribute.nameformat
ac61a355-31fa-4f4c-aaac-7826b81c91ad	Role	attribute.name
05c796bc-74b6-46b8-935e-d3a285ae0895	true	introspection.token.claim
05c796bc-74b6-46b8-935e-d3a285ae0895	true	userinfo.token.claim
05c796bc-74b6-46b8-935e-d3a285ae0895	locale	user.attribute
05c796bc-74b6-46b8-935e-d3a285ae0895	true	id.token.claim
05c796bc-74b6-46b8-935e-d3a285ae0895	true	access.token.claim
05c796bc-74b6-46b8-935e-d3a285ae0895	locale	claim.name
05c796bc-74b6-46b8-935e-d3a285ae0895	String	jsonType.label
2f5f7c55-ad00-456b-83d3-401fbfe2c397	true	introspection.token.claim
2f5f7c55-ad00-456b-83d3-401fbfe2c397	true	userinfo.token.claim
2f5f7c55-ad00-456b-83d3-401fbfe2c397	website	user.attribute
2f5f7c55-ad00-456b-83d3-401fbfe2c397	true	id.token.claim
2f5f7c55-ad00-456b-83d3-401fbfe2c397	true	access.token.claim
2f5f7c55-ad00-456b-83d3-401fbfe2c397	website	claim.name
2f5f7c55-ad00-456b-83d3-401fbfe2c397	String	jsonType.label
3a519318-336f-4c73-9836-97168af5fc62	true	introspection.token.claim
3a519318-336f-4c73-9836-97168af5fc62	true	userinfo.token.claim
3a519318-336f-4c73-9836-97168af5fc62	profile	user.attribute
3a519318-336f-4c73-9836-97168af5fc62	true	id.token.claim
3a519318-336f-4c73-9836-97168af5fc62	true	access.token.claim
3a519318-336f-4c73-9836-97168af5fc62	profile	claim.name
3a519318-336f-4c73-9836-97168af5fc62	String	jsonType.label
41758784-31b2-49f1-9343-e206bfe12bf1	true	introspection.token.claim
41758784-31b2-49f1-9343-e206bfe12bf1	true	userinfo.token.claim
41758784-31b2-49f1-9343-e206bfe12bf1	middleName	user.attribute
41758784-31b2-49f1-9343-e206bfe12bf1	true	id.token.claim
41758784-31b2-49f1-9343-e206bfe12bf1	true	access.token.claim
41758784-31b2-49f1-9343-e206bfe12bf1	middle_name	claim.name
41758784-31b2-49f1-9343-e206bfe12bf1	String	jsonType.label
50340705-504b-4d61-bf01-d6b80ae15d4a	true	introspection.token.claim
50340705-504b-4d61-bf01-d6b80ae15d4a	true	userinfo.token.claim
50340705-504b-4d61-bf01-d6b80ae15d4a	zoneinfo	user.attribute
50340705-504b-4d61-bf01-d6b80ae15d4a	true	id.token.claim
50340705-504b-4d61-bf01-d6b80ae15d4a	true	access.token.claim
50340705-504b-4d61-bf01-d6b80ae15d4a	zoneinfo	claim.name
50340705-504b-4d61-bf01-d6b80ae15d4a	String	jsonType.label
7603dca0-cfc5-4ad8-bc18-a1517a84de1b	true	introspection.token.claim
7603dca0-cfc5-4ad8-bc18-a1517a84de1b	true	userinfo.token.claim
7603dca0-cfc5-4ad8-bc18-a1517a84de1b	picture	user.attribute
7603dca0-cfc5-4ad8-bc18-a1517a84de1b	true	id.token.claim
7603dca0-cfc5-4ad8-bc18-a1517a84de1b	true	access.token.claim
7603dca0-cfc5-4ad8-bc18-a1517a84de1b	picture	claim.name
7603dca0-cfc5-4ad8-bc18-a1517a84de1b	String	jsonType.label
8077b7e2-e377-478a-a16e-2e88ae3baf18	true	introspection.token.claim
8077b7e2-e377-478a-a16e-2e88ae3baf18	true	userinfo.token.claim
8077b7e2-e377-478a-a16e-2e88ae3baf18	birthdate	user.attribute
8077b7e2-e377-478a-a16e-2e88ae3baf18	true	id.token.claim
8077b7e2-e377-478a-a16e-2e88ae3baf18	true	access.token.claim
8077b7e2-e377-478a-a16e-2e88ae3baf18	birthdate	claim.name
8077b7e2-e377-478a-a16e-2e88ae3baf18	String	jsonType.label
8d112b56-98a8-47f7-b13e-53fb7fda26c9	true	introspection.token.claim
8d112b56-98a8-47f7-b13e-53fb7fda26c9	true	userinfo.token.claim
8d112b56-98a8-47f7-b13e-53fb7fda26c9	true	id.token.claim
8d112b56-98a8-47f7-b13e-53fb7fda26c9	true	access.token.claim
9034c522-41d8-4f51-8659-00dda16f849c	true	introspection.token.claim
9034c522-41d8-4f51-8659-00dda16f849c	true	userinfo.token.claim
9034c522-41d8-4f51-8659-00dda16f849c	username	user.attribute
9034c522-41d8-4f51-8659-00dda16f849c	true	id.token.claim
9034c522-41d8-4f51-8659-00dda16f849c	true	access.token.claim
9034c522-41d8-4f51-8659-00dda16f849c	preferred_username	claim.name
9034c522-41d8-4f51-8659-00dda16f849c	String	jsonType.label
cd79c8a9-2d27-414f-8c17-0ee3b60846f3	true	introspection.token.claim
cd79c8a9-2d27-414f-8c17-0ee3b60846f3	true	userinfo.token.claim
cd79c8a9-2d27-414f-8c17-0ee3b60846f3	gender	user.attribute
cd79c8a9-2d27-414f-8c17-0ee3b60846f3	true	id.token.claim
cd79c8a9-2d27-414f-8c17-0ee3b60846f3	true	access.token.claim
cd79c8a9-2d27-414f-8c17-0ee3b60846f3	gender	claim.name
cd79c8a9-2d27-414f-8c17-0ee3b60846f3	String	jsonType.label
ced2a05e-02b3-4bbe-939d-034c34732838	true	introspection.token.claim
ced2a05e-02b3-4bbe-939d-034c34732838	true	userinfo.token.claim
ced2a05e-02b3-4bbe-939d-034c34732838	firstName	user.attribute
ced2a05e-02b3-4bbe-939d-034c34732838	true	id.token.claim
ced2a05e-02b3-4bbe-939d-034c34732838	true	access.token.claim
ced2a05e-02b3-4bbe-939d-034c34732838	given_name	claim.name
ced2a05e-02b3-4bbe-939d-034c34732838	String	jsonType.label
e3c9febc-da6b-4a76-ae55-5f6ad481932b	true	introspection.token.claim
e3c9febc-da6b-4a76-ae55-5f6ad481932b	true	userinfo.token.claim
e3c9febc-da6b-4a76-ae55-5f6ad481932b	nickname	user.attribute
e3c9febc-da6b-4a76-ae55-5f6ad481932b	true	id.token.claim
e3c9febc-da6b-4a76-ae55-5f6ad481932b	true	access.token.claim
e3c9febc-da6b-4a76-ae55-5f6ad481932b	nickname	claim.name
e3c9febc-da6b-4a76-ae55-5f6ad481932b	String	jsonType.label
e4df8866-81a9-41bd-8978-b9329ac3a7fa	true	introspection.token.claim
e4df8866-81a9-41bd-8978-b9329ac3a7fa	true	userinfo.token.claim
e4df8866-81a9-41bd-8978-b9329ac3a7fa	lastName	user.attribute
e4df8866-81a9-41bd-8978-b9329ac3a7fa	true	id.token.claim
e4df8866-81a9-41bd-8978-b9329ac3a7fa	true	access.token.claim
e4df8866-81a9-41bd-8978-b9329ac3a7fa	family_name	claim.name
e4df8866-81a9-41bd-8978-b9329ac3a7fa	String	jsonType.label
fc11d840-907a-48e5-85a2-5b717dd26115	true	introspection.token.claim
fc11d840-907a-48e5-85a2-5b717dd26115	true	userinfo.token.claim
fc11d840-907a-48e5-85a2-5b717dd26115	updatedAt	user.attribute
fc11d840-907a-48e5-85a2-5b717dd26115	true	id.token.claim
fc11d840-907a-48e5-85a2-5b717dd26115	true	access.token.claim
fc11d840-907a-48e5-85a2-5b717dd26115	updated_at	claim.name
fc11d840-907a-48e5-85a2-5b717dd26115	long	jsonType.label
20535f64-0719-4c47-b3d2-4a5f9acc6c30	true	introspection.token.claim
20535f64-0719-4c47-b3d2-4a5f9acc6c30	true	userinfo.token.claim
20535f64-0719-4c47-b3d2-4a5f9acc6c30	email	user.attribute
20535f64-0719-4c47-b3d2-4a5f9acc6c30	true	id.token.claim
20535f64-0719-4c47-b3d2-4a5f9acc6c30	true	access.token.claim
20535f64-0719-4c47-b3d2-4a5f9acc6c30	email	claim.name
20535f64-0719-4c47-b3d2-4a5f9acc6c30	String	jsonType.label
fc911088-e9f4-45ff-9e02-a6f55094b2ac	true	introspection.token.claim
fc911088-e9f4-45ff-9e02-a6f55094b2ac	true	userinfo.token.claim
fc911088-e9f4-45ff-9e02-a6f55094b2ac	emailVerified	user.attribute
fc911088-e9f4-45ff-9e02-a6f55094b2ac	true	id.token.claim
fc911088-e9f4-45ff-9e02-a6f55094b2ac	true	access.token.claim
fc911088-e9f4-45ff-9e02-a6f55094b2ac	email_verified	claim.name
fc911088-e9f4-45ff-9e02-a6f55094b2ac	boolean	jsonType.label
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	formatted	user.attribute.formatted
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	country	user.attribute.country
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	true	introspection.token.claim
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	postal_code	user.attribute.postal_code
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	true	userinfo.token.claim
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	street	user.attribute.street
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	true	id.token.claim
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	region	user.attribute.region
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	true	access.token.claim
dacf1f8c-0151-4fa6-b1a2-cdaa8bb33c64	locality	user.attribute.locality
a7550d86-a690-404e-a68d-0a3c7cc8995f	true	introspection.token.claim
a7550d86-a690-404e-a68d-0a3c7cc8995f	true	userinfo.token.claim
a7550d86-a690-404e-a68d-0a3c7cc8995f	phoneNumber	user.attribute
a7550d86-a690-404e-a68d-0a3c7cc8995f	true	id.token.claim
a7550d86-a690-404e-a68d-0a3c7cc8995f	true	access.token.claim
a7550d86-a690-404e-a68d-0a3c7cc8995f	phone_number	claim.name
a7550d86-a690-404e-a68d-0a3c7cc8995f	String	jsonType.label
fba44cc5-85f3-4e27-b8bd-f9595e4b4b59	true	introspection.token.claim
fba44cc5-85f3-4e27-b8bd-f9595e4b4b59	true	userinfo.token.claim
fba44cc5-85f3-4e27-b8bd-f9595e4b4b59	phoneNumberVerified	user.attribute
fba44cc5-85f3-4e27-b8bd-f9595e4b4b59	true	id.token.claim
fba44cc5-85f3-4e27-b8bd-f9595e4b4b59	true	access.token.claim
fba44cc5-85f3-4e27-b8bd-f9595e4b4b59	phone_number_verified	claim.name
fba44cc5-85f3-4e27-b8bd-f9595e4b4b59	boolean	jsonType.label
913656a0-983d-487c-b9a2-18f046eb506f	true	introspection.token.claim
913656a0-983d-487c-b9a2-18f046eb506f	true	multivalued
913656a0-983d-487c-b9a2-18f046eb506f	foo	user.attribute
913656a0-983d-487c-b9a2-18f046eb506f	true	access.token.claim
913656a0-983d-487c-b9a2-18f046eb506f	realm_access.roles	claim.name
913656a0-983d-487c-b9a2-18f046eb506f	String	jsonType.label
ca41ae80-9695-4be4-bd4f-ddaf323485ed	true	introspection.token.claim
ca41ae80-9695-4be4-bd4f-ddaf323485ed	true	multivalued
ca41ae80-9695-4be4-bd4f-ddaf323485ed	foo	user.attribute
ca41ae80-9695-4be4-bd4f-ddaf323485ed	true	access.token.claim
ca41ae80-9695-4be4-bd4f-ddaf323485ed	resource_access.${client_id}.roles	claim.name
ca41ae80-9695-4be4-bd4f-ddaf323485ed	String	jsonType.label
eaf8b238-2f3d-4b0e-9fcd-95e0f5326f23	true	introspection.token.claim
eaf8b238-2f3d-4b0e-9fcd-95e0f5326f23	true	access.token.claim
4f9ee167-32ac-492f-af32-0b7645aa3b82	true	introspection.token.claim
4f9ee167-32ac-492f-af32-0b7645aa3b82	true	access.token.claim
0801917c-e608-4b74-b087-24a3d7d8f60f	true	introspection.token.claim
0801917c-e608-4b74-b087-24a3d7d8f60f	true	multivalued
0801917c-e608-4b74-b087-24a3d7d8f60f	foo	user.attribute
0801917c-e608-4b74-b087-24a3d7d8f60f	true	id.token.claim
0801917c-e608-4b74-b087-24a3d7d8f60f	true	access.token.claim
0801917c-e608-4b74-b087-24a3d7d8f60f	groups	claim.name
0801917c-e608-4b74-b087-24a3d7d8f60f	String	jsonType.label
3acaa1b6-b187-4470-a1f0-d005e4b2d48b	true	introspection.token.claim
3acaa1b6-b187-4470-a1f0-d005e4b2d48b	true	userinfo.token.claim
3acaa1b6-b187-4470-a1f0-d005e4b2d48b	username	user.attribute
3acaa1b6-b187-4470-a1f0-d005e4b2d48b	true	id.token.claim
3acaa1b6-b187-4470-a1f0-d005e4b2d48b	true	access.token.claim
3acaa1b6-b187-4470-a1f0-d005e4b2d48b	upn	claim.name
3acaa1b6-b187-4470-a1f0-d005e4b2d48b	String	jsonType.label
9953be20-69a0-463f-bb84-240e48439007	true	introspection.token.claim
9953be20-69a0-463f-bb84-240e48439007	true	id.token.claim
9953be20-69a0-463f-bb84-240e48439007	true	access.token.claim
2a9eaaff-9623-41c2-8e07-8c928d3a027c	true	introspection.token.claim
2a9eaaff-9623-41c2-8e07-8c928d3a027c	true	access.token.claim
a0c06bca-7e77-4ec0-85a4-8ac438a83ab8	AUTH_TIME	user.session.note
a0c06bca-7e77-4ec0-85a4-8ac438a83ab8	true	introspection.token.claim
a0c06bca-7e77-4ec0-85a4-8ac438a83ab8	true	id.token.claim
a0c06bca-7e77-4ec0-85a4-8ac438a83ab8	true	access.token.claim
a0c06bca-7e77-4ec0-85a4-8ac438a83ab8	auth_time	claim.name
a0c06bca-7e77-4ec0-85a4-8ac438a83ab8	long	jsonType.label
9506d6fd-b6c7-41dc-bace-98893320decc	true	id.token.claim
9506d6fd-b6c7-41dc-bace-98893320decc	true	introspection.token.claim
9506d6fd-b6c7-41dc-bace-98893320decc	true	access.token.claim
9506d6fd-b6c7-41dc-bace-98893320decc	true	userinfo.token.claim
b0c612f9-218c-4a0d-b829-ad27c0392c02	formatted	user.attribute.formatted
b0c612f9-218c-4a0d-b829-ad27c0392c02	country	user.attribute.country
b0c612f9-218c-4a0d-b829-ad27c0392c02	true	introspection.token.claim
b0c612f9-218c-4a0d-b829-ad27c0392c02	postal_code	user.attribute.postal_code
b0c612f9-218c-4a0d-b829-ad27c0392c02	true	userinfo.token.claim
b0c612f9-218c-4a0d-b829-ad27c0392c02	street	user.attribute.street
b0c612f9-218c-4a0d-b829-ad27c0392c02	true	id.token.claim
b0c612f9-218c-4a0d-b829-ad27c0392c02	region	user.attribute.region
b0c612f9-218c-4a0d-b829-ad27c0392c02	true	access.token.claim
b0c612f9-218c-4a0d-b829-ad27c0392c02	locality	user.attribute.locality
0f34359b-96d3-48cc-845d-39a75e95a094	true	introspection.token.claim
0f34359b-96d3-48cc-845d-39a75e95a094	true	access.token.claim
7086ecd3-f401-42a3-9f3e-2910c2ca2891	true	introspection.token.claim
7086ecd3-f401-42a3-9f3e-2910c2ca2891	true	access.token.claim
b721208c-3da6-44a7-a21b-363b06ab679f	AUTH_TIME	user.session.note
b721208c-3da6-44a7-a21b-363b06ab679f	true	introspection.token.claim
b721208c-3da6-44a7-a21b-363b06ab679f	true	userinfo.token.claim
b721208c-3da6-44a7-a21b-363b06ab679f	true	id.token.claim
b721208c-3da6-44a7-a21b-363b06ab679f	true	access.token.claim
b721208c-3da6-44a7-a21b-363b06ab679f	auth_time	claim.name
b721208c-3da6-44a7-a21b-363b06ab679f	long	jsonType.label
053ec2c8-a03a-421c-978d-d87f23308539	foo	user.attribute
053ec2c8-a03a-421c-978d-d87f23308539	true	introspection.token.claim
053ec2c8-a03a-421c-978d-d87f23308539	true	access.token.claim
053ec2c8-a03a-421c-978d-d87f23308539	resource_access.${client_id}.roles	claim.name
053ec2c8-a03a-421c-978d-d87f23308539	String	jsonType.label
053ec2c8-a03a-421c-978d-d87f23308539	true	multivalued
14fbbc54-fdd9-4ce0-a637-0307ca65caf6	true	introspection.token.claim
14fbbc54-fdd9-4ce0-a637-0307ca65caf6	true	access.token.claim
f3d13da6-a7fa-4ad9-ac72-78b4c7dfcf7d	foo	user.attribute
f3d13da6-a7fa-4ad9-ac72-78b4c7dfcf7d	true	introspection.token.claim
f3d13da6-a7fa-4ad9-ac72-78b4c7dfcf7d	true	access.token.claim
f3d13da6-a7fa-4ad9-ac72-78b4c7dfcf7d	realm_access.roles	claim.name
f3d13da6-a7fa-4ad9-ac72-78b4c7dfcf7d	String	jsonType.label
f3d13da6-a7fa-4ad9-ac72-78b4c7dfcf7d	true	multivalued
2b0c9741-83a3-425d-93a6-ea53d502af5f	true	introspection.token.claim
2b0c9741-83a3-425d-93a6-ea53d502af5f	true	userinfo.token.claim
2b0c9741-83a3-425d-93a6-ea53d502af5f	firstName	user.attribute
2b0c9741-83a3-425d-93a6-ea53d502af5f	true	id.token.claim
2b0c9741-83a3-425d-93a6-ea53d502af5f	true	access.token.claim
2b0c9741-83a3-425d-93a6-ea53d502af5f	given_name	claim.name
2b0c9741-83a3-425d-93a6-ea53d502af5f	String	jsonType.label
491101d9-00b3-4840-b706-234b5189bb12	true	introspection.token.claim
491101d9-00b3-4840-b706-234b5189bb12	true	userinfo.token.claim
491101d9-00b3-4840-b706-234b5189bb12	middleName	user.attribute
491101d9-00b3-4840-b706-234b5189bb12	true	id.token.claim
491101d9-00b3-4840-b706-234b5189bb12	true	access.token.claim
491101d9-00b3-4840-b706-234b5189bb12	middle_name	claim.name
491101d9-00b3-4840-b706-234b5189bb12	String	jsonType.label
588c7b24-b48a-4dfe-8189-5a63a9d910f7	true	introspection.token.claim
588c7b24-b48a-4dfe-8189-5a63a9d910f7	true	userinfo.token.claim
588c7b24-b48a-4dfe-8189-5a63a9d910f7	zoneinfo	user.attribute
588c7b24-b48a-4dfe-8189-5a63a9d910f7	true	id.token.claim
588c7b24-b48a-4dfe-8189-5a63a9d910f7	true	access.token.claim
588c7b24-b48a-4dfe-8189-5a63a9d910f7	zoneinfo	claim.name
588c7b24-b48a-4dfe-8189-5a63a9d910f7	String	jsonType.label
5e9477a9-e50f-40db-b605-8336a602ef29	true	introspection.token.claim
5e9477a9-e50f-40db-b605-8336a602ef29	true	userinfo.token.claim
5e9477a9-e50f-40db-b605-8336a602ef29	website	user.attribute
5e9477a9-e50f-40db-b605-8336a602ef29	true	id.token.claim
5e9477a9-e50f-40db-b605-8336a602ef29	true	access.token.claim
5e9477a9-e50f-40db-b605-8336a602ef29	website	claim.name
5e9477a9-e50f-40db-b605-8336a602ef29	String	jsonType.label
86b10742-3279-4459-a68a-937dab261a40	true	introspection.token.claim
86b10742-3279-4459-a68a-937dab261a40	true	userinfo.token.claim
86b10742-3279-4459-a68a-937dab261a40	username	user.attribute
86b10742-3279-4459-a68a-937dab261a40	true	id.token.claim
86b10742-3279-4459-a68a-937dab261a40	true	access.token.claim
86b10742-3279-4459-a68a-937dab261a40	preferred_username	claim.name
86b10742-3279-4459-a68a-937dab261a40	String	jsonType.label
8b616e83-9474-4f8e-8017-4047a5165191	true	introspection.token.claim
8b616e83-9474-4f8e-8017-4047a5165191	true	userinfo.token.claim
8b616e83-9474-4f8e-8017-4047a5165191	gender	user.attribute
8b616e83-9474-4f8e-8017-4047a5165191	true	id.token.claim
8b616e83-9474-4f8e-8017-4047a5165191	true	access.token.claim
8b616e83-9474-4f8e-8017-4047a5165191	gender	claim.name
8b616e83-9474-4f8e-8017-4047a5165191	String	jsonType.label
8fdcaf4c-3231-45a4-9467-29fb7ad576dd	true	introspection.token.claim
8fdcaf4c-3231-45a4-9467-29fb7ad576dd	true	userinfo.token.claim
8fdcaf4c-3231-45a4-9467-29fb7ad576dd	locale	user.attribute
8fdcaf4c-3231-45a4-9467-29fb7ad576dd	true	id.token.claim
8fdcaf4c-3231-45a4-9467-29fb7ad576dd	true	access.token.claim
8fdcaf4c-3231-45a4-9467-29fb7ad576dd	locale	claim.name
8fdcaf4c-3231-45a4-9467-29fb7ad576dd	String	jsonType.label
9238f055-0fbb-48b7-9b23-63245b562a85	true	introspection.token.claim
9238f055-0fbb-48b7-9b23-63245b562a85	true	userinfo.token.claim
9238f055-0fbb-48b7-9b23-63245b562a85	nickname	user.attribute
9238f055-0fbb-48b7-9b23-63245b562a85	true	id.token.claim
9238f055-0fbb-48b7-9b23-63245b562a85	true	access.token.claim
9238f055-0fbb-48b7-9b23-63245b562a85	nickname	claim.name
9238f055-0fbb-48b7-9b23-63245b562a85	String	jsonType.label
9998604c-8fa5-417d-becd-ff2250a9651c	true	id.token.claim
9998604c-8fa5-417d-becd-ff2250a9651c	true	introspection.token.claim
9998604c-8fa5-417d-becd-ff2250a9651c	true	access.token.claim
9998604c-8fa5-417d-becd-ff2250a9651c	true	userinfo.token.claim
be8fe56d-3271-4e97-9f29-ed91e7822576	true	introspection.token.claim
be8fe56d-3271-4e97-9f29-ed91e7822576	true	userinfo.token.claim
be8fe56d-3271-4e97-9f29-ed91e7822576	profile	user.attribute
be8fe56d-3271-4e97-9f29-ed91e7822576	true	id.token.claim
be8fe56d-3271-4e97-9f29-ed91e7822576	true	access.token.claim
be8fe56d-3271-4e97-9f29-ed91e7822576	profile	claim.name
be8fe56d-3271-4e97-9f29-ed91e7822576	String	jsonType.label
d617456c-14bb-4c1f-9233-04fca1cee991	true	introspection.token.claim
d617456c-14bb-4c1f-9233-04fca1cee991	true	userinfo.token.claim
d617456c-14bb-4c1f-9233-04fca1cee991	picture	user.attribute
d617456c-14bb-4c1f-9233-04fca1cee991	true	id.token.claim
d617456c-14bb-4c1f-9233-04fca1cee991	true	access.token.claim
d617456c-14bb-4c1f-9233-04fca1cee991	picture	claim.name
d617456c-14bb-4c1f-9233-04fca1cee991	String	jsonType.label
e3666cdb-4427-4737-b04d-b81ca36496c9	true	introspection.token.claim
e3666cdb-4427-4737-b04d-b81ca36496c9	true	userinfo.token.claim
e3666cdb-4427-4737-b04d-b81ca36496c9	updatedAt	user.attribute
e3666cdb-4427-4737-b04d-b81ca36496c9	true	id.token.claim
e3666cdb-4427-4737-b04d-b81ca36496c9	true	access.token.claim
e3666cdb-4427-4737-b04d-b81ca36496c9	updated_at	claim.name
e3666cdb-4427-4737-b04d-b81ca36496c9	long	jsonType.label
e786ef0d-d4ed-48e8-9024-59a38ea387d4	true	introspection.token.claim
e786ef0d-d4ed-48e8-9024-59a38ea387d4	true	userinfo.token.claim
e786ef0d-d4ed-48e8-9024-59a38ea387d4	birthdate	user.attribute
e786ef0d-d4ed-48e8-9024-59a38ea387d4	true	id.token.claim
e786ef0d-d4ed-48e8-9024-59a38ea387d4	true	access.token.claim
e786ef0d-d4ed-48e8-9024-59a38ea387d4	birthdate	claim.name
e786ef0d-d4ed-48e8-9024-59a38ea387d4	String	jsonType.label
fe728c5a-31cf-4ab6-bd31-e4788856bc9f	true	introspection.token.claim
fe728c5a-31cf-4ab6-bd31-e4788856bc9f	true	userinfo.token.claim
fe728c5a-31cf-4ab6-bd31-e4788856bc9f	lastName	user.attribute
fe728c5a-31cf-4ab6-bd31-e4788856bc9f	true	id.token.claim
fe728c5a-31cf-4ab6-bd31-e4788856bc9f	true	access.token.claim
fe728c5a-31cf-4ab6-bd31-e4788856bc9f	family_name	claim.name
fe728c5a-31cf-4ab6-bd31-e4788856bc9f	String	jsonType.label
20d2493c-15d6-4bae-8868-b188019d1bc0	true	introspection.token.claim
20d2493c-15d6-4bae-8868-b188019d1bc0	true	userinfo.token.claim
20d2493c-15d6-4bae-8868-b188019d1bc0	email	user.attribute
20d2493c-15d6-4bae-8868-b188019d1bc0	true	id.token.claim
20d2493c-15d6-4bae-8868-b188019d1bc0	true	access.token.claim
20d2493c-15d6-4bae-8868-b188019d1bc0	email	claim.name
20d2493c-15d6-4bae-8868-b188019d1bc0	String	jsonType.label
42d6709a-6802-4d8c-8914-14a30af58ef3	true	introspection.token.claim
42d6709a-6802-4d8c-8914-14a30af58ef3	true	userinfo.token.claim
42d6709a-6802-4d8c-8914-14a30af58ef3	emailVerified	user.attribute
42d6709a-6802-4d8c-8914-14a30af58ef3	true	id.token.claim
42d6709a-6802-4d8c-8914-14a30af58ef3	true	access.token.claim
42d6709a-6802-4d8c-8914-14a30af58ef3	email_verified	claim.name
42d6709a-6802-4d8c-8914-14a30af58ef3	boolean	jsonType.label
37f793cc-0505-4beb-8be2-13228d1cd20c	true	introspection.token.claim
37f793cc-0505-4beb-8be2-13228d1cd20c	true	userinfo.token.claim
37f793cc-0505-4beb-8be2-13228d1cd20c	phoneNumber	user.attribute
37f793cc-0505-4beb-8be2-13228d1cd20c	true	id.token.claim
37f793cc-0505-4beb-8be2-13228d1cd20c	true	access.token.claim
37f793cc-0505-4beb-8be2-13228d1cd20c	phone_number	claim.name
37f793cc-0505-4beb-8be2-13228d1cd20c	String	jsonType.label
c1e80456-00aa-4f8e-9653-4e02271f575e	true	introspection.token.claim
c1e80456-00aa-4f8e-9653-4e02271f575e	true	userinfo.token.claim
c1e80456-00aa-4f8e-9653-4e02271f575e	phoneNumberVerified	user.attribute
c1e80456-00aa-4f8e-9653-4e02271f575e	true	id.token.claim
c1e80456-00aa-4f8e-9653-4e02271f575e	true	access.token.claim
c1e80456-00aa-4f8e-9653-4e02271f575e	phone_number_verified	claim.name
c1e80456-00aa-4f8e-9653-4e02271f575e	boolean	jsonType.label
acc5c569-5c6b-45ee-988a-e060b67bd57b	false	single
acc5c569-5c6b-45ee-988a-e060b67bd57b	Basic	attribute.nameformat
acc5c569-5c6b-45ee-988a-e060b67bd57b	Role	attribute.name
0f501610-975c-457b-9de4-42489f88aad5	true	introspection.token.claim
0f501610-975c-457b-9de4-42489f88aad5	true	userinfo.token.claim
0f501610-975c-457b-9de4-42489f88aad5	username	user.attribute
0f501610-975c-457b-9de4-42489f88aad5	true	id.token.claim
0f501610-975c-457b-9de4-42489f88aad5	true	access.token.claim
0f501610-975c-457b-9de4-42489f88aad5	upn	claim.name
0f501610-975c-457b-9de4-42489f88aad5	String	jsonType.label
c851c7da-d0fb-4ff5-9dd4-b8c930028bf6	true	introspection.token.claim
c851c7da-d0fb-4ff5-9dd4-b8c930028bf6	true	multivalued
c851c7da-d0fb-4ff5-9dd4-b8c930028bf6	true	userinfo.token.claim
c851c7da-d0fb-4ff5-9dd4-b8c930028bf6	foo	user.attribute
c851c7da-d0fb-4ff5-9dd4-b8c930028bf6	true	id.token.claim
c851c7da-d0fb-4ff5-9dd4-b8c930028bf6	true	access.token.claim
c851c7da-d0fb-4ff5-9dd4-b8c930028bf6	groups	claim.name
c851c7da-d0fb-4ff5-9dd4-b8c930028bf6	String	jsonType.label
5ede2cd5-c31c-4add-a46f-484165988e97	clientAddress	user.session.note
5ede2cd5-c31c-4add-a46f-484165988e97	true	introspection.token.claim
5ede2cd5-c31c-4add-a46f-484165988e97	true	userinfo.token.claim
5ede2cd5-c31c-4add-a46f-484165988e97	true	id.token.claim
5ede2cd5-c31c-4add-a46f-484165988e97	true	access.token.claim
5ede2cd5-c31c-4add-a46f-484165988e97	clientAddress	claim.name
5ede2cd5-c31c-4add-a46f-484165988e97	String	jsonType.label
78b14a64-9a60-4b02-9f7e-c28f11f17b39	clientHost	user.session.note
78b14a64-9a60-4b02-9f7e-c28f11f17b39	true	introspection.token.claim
78b14a64-9a60-4b02-9f7e-c28f11f17b39	true	userinfo.token.claim
78b14a64-9a60-4b02-9f7e-c28f11f17b39	true	id.token.claim
78b14a64-9a60-4b02-9f7e-c28f11f17b39	true	access.token.claim
78b14a64-9a60-4b02-9f7e-c28f11f17b39	clientHost	claim.name
78b14a64-9a60-4b02-9f7e-c28f11f17b39	String	jsonType.label
a3200efe-2083-4edb-bd36-320dda5d3fc3	client_id	user.session.note
a3200efe-2083-4edb-bd36-320dda5d3fc3	true	introspection.token.claim
a3200efe-2083-4edb-bd36-320dda5d3fc3	true	userinfo.token.claim
a3200efe-2083-4edb-bd36-320dda5d3fc3	true	id.token.claim
a3200efe-2083-4edb-bd36-320dda5d3fc3	true	access.token.claim
a3200efe-2083-4edb-bd36-320dda5d3fc3	client_id	claim.name
a3200efe-2083-4edb-bd36-320dda5d3fc3	String	jsonType.label
377f05a3-9bf1-4a32-a88f-8566ad26c951	clientHost	user.session.note
377f05a3-9bf1-4a32-a88f-8566ad26c951	true	id.token.claim
377f05a3-9bf1-4a32-a88f-8566ad26c951	true	introspection.token.claim
377f05a3-9bf1-4a32-a88f-8566ad26c951	true	access.token.claim
377f05a3-9bf1-4a32-a88f-8566ad26c951	clientHost	claim.name
377f05a3-9bf1-4a32-a88f-8566ad26c951	String	jsonType.label
399da553-810e-47b0-8b49-90dd51fbdaef	clientAddress	user.session.note
399da553-810e-47b0-8b49-90dd51fbdaef	true	id.token.claim
399da553-810e-47b0-8b49-90dd51fbdaef	true	introspection.token.claim
399da553-810e-47b0-8b49-90dd51fbdaef	true	access.token.claim
399da553-810e-47b0-8b49-90dd51fbdaef	clientAddress	claim.name
399da553-810e-47b0-8b49-90dd51fbdaef	String	jsonType.label
8fa9d132-ab2f-47be-80d2-00d7cc29db65	client_id	user.session.note
8fa9d132-ab2f-47be-80d2-00d7cc29db65	true	introspection.token.claim
8fa9d132-ab2f-47be-80d2-00d7cc29db65	true	userinfo.token.claim
8fa9d132-ab2f-47be-80d2-00d7cc29db65	true	id.token.claim
8fa9d132-ab2f-47be-80d2-00d7cc29db65	true	access.token.claim
8fa9d132-ab2f-47be-80d2-00d7cc29db65	client_id	claim.name
8fa9d132-ab2f-47be-80d2-00d7cc29db65	String	jsonType.label
399da553-810e-47b0-8b49-90dd51fbdaef	true	userinfo.token.claim
377f05a3-9bf1-4a32-a88f-8566ad26c951	true	userinfo.token.claim
958de294-45a1-4939-8e2b-402a81969a26	true	introspection.token.claim
958de294-45a1-4939-8e2b-402a81969a26	true	userinfo.token.claim
958de294-45a1-4939-8e2b-402a81969a26	locale	user.attribute
958de294-45a1-4939-8e2b-402a81969a26	true	id.token.claim
958de294-45a1-4939-8e2b-402a81969a26	true	access.token.claim
958de294-45a1-4939-8e2b-402a81969a26	locale	claim.name
958de294-45a1-4939-8e2b-402a81969a26	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
4cdda7bb-b16f-4448-915c-4ad90afbffb2	60	300	1728000	\N	\N	\N	t	f	0	\N	daniele-banco	0	\N	f	f	f	f	NONE	1800	36000	f	f	c5603804-5783-4f30-80cc-add804474cc2	1800	t	pt-BR	f	f	f	f	0	1	30	6	HmacSHA1	totp	be7df27c-e6b9-4171-8b24-60c9c8fc3857	ace4bb7d-ecb4-4dc7-8694-6e7ac6cdacbf	9d39d6ed-eaba-4d17-aba9-3eef2f97082d	77ce2972-d3ec-4b95-b882-4f8b687edf85	9bd766fc-337a-4a92-acf3-4efdfbf5ec82	2592000	f	900	t	f	9e91afc9-1c94-4ad1-b2b5-7ce4a2b8a3d3	0	f	0	0	cba70f92-165f-49b7-b58a-51913282817e
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	79b09991-4e56-4792-9cb0-f2948988c907	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	667eda56-2926-4fb7-a829-ee32d2640fb1	31a19008-28de-4083-a46c-f2d66bb2239d	9426d063-5d1b-4b67-a473-0fb056c38056	d5a8bf4d-f4bf-4188-9ab2-6650a671af82	65f165d1-74a8-48f5-a3bc-3096e70c4c37	2592000	f	900	t	f	fdfd1610-7794-4c07-9fa4-f39c96b1e9a0	0	f	0	0	0dfa2f7b-0116-4b92-ba18-a012db5d9ce6
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	
_browser_header.xContentTypeOptions	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	nosniff
_browser_header.referrerPolicy	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	no-referrer
_browser_header.xRobotsTag	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	none
_browser_header.xFrameOptions	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	SAMEORIGIN
_browser_header.contentSecurityPolicy	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	1; mode=block
_browser_header.strictTransportSecurity	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	max-age=31536000; includeSubDomains
bruteForceProtected	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	false
permanentLockout	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	false
maxTemporaryLockouts	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	0
maxFailureWaitSeconds	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	900
minimumQuickLoginWaitSeconds	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	60
waitIncrementSeconds	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	60
quickLoginCheckMilliSeconds	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	1000
maxDeltaTimeSeconds	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	43200
failureFactor	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	30
realmReusableOtpCode	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	false
firstBrokerLoginFlowId	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	5e000103-921d-410a-9d7f-39fcc5817ed5
displayName	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	Keycloak
displayNameHtml	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	RS256
offlineSessionMaxLifespanEnabled	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	false
offlineSessionMaxLifespan	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	5184000
bruteForceProtected	4cdda7bb-b16f-4448-915c-4ad90afbffb2	false
permanentLockout	4cdda7bb-b16f-4448-915c-4ad90afbffb2	false
maxTemporaryLockouts	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0
maxFailureWaitSeconds	4cdda7bb-b16f-4448-915c-4ad90afbffb2	900
minimumQuickLoginWaitSeconds	4cdda7bb-b16f-4448-915c-4ad90afbffb2	60
waitIncrementSeconds	4cdda7bb-b16f-4448-915c-4ad90afbffb2	60
quickLoginCheckMilliSeconds	4cdda7bb-b16f-4448-915c-4ad90afbffb2	1000
maxDeltaTimeSeconds	4cdda7bb-b16f-4448-915c-4ad90afbffb2	43200
failureFactor	4cdda7bb-b16f-4448-915c-4ad90afbffb2	30
realmReusableOtpCode	4cdda7bb-b16f-4448-915c-4ad90afbffb2	false
displayName	4cdda7bb-b16f-4448-915c-4ad90afbffb2	Daniele Banco
displayNameHtml	4cdda7bb-b16f-4448-915c-4ad90afbffb2	
defaultSignatureAlgorithm	4cdda7bb-b16f-4448-915c-4ad90afbffb2	RS256
offlineSessionMaxLifespanEnabled	4cdda7bb-b16f-4448-915c-4ad90afbffb2	false
offlineSessionMaxLifespan	4cdda7bb-b16f-4448-915c-4ad90afbffb2	5184000
clientSessionIdleTimeout	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0
clientSessionMaxLifespan	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0
clientOfflineSessionIdleTimeout	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0
clientOfflineSessionMaxLifespan	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0
actionTokenGeneratedByAdminLifespan	4cdda7bb-b16f-4448-915c-4ad90afbffb2	43200
actionTokenGeneratedByUserLifespan	4cdda7bb-b16f-4448-915c-4ad90afbffb2	300
oauth2DevicePollingInterval	4cdda7bb-b16f-4448-915c-4ad90afbffb2	5
organizationsEnabled	4cdda7bb-b16f-4448-915c-4ad90afbffb2	false
webAuthnPolicyRpEntityName	4cdda7bb-b16f-4448-915c-4ad90afbffb2	keycloak
webAuthnPolicySignatureAlgorithms	4cdda7bb-b16f-4448-915c-4ad90afbffb2	ES256
webAuthnPolicyRpId	4cdda7bb-b16f-4448-915c-4ad90afbffb2	
webAuthnPolicyAttestationConveyancePreference	4cdda7bb-b16f-4448-915c-4ad90afbffb2	not specified
webAuthnPolicyAuthenticatorAttachment	4cdda7bb-b16f-4448-915c-4ad90afbffb2	not specified
webAuthnPolicyRequireResidentKey	4cdda7bb-b16f-4448-915c-4ad90afbffb2	not specified
webAuthnPolicyUserVerificationRequirement	4cdda7bb-b16f-4448-915c-4ad90afbffb2	not specified
webAuthnPolicyCreateTimeout	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0
webAuthnPolicyAvoidSameAuthenticatorRegister	4cdda7bb-b16f-4448-915c-4ad90afbffb2	false
webAuthnPolicyRpEntityNamePasswordless	4cdda7bb-b16f-4448-915c-4ad90afbffb2	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	4cdda7bb-b16f-4448-915c-4ad90afbffb2	ES256
webAuthnPolicyRpIdPasswordless	4cdda7bb-b16f-4448-915c-4ad90afbffb2	
webAuthnPolicyAttestationConveyancePreferencePasswordless	4cdda7bb-b16f-4448-915c-4ad90afbffb2	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	4cdda7bb-b16f-4448-915c-4ad90afbffb2	not specified
webAuthnPolicyRequireResidentKeyPasswordless	4cdda7bb-b16f-4448-915c-4ad90afbffb2	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	4cdda7bb-b16f-4448-915c-4ad90afbffb2	not specified
webAuthnPolicyCreateTimeoutPasswordless	4cdda7bb-b16f-4448-915c-4ad90afbffb2	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	4cdda7bb-b16f-4448-915c-4ad90afbffb2	false
cibaBackchannelTokenDeliveryMode	4cdda7bb-b16f-4448-915c-4ad90afbffb2	poll
oauth2DeviceCodeLifespan	4cdda7bb-b16f-4448-915c-4ad90afbffb2	1728000
cibaExpiresIn	4cdda7bb-b16f-4448-915c-4ad90afbffb2	120
cibaInterval	4cdda7bb-b16f-4448-915c-4ad90afbffb2	5
cibaAuthRequestedUserHint	4cdda7bb-b16f-4448-915c-4ad90afbffb2	login_hint
parRequestUriLifespan	4cdda7bb-b16f-4448-915c-4ad90afbffb2	60
firstBrokerLoginFlowId	4cdda7bb-b16f-4448-915c-4ad90afbffb2	30f219ab-2998-419b-8457-9d01df1d96d0
frontendUrl	4cdda7bb-b16f-4448-915c-4ad90afbffb2	
acr.loa.map	4cdda7bb-b16f-4448-915c-4ad90afbffb2	{}
client-policies.profiles	4cdda7bb-b16f-4448-915c-4ad90afbffb2	{"profiles":[]}
client-policies.policies	4cdda7bb-b16f-4448-915c-4ad90afbffb2	{"policies":[]}
shortVerificationUri	4cdda7bb-b16f-4448-915c-4ad90afbffb2	
actionTokenGeneratedByUserLifespan.verify-email	4cdda7bb-b16f-4448-915c-4ad90afbffb2	
actionTokenGeneratedByUserLifespan.idp-verify-account-via-email	4cdda7bb-b16f-4448-915c-4ad90afbffb2	
actionTokenGeneratedByUserLifespan.reset-credentials	4cdda7bb-b16f-4448-915c-4ad90afbffb2	
actionTokenGeneratedByUserLifespan.execute-actions	4cdda7bb-b16f-4448-915c-4ad90afbffb2	
_browser_header.contentSecurityPolicyReportOnly	4cdda7bb-b16f-4448-915c-4ad90afbffb2	
_browser_header.xContentTypeOptions	4cdda7bb-b16f-4448-915c-4ad90afbffb2	nosniff
_browser_header.referrerPolicy	4cdda7bb-b16f-4448-915c-4ad90afbffb2	no-referrer
_browser_header.xRobotsTag	4cdda7bb-b16f-4448-915c-4ad90afbffb2	none
_browser_header.xFrameOptions	4cdda7bb-b16f-4448-915c-4ad90afbffb2	SAMEORIGIN
_browser_header.contentSecurityPolicy	4cdda7bb-b16f-4448-915c-4ad90afbffb2	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	4cdda7bb-b16f-4448-915c-4ad90afbffb2	1; mode=block
_browser_header.strictTransportSecurity	4cdda7bb-b16f-4448-915c-4ad90afbffb2	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
483ac10f-3abc-4a20-9938-9b40ad1c4a5d	jboss-logging
4cdda7bb-b16f-4448-915c-4ad90afbffb2	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	483ac10f-3abc-4a20-9938-9b40ad1c4a5d
password	password	t	t	4cdda7bb-b16f-4448-915c-4ad90afbffb2
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
4cdda7bb-b16f-4448-915c-4ad90afbffb2	pt-BR
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.redirect_uris (client_id, value) FROM stdin;
39f21afe-a1fc-4125-94bf-7b361860bcc8	/realms/master/account/*
ceaf3397-b419-4940-b783-4d8d3c73a8dd	/realms/master/account/*
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	/admin/master/console/*
0a7d8d6a-4193-451a-85ac-721665940ae0	/realms/Daniele%20Banco/account/*
5903c266-32ac-43b8-8e2e-bd8f8922a41a	/realms/Daniele%20Banco/account/*
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	/admin/Daniele%20Banco/console/*
34d14c6c-c3cc-4504-859d-4d290900aa1a	/*
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	/login
4c676429-06af-45e5-9e72-04bb4050bde7	/*
6eda79eb-7f71-42e0-9719-9e9fa18d350f	*
6eda79eb-7f71-42e0-9719-9e9fa18d350f	/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
4fcc7bbc-5e41-4c1e-883f-ef2e28c122a4	VERIFY_EMAIL	Verify Email	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	t	f	VERIFY_EMAIL	50
1210bcb1-3a2f-4902-b16c-3d9353f70722	UPDATE_PROFILE	Update Profile	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	t	f	UPDATE_PROFILE	40
d354ac5f-c056-4939-a149-775bc37c70ea	CONFIGURE_TOTP	Configure OTP	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	t	f	CONFIGURE_TOTP	10
da617f09-f7cd-4f77-8018-fa9aa4e38948	UPDATE_PASSWORD	Update Password	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	t	f	UPDATE_PASSWORD	30
2c3321c1-60a6-4e7b-b196-2a558b371d5c	TERMS_AND_CONDITIONS	Terms and Conditions	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	f	f	TERMS_AND_CONDITIONS	20
96dbdaf8-dd10-4379-97ff-2f6b7f045324	delete_account	Delete Account	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	f	f	delete_account	60
3471dbaf-ce45-49f2-8fa3-dd8941f88884	delete_credential	Delete Credential	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	t	f	delete_credential	100
56eaac69-3689-4992-a7da-a71d5d6e4b2b	update_user_locale	Update User Locale	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	t	f	update_user_locale	1000
5a4b5b5d-5d5f-4cc1-9473-22d8c0fd0ea0	webauthn-register	Webauthn Register	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	t	f	webauthn-register	70
f1a9f1a3-94a4-4c0c-9ca1-c968c47ca246	webauthn-register-passwordless	Webauthn Register Passwordless	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	t	f	webauthn-register-passwordless	80
92159210-f912-4045-9795-9a9494b7bd29	VERIFY_PROFILE	Verify Profile	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	t	f	VERIFY_PROFILE	90
30e16dc2-7ba0-44f6-b380-aa70c313d113	CONFIGURE_TOTP	Configure OTP	4cdda7bb-b16f-4448-915c-4ad90afbffb2	t	f	CONFIGURE_TOTP	10
5963b72a-7f08-47eb-a87b-b45a2bf2276a	TERMS_AND_CONDITIONS	Terms and Conditions	4cdda7bb-b16f-4448-915c-4ad90afbffb2	f	f	TERMS_AND_CONDITIONS	20
df01f57d-a159-4228-9876-75a1b74786a5	UPDATE_PASSWORD	Update Password	4cdda7bb-b16f-4448-915c-4ad90afbffb2	t	f	UPDATE_PASSWORD	30
11dce288-31fe-43b5-8ebd-12e030a6a93b	UPDATE_PROFILE	Update Profile	4cdda7bb-b16f-4448-915c-4ad90afbffb2	t	f	UPDATE_PROFILE	40
4112128f-d822-4c76-a5a8-810d84c3c923	VERIFY_EMAIL	Verify Email	4cdda7bb-b16f-4448-915c-4ad90afbffb2	t	f	VERIFY_EMAIL	50
175fa52a-e7b6-47d6-9309-fdee3ca76985	delete_account	Delete Account	4cdda7bb-b16f-4448-915c-4ad90afbffb2	f	f	delete_account	60
01774db6-5df1-4ca9-af52-754f27e1c705	webauthn-register	Webauthn Register	4cdda7bb-b16f-4448-915c-4ad90afbffb2	t	f	webauthn-register	70
b349b3e9-992b-4119-9674-183bd7894ed2	webauthn-register-passwordless	Webauthn Register Passwordless	4cdda7bb-b16f-4448-915c-4ad90afbffb2	t	f	webauthn-register-passwordless	80
d72fbfd1-1231-4350-9eb9-e48df5355320	VERIFY_PROFILE	Verify Profile	4cdda7bb-b16f-4448-915c-4ad90afbffb2	t	f	VERIFY_PROFILE	90
242825f8-876c-4443-9e27-6a423bd7a5dd	delete_credential	Delete Credential	4cdda7bb-b16f-4448-915c-4ad90afbffb2	t	f	delete_credential	100
31dc9098-35fc-4461-8b0c-4d841c416824	update_user_locale	Update User Locale	4cdda7bb-b16f-4448-915c-4ad90afbffb2	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
ceaf3397-b419-4940-b783-4d8d3c73a8dd	5f78b0e7-fe83-428f-9add-2adfced61917
ceaf3397-b419-4940-b783-4d8d3c73a8dd	f33a4d08-504b-4e8f-8444-7a9dac6b22c3
5903c266-32ac-43b8-8e2e-bd8f8922a41a	eec83cfc-115d-4a9a-be21-6d018e491041
5903c266-32ac-43b8-8e2e-bd8f8922a41a	2cb94a31-65d6-44ff-a5b7-aca328ed03e0
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
e81b490d-cfea-4f3e-8648-fe607086ef9e	\N	5f564b78-8600-4caa-9b19-7e847ea3f39c	f	t	\N	\N	\N	483ac10f-3abc-4a20-9938-9b40ad1c4a5d	admin	1744124900490	\N	0
517519df-ee2d-4fbe-96b1-36c62f90a5c9	\N	669090e3-096e-42c7-a387-da5a7d456d23	f	t	\N	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	service-account-camunda-identity-service	1739448318185	a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	0
44325f66-1ad8-4269-ab4a-001c9bb049e6	\N	70723c07-9ff2-4686-a84c-2af507c87e9b	f	t	\N	\N	\N	4cdda7bb-b16f-4448-915c-4ad90afbffb2	service-account-modulos-rpa	1742416638485	34d14c6c-c3cc-4504-859d-4d290900aa1a	0
6c3ae6a2-38f9-4556-ae77-5e331585e058	joao.santos@danielebanco.com.br	joao.santos@danielebanco.com.br	t	t	\N	João Marcos	Tomaz dos Santos	4cdda7bb-b16f-4448-915c-4ad90afbffb2	joao.santos@danielebanco.com.br	1744135111735	\N	0
cfbdb0fa-29de-4312-ade3-c0e86958a301	bpm-api@danielebanco.com.br	bpm-api@danielebanco.com.br	t	t	\N	BPM API	Não Apagar	4cdda7bb-b16f-4448-915c-4ad90afbffb2	bpm-api	1744135217464	\N	0
cfcf6a02-ff46-413c-aa18-49ccdc545ac3	luizgustavo@g4tech.com.br	luizgustavo@g4tech.com.br	f	t	\N	Luiz	Farabello	4cdda7bb-b16f-4448-915c-4ad90afbffb2	luiz-gustavo	1744199569690	\N	0
2a1aa6e6-313d-48ae-b4cd-6a2987f4ec1b	bruno.dias@g4tech.com.br	bruno.dias@g4tech.com.br	t	t	\N	Bruno	Dias	4cdda7bb-b16f-4448-915c-4ad90afbffb2	brunodias	1744204084721	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
cceec5c1-c974-4f3d-aa4b-147fcbaf401d	6c3ae6a2-38f9-4556-ae77-5e331585e058
cceec5c1-c974-4f3d-aa4b-147fcbaf401d	cfbdb0fa-29de-4312-ade3-c0e86958a301
cceec5c1-c974-4f3d-aa4b-147fcbaf401d	cfcf6a02-ff46-413c-aa18-49ccdc545ac3
cceec5c1-c974-4f3d-aa4b-147fcbaf401d	2a1aa6e6-313d-48ae-b4cd-6a2987f4ec1b
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
0dfa2f7b-0116-4b92-ba18-a012db5d9ce6	e81b490d-cfea-4f3e-8648-fe607086ef9e
2e381316-04ae-4ea6-be18-af56a1328a83	e81b490d-cfea-4f3e-8648-fe607086ef9e
cba70f92-165f-49b7-b58a-51913282817e	517519df-ee2d-4fbe-96b1-36c62f90a5c9
4fb62339-354f-436d-9247-008eafc8fc3f	517519df-ee2d-4fbe-96b1-36c62f90a5c9
85a8b9c9-2010-477c-87b8-0d20610d0db5	517519df-ee2d-4fbe-96b1-36c62f90a5c9
971ddae5-1113-4fcd-9e93-415f64cd06e1	517519df-ee2d-4fbe-96b1-36c62f90a5c9
c048c496-22d7-4ad4-8642-c70986d6bff9	517519df-ee2d-4fbe-96b1-36c62f90a5c9
cba70f92-165f-49b7-b58a-51913282817e	44325f66-1ad8-4269-ab4a-001c9bb049e6
dd8b4d57-f784-49d8-811d-37b038c0ffac	e81b490d-cfea-4f3e-8648-fe607086ef9e
1c9de3ca-ce4f-41b1-920a-a121a09524e6	e81b490d-cfea-4f3e-8648-fe607086ef9e
6ade017c-e837-4654-81ff-6909976bd46f	e81b490d-cfea-4f3e-8648-fe607086ef9e
d7af7e5b-1e1c-4d3e-bd73-d1a18780f822	e81b490d-cfea-4f3e-8648-fe607086ef9e
e5e851bb-453e-4a22-89c5-436fba3a5384	e81b490d-cfea-4f3e-8648-fe607086ef9e
75909d00-5833-4c35-9c68-8c758d9f9333	e81b490d-cfea-4f3e-8648-fe607086ef9e
050dcdbd-1b55-4136-a077-ee6c5281790a	e81b490d-cfea-4f3e-8648-fe607086ef9e
93708e97-ebf8-41b1-bc5e-bf6afde4eed2	e81b490d-cfea-4f3e-8648-fe607086ef9e
7309b38f-0520-4361-b704-532b97d0f692	e81b490d-cfea-4f3e-8648-fe607086ef9e
c65befec-8f3a-4b2f-9dff-1ad49d0de413	e81b490d-cfea-4f3e-8648-fe607086ef9e
4ac2ee6d-4860-4800-8923-9b5bb878c499	e81b490d-cfea-4f3e-8648-fe607086ef9e
cf8d638a-71d2-4c1f-a326-7581abf1048f	e81b490d-cfea-4f3e-8648-fe607086ef9e
85eab9bb-8ab6-4dd9-ba4b-800324db28a1	e81b490d-cfea-4f3e-8648-fe607086ef9e
b8239d54-b2aa-420e-84e0-86d9c6fa1956	e81b490d-cfea-4f3e-8648-fe607086ef9e
7331b0e5-2d04-477c-935c-35870dc3d5a6	e81b490d-cfea-4f3e-8648-fe607086ef9e
85c7227a-20f6-458f-90ed-b63d6d3e2dff	e81b490d-cfea-4f3e-8648-fe607086ef9e
47d1b47a-8636-4910-834e-c780b9b3d3ca	e81b490d-cfea-4f3e-8648-fe607086ef9e
cba70f92-165f-49b7-b58a-51913282817e	6c3ae6a2-38f9-4556-ae77-5e331585e058
cba70f92-165f-49b7-b58a-51913282817e	cfbdb0fa-29de-4312-ade3-c0e86958a301
cba70f92-165f-49b7-b58a-51913282817e	cfcf6a02-ff46-413c-aa18-49ccdc545ac3
cba70f92-165f-49b7-b58a-51913282817e	2a1aa6e6-313d-48ae-b4cd-6a2987f4ec1b
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.web_origins (client_id, value) FROM stdin;
d7d45b11-e281-4a96-bbe3-2c960e3fb30a	+
726c80f2-9ba7-47e6-89e5-72ffbd9106c6	+
34d14c6c-c3cc-4504-859d-4d290900aa1a	/*
a6d2df5b-a639-4eec-9f1a-b9fbe8ed5c72	*
4c676429-06af-45e5-9e72-04bb4050bde7	/*
6eda79eb-7f71-42e0-9719-9e9fa18d350f	*
6eda79eb-7f71-42e0-9719-9e9fa18d350f	/*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

