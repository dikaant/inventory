﻿-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/01.types-domains-tables-and-constraints/tables-and-constraints.sql --<--<--
DROP SCHEMA IF EXISTS inventory CASCADE;

CREATE SCHEMA inventory;

--TODO: CREATE UNIQUE INDEXES

CREATE TABLE inventory.units
(
    unit_id                                 SERIAL PRIMARY KEY,
    unit_code                               national character varying(24) NOT NULL,
    unit_name                               national character varying(500) NOT NULL,    
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.compound_units
(
    compound_unit_id                        SERIAL PRIMARY KEY,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    value                                   smallint NOT NULL DEFAULT(0) CHECk(value > 0),
    compare_unit_id                         integer NOT NULL REFERENCES inventory.units,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.supplier_types
(
    supplier_type_id                        SERIAL PRIMARY KEY,
    supplier_type_code                      national character varying(24) NOT NULL,
    supplier_type_name                      national character varying(500) NOT NULL,
	account_id								integer NOT NULL REFERENCES finance.accounts,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.suppliers
(
    supplier_id                             SERIAL PRIMARY KEY,
    supplier_code                           national character varying(24) NOT NULL,
    supplier_name                           national character varying(500) NOT NULL,
	supplier_type_id						integer NOT NULL REFERENCES inventory.supplier_types,
	account_id								integer NOT NULL REFERENCES finance.accounts,
	currency_code							national character varying(12) NOT NULL REFERENCES core.currencies,
    company_name                            national character varying(1000),
    company_address_line_1                  national character varying(128),   
    company_address_line_2                  national character varying(128),
    company_street                          national character varying(1000),
    company_city                            national character varying(1000),
    company_state                           national character varying(1000),
    company_country                         national character varying(1000),
    company_po_box                          national character varying(1000),
    company_zipcode                         national character varying(1000),
    company_phone_numbers                   national character varying(1000),
    company_fax                             national character varying(100),
    logo                                    public.photo,
    contact_first_name                      national character varying(100),
    contact_middle_name                     national character varying(100),
    contact_last_name                       national character varying(100),
    contact_address_line_1                  national character varying(128),   
    contact_address_line_2                  national character varying(128),
    contact_street                          national character varying(100),
    contact_city                            national character varying(100),
    contact_state                           national character varying(100),
    contact_country                         national character varying(100),
    contact_po_box                          national character varying(100),
    contact_zipcode                         national character varying(100),
    contact_phone_numbers                   national character varying(100),
    contact_fax                             national character varying(100),
    photo                                   public.photo,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.customer_types
(
    customer_type_id                        SERIAL PRIMARY KEY,
    customer_type_code                      national character varying(24) NOT NULL,
    customer_type_name                      national character varying(500) NOT NULL,
	account_id								integer NOT NULL REFERENCES finance.accounts,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.customers
(
    customer_id                             SERIAL PRIMARY KEY,
    customer_code                           national character varying(24) NOT NULL,
    customer_name                           national character varying(500) NOT NULL,
    customer_type_id                        integer NOT NULL REFERENCES inventory.customer_types,
	account_id								integer NOT NULL REFERENCES finance.accounts,
	currency_code							national character varying(12) NOT NULL REFERENCES core.currencies,
    company_name                            national character varying(1000),
    company_address_line_1                  national character varying(128),   
    company_address_line_2                  national character varying(128),
    company_street                          national character varying(1000),
    company_city                            national character varying(1000),
    company_state                           national character varying(1000),
    company_country                         national character varying(1000),
    company_po_box                          national character varying(1000),
    company_zipcode                         national character varying(1000),
    company_phone_numbers                   national character varying(1000),
    company_fax                             national character varying(100),
    logo                                    public.photo,
    contact_first_name                      national character varying(100),
    contact_middle_name                     national character varying(100),
    contact_last_name                       national character varying(100),
    contact_address_line_1                  national character varying(128),   
    contact_address_line_2                  national character varying(128),
    contact_street                          national character varying(100),
    contact_city                            national character varying(100),
    contact_state                           national character varying(100),
    contact_country                         national character varying(100),
    contact_po_box                          national character varying(100),
    contact_zipcode                         national character varying(100),
    contact_phone_numbers                   national character varying(100),
    contact_fax                             national character varying(100),
    photo                                   public.photo,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.item_groups
(
    item_group_id                           SERIAL PRIMARY KEY,
    item_group_code                         national character varying(24) NOT NULL,
    item_group_name                         national character varying(500) NOT NULL,
    exclude_from_purchase                   boolean NOT NULL DEFAULT(false),
    exclude_from_sales                      boolean NOT NULL DEFAULT(false),    
    sales_account_id                        bigint NOT NULL REFERENCES finance.accounts,
    sales_discount_account_id               bigint NOT NULL REFERENCES finance.accounts,
    sales_return_account_id                 bigint NOT NULL REFERENCES finance.accounts,
    purchase_account_id                     bigint NOT NULL REFERENCES finance.accounts,
    purchase_discount_account_id            bigint NOT NULL REFERENCES finance.accounts,
    inventory_account_id                    bigint NOT NULL REFERENCES finance.accounts,
    cost_of_goods_sold_account_id           bigint NOT NULL REFERENCES finance.accounts,    
    parent_item_group_id                    integer REFERENCES inventory.item_groups(item_group_id),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.brands
(
    brand_id                                SERIAL PRIMARY KEY,
    brand_code                              national character varying(24) NOT NULL,
    brand_name                              national character varying(500) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.item_types
(
    item_type_id                            SERIAL PRIMARY KEY,
    item_type_code                          national character varying(12) NOT NULL,
    item_type_name                          national character varying(50) NOT NULL,
	is_component							boolean NOT NULL DEFAULT(false),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE UNIQUE INDEX item_type_item_type_code_uix
ON inventory.item_types(UPPER(item_type_code));


CREATE UNIQUE INDEX item_type_item_type_name_uix
ON inventory.item_types(UPPER(item_type_name));


CREATE TABLE inventory.items
(
    item_id                                 SERIAL PRIMARY KEY,
    item_code                               national character varying(24) NOT NULL,
    item_name                               national character varying(500) NOT NULL,
    barcode                                 national character varying(100), --UNIQUE
    item_group_id                           integer NOT NULL REFERENCES inventory.item_groups,
	item_type_id							integer NOT NULL REFERENCES inventory.item_types,
    brand_id                                integer REFERENCES inventory.brands,
    preferred_supplier_id                   integer REFERENCES inventory.suppliers,
    lead_time_in_days                       integer,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    hot_item                                boolean NOT NULL DEFAULT(false),
    cost_price                              public.decimal_strict2,
	cost_price_includes_tax					boolean NOT NULL DEFAULT(false),
    selling_price                           public.decimal_strict2,
	selling_price_includes_tax				boolean NOT NULL DEFAULT(false),
    reorder_level                           public.integer_strict2 NOT NULL DEFAULT(0),
    reorder_quantity                        public.integer_strict2 NOT NULL DEFAULT(0),
	reorder_unit_id                         integer NOT NULL REFERENCES inventory.units,
    maintain_inventory                      boolean NOT NULL DEFAULT(true),
    photo                                   public.photo,
    allow_sales                             boolean NOT NULL DEFAULT(true),
    allow_purchase                          boolean NOT NULL DEFAULT(true),
    is_variant_of                           integer REFERENCES inventory.items,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);


CREATE TABLE inventory.store_types
(
    store_type_id                           SERIAL PRIMARY KEY,
    store_type_code                         national character varying(12) NOT NULL,
    store_type_name                         national character varying(50) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.stores
(
    store_id                                SERIAL PRIMARY KEY,
    store_code                              national character varying(24) NOT NULL,
    store_name                              national character varying(100) NOT NULL,
    store_type_id                           integer NOT NULL REFERENCES inventory.store_types,
	office_id								integer NOT NULL REFERENCES core.offices,
    default_account_id_for_checks           integer NOT NULL REFERENCES finance.accounts,
    default_cash_account_id                 integer NOT NULL REFERENCES finance.accounts,
    default_cash_repository_id              integer NOT NULL REFERENCES finance.cash_repositories,
    address_line_1                          national character varying(128),   
    address_line_2                          national character varying(128),
    street                                  national character varying(50),
    city                                    national character varying(50),
    state                                   national character varying(50),
    country                                 national character varying(50),
    phone                                   national character varying(50),
    fax                                     national character varying(50),
    cell                                    national character varying(50),
    allow_sales                             boolean NOT NULL DEFAULT(true),	
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.counters
(
    counter_id                              SERIAL PRIMARY KEY,
    counter_code                            national character varying(12) NOT NULL,
    counter_name                            national character varying(100) NOT NULL,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.shippers
(
    shipper_id                              SERIAL PRIMARY KEY,
    shipper_code                            national character varying(24),
    company_name                            national character varying(128) NOT NULL,
    shipper_name                            national character varying(150),
    po_box                                  national character varying(128),
    address_line_1                          national character varying(128),   
    address_line_2                          national character varying(128),
    street                                  national character varying(50),
    city                                    national character varying(50),
    state                                   national character varying(50),
    country                                 national character varying(50),
    phone                                   national character varying(50),
    fax                                     national character varying(50),
    cell                                    national character varying(50),
    email                                   national character varying(128),
    url                                     national character varying(50),
    contact_person                          national character varying(50),
    contact_po_box                          national character varying(128),
    contact_address_line_1                  national character varying(128),   
    contact_address_line_2                  national character varying(128),
    contact_street                          national character varying(50),
    contact_city                            national character varying(50),
    contact_state                           national character varying(50),
    contact_country                         national character varying(50),
    contact_email                           national character varying(128),
    contact_phone                           national character varying(50),
    contact_cell                            national character varying(50),
    factory_address                         national character varying(250),
    pan_number                              national character varying(50),
    sst_number                              national character varying(50),
    cst_number                              national character varying(50),
    account_id                              bigint NOT NULL REFERENCES finance.accounts(account_id),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.checkouts
(
    checkout_id                             BIGSERIAL PRIMARY KEY,
	value_date								date NOT NULL,
	book_date								date NOT NULL,
	transaction_master_id					bigint NOT NULL REFERENCES finance.transaction_master,
    transaction_timestamp                   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
    transaction_book                        national character varying(100) NOT NULL, --SALES, PURCHASE, INVENTORY TRANSFER, DAMAGE
	discount								public.decimal_strict2 DEFAULT(0),
    posted_by                               integer NOT NULL REFERENCES account.users,
    /*LOOKUP FIELDS, ONLY TO SPEED UP THE QUERY */
    office_id                               integer NOT NULL REFERENCES core.offices,
    /*LOOKUP FIELDS */    
    cancelled                               boolean NOT NULL DEFAULT(false),
	cancellation_reason						text,
	shipper_id								integer REFERENCES inventory.shippers,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);


CREATE TABLE inventory.checkout_details
(
    checkout_detail_id                      BIGSERIAL PRIMARY KEY,
    checkout_id                             bigint NOT NULL REFERENCES inventory.checkouts,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
	value_date								date NOT NULL,
	book_date								date NOT NULL,
    transaction_type                        national character varying(2) NOT NULL
                                            CHECK(transaction_type IN('Dr', 'Cr')),
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    price                                   public.money_strict NOT NULL,
    discount                                public.money_strict2 NOT NULL DEFAULT(0),    
    cost_of_goods_sold                      public.money_strict2 NOT NULL DEFAULT(0),
    shipping_charge                         public.money_strict2 NOT NULL DEFAULT(0),    
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    quantity                                public.decimal_strict NOT NULL,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           numeric NOT NULL,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW())
);

CREATE TABLE inventory.inventory_transfer_requests
(
    inventory_transfer_request_id           BIGSERIAL PRIMARY KEY,
    office_id                               integer NOT NULL REFERENCES core.offices,
    user_id                                 integer NOT NULL REFERENCES account.users,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
    request_date                            date NOT NULL,
    transaction_timestamp                   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
    reference_number                        national character varying(24),
    statement_reference                     national character varying(500),
    authorized                              boolean NOT NULL DEFAULT(false),
    authorized_by_user_id                   integer REFERENCES account.users,
    authorized_on                           TIMESTAMP WITH TIME ZONE,
    authorization_reason                    national character varying(500),
    rejected                                boolean NOT NULL DEFAULT(false),
    rejected_by_user_id                     integer REFERENCES account.users,
    rejected_on                             TIMESTAMP WITH TIME ZONE,
    rejection_reason                        national character varying(500),
    received                                boolean NOT NULL DEFAULT(false),
    received_by_user_id                     integer REFERENCES account.users,
    received_on                             TIMESTAMP WITH TIME ZONE,
    receipt_memo                            national character varying(500),
    delivered                               boolean NOT NULL DEFAULT(false),
    delivered_by_user_id                    integer REFERENCES account.users,
    delivered_on                            TIMESTAMP WITH TIME ZONE,
    delivery_memo                           national character varying(500),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.inventory_transfer_request_details
(
    inventory_transfer_request_detail_id    BIGSERIAL PRIMARY KEY,
    inventory_transfer_request_id           bigint NOT NULL REFERENCES inventory.inventory_transfer_requests,
    request_date                            date NOT NULL,
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    quantity                                public.decimal_strict2 NOT NULL,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           public.decimal_strict2 NOT NULL
);

CREATE TABLE inventory.inventory_transfer_deliveries
(
    inventory_transfer_delivery_id          BIGSERIAL PRIMARY KEY,
    inventory_transfer_request_id           bigint NOT NULL REFERENCES inventory.inventory_transfer_requests,
    office_id                               integer NOT NULL REFERENCES core.offices,
    user_id                                 integer NOT NULL REFERENCES account.users,
    destination_store_id                    integer NOT NULL REFERENCES inventory.stores,
    delivery_date                           date NOT NULL,
    transaction_timestamp                   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
    reference_number                        national character varying(24),
    statement_reference                     national character varying(500),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.inventory_transfer_delivery_details
(
    inventory_transfer_delivery_detail_id   BIGSERIAL PRIMARY KEY,
    inventory_transfer_delivery_id          bigint NOT NULL REFERENCES inventory.inventory_transfer_deliveries,
    request_date                            date NOT NULL,
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    quantity                                public.decimal_strict2 NOT NULL,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           public.decimal_strict2 NOT NULL
);


CREATE TABLE inventory.attributes
(
	attribute_id                            SERIAL NOT NULL PRIMARY KEY,
	attribute_code                          national character varying(12) NOT NULL UNIQUE,
	attribute_name                          national character varying(100) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.variants
(
	variant_id                              SERIAL NOT NULL PRIMARY KEY,
	variant_code                            national character varying(12) NOT NULL UNIQUE,
	variant_name                            national character varying(100) NOT NULL,
	attribute_id                            integer NOT NULL REFERENCES inventory.attributes,
	attribute_value                         national character varying(200) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.item_variants
(
	item_variant_id                         SERIAL NOT NULL PRIMARY KEY,
	item_id                                 integer NOT NULL REFERENCES inventory.items,
	variant_id                              integer NOT NULL REFERENCES inventory.variants,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.inventory_setup
(
	office_id								integer NOT NULL PRIMARY KEY REFERENCES core.offices,
	inventory_system						national character varying(50) NOT NULL
											CHECK(inventory_system IN('Periodic', 'Perpetual')),
	cogs_calculation_method					national character varying(50) NOT NULL
											CHECK(cogs_calculation_method IN('FIFO', 'LIFO', 'MAVCO')),
	allow_multiple_opening_inventory		boolean NOT NULL DEFAULT(false),
	default_discount_account_id				integer NOT NULL REFERENCES finance.accounts
);

CREATE TYPE inventory.transfer_type
AS
(
    tran_type       national character varying(2),
    store_name      national character varying(50),
    item_code       national character varying(12),
    unit_name       national character varying(50),
    quantity        public.decimal_strict
);

CREATE TYPE inventory.adjustment_type 
AS
(
    tran_type       national character varying(2),
    item_code       national character varying(12),
    unit_name       national character varying(50),
    quantity        public.decimal_strict
);


CREATE TYPE inventory.checkout_detail_type 
AS
(
    store_id            integer,
    item_id           	integer,
    quantity            public.decimal_strict,
    unit_id           	national character varying(50),
    price               public.money_strict,
    discount            public.money_strict2,
    shipping_charge     public.money_strict2
);


CREATE TYPE inventory.opening_stock_type
AS
(
    store_id            integer,
    item_id           	integer,
    quantity            public.decimal_strict,
    unit_id           	integer,
    price          		public.money_strict
);



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.convert_unit.sql --<--<--
DROP FUNCTION IF EXISTS inventory.convert_unit(from_unit integer, to_unit integer);

CREATE FUNCTION inventory.convert_unit(from_unit integer, to_unit integer)
RETURNS decimal
STABLE
AS
$$
    DECLARE _factor decimal;
BEGIN
    IF(inventory.get_root_unit_id($1) != inventory.get_root_unit_id($2)) THEN
        RETURN 0;
    END IF;

    IF($1 = $2) THEN
        RETURN 1.00;
    END IF;
    
    IF(inventory.is_parent_unit($1, $2)) THEN
            WITH RECURSIVE unit_cte(unit_id, value) AS 
            (
                SELECT tn.compare_unit_id, tn.value
                FROM inventory.compound_units AS tn 
				WHERE tn.base_unit_id = $1
				AND NOT tn.deleted

                UNION ALL

                SELECT 
                c.compare_unit_id, c.value * p.value
                FROM unit_cte AS p, 
                inventory.compound_units AS c 
                WHERE base_unit_id = p.unit_id
            )
        SELECT 1.00/value INTO _factor
        FROM unit_cte
        WHERE unit_id=$2;
    ELSE
            WITH RECURSIVE unit_cte(unit_id, value) AS 
            (
             SELECT tn.compare_unit_id, tn.value
                FROM inventory.compound_units AS tn 
				WHERE tn.base_unit_id = $2
				AND NOT tn.deleted
            UNION ALL
             SELECT 
                c.compare_unit_id, c.value * p.value
                FROM unit_cte AS p, 
              inventory.compound_units AS c 
                WHERE base_unit_id = p.unit_id
            )

        SELECT value INTO _factor
        FROM unit_cte
        WHERE unit_id=$1;
    END IF;

    RETURN _factor;
END
$$
LANGUAGE plpgsql;




-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.count_item_in_stock.sql --<--<--
DROP FUNCTION IF EXISTS inventory.count_item_in_stock(_item_id integer, _unit_id integer, _store_id integer);

CREATE FUNCTION inventory.count_item_in_stock(_item_id integer, _unit_id integer, _store_id integer)
RETURNS decimal
STABLE
AS
$$
    DECLARE _debit decimal;
    DECLARE _credit decimal;
    DECLARE _balance decimal;
BEGIN

    _debit := inventory.count_purchases($1, $2, $3);
    _credit := inventory.count_sales($1, $2, $3);

    _balance:= _debit - _credit;    
    return _balance;  
END
$$
LANGUAGE plpgsql;


--SELECT * FROM inventory.count_item_in_stock(1, 1, 1);

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.count_purchases.sql --<--<--
DROP FUNCTION IF EXISTS inventory.count_purchases(_item_id integer, _unit_id integer, _store_id integer);

CREATE FUNCTION inventory.count_purchases(_item_id integer, _unit_id integer, _store_id integer)
RETURNS decimal
STABLE
AS
$$
    DECLARE _base_unit_id integer;
    DECLARE _debit decimal;
    DECLARE _factor decimal;
BEGIN
    --Get the base item unit
    SELECT 
        inventory.get_root_unit_id(inventory.items.unit_id) 
    INTO _base_unit_id
    FROM inventory.items
    WHERE inventory.items.item_id=$1
	AND NOT inventory.items.deleted;

    SELECT
        COALESCE(SUM(base_quantity), 0)
    INTO _debit
    FROM inventory.checkout_details
    INNER JOIN inventory.checkouts
    ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
    INNER JOIN finance.transaction_master
    ON inventory.checkouts.transaction_master_id = finance.transaction_master.transaction_master_id
    WHERE finance.transaction_master.verification_status_id > 0
    AND inventory.checkout_details.item_id=$1
    AND inventory.checkout_details.store_id=$3
    AND inventory.checkout_details.transaction_type='Dr';

    _factor = inventory.convert_unit(_base_unit_id, $2);    
    RETURN _debit * _factor;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.count_sales.sql --<--<--
DROP FUNCTION IF EXISTS inventory.count_sales(_item_id integer, _unit_id integer, _store_id integer);
CREATE FUNCTION inventory.count_sales(_item_id integer, _unit_id integer, _store_id integer)
RETURNS decimal
STABLE
AS
$$
    DECLARE _base_unit_id integer;
    DECLARE _credit decimal;
    DECLARE _factor decimal;
BEGIN
    --Get the base item unit
    SELECT 
        inventory.get_root_unit_id(inventory.items.unit_id) 
    INTO _base_unit_id
    FROM inventory.items
    WHERE inventory.items.item_id=$1
	AND NOT inventory.items.deleted;

    SELECT 
        COALESCE(SUM(base_quantity), 0)
    INTO _credit
    FROM inventory.checkout_details
    INNER JOIN inventory.checkouts
    ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
    INNER JOIN finance.transaction_master
    ON inventory.checkouts.transaction_master_id = finance.transaction_master.transaction_master_id
    WHERE finance.transaction_master.verification_status_id > 0
    AND inventory.checkout_details.item_id=$1
    AND inventory.checkout_details.store_id=$3
    AND inventory.checkout_details.transaction_type='Cr';

    _factor = inventory.convert_unit(_base_unit_id, $2);
    RETURN _credit * _factor;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_account_id_by_customer_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_account_id_by_customer_id(_customer_id bigint);

CREATE FUNCTION inventory.get_account_id_by_customer_id(_customer_id bigint)
RETURNS integer
STABLE
AS
$$
BEGIN
    RETURN inventory.customers.account_id
    FROM inventory.customers
    WHERE inventory.customers.customer_id=_customer_id
    AND NOT inventory.customers.deleted;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_account_id_by_shipper_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_account_id_by_shipper_id(integer);

CREATE FUNCTION inventory.get_account_id_by_shipper_id(_shipper_id integer)
RETURNS integer
STABLE
AS
$$
BEGIN
    RETURN inventory.shippers.account_id
    FROM inventory.shippers
    WHERE inventory.shippers.shipper_id=_shipper_id
    AND NOT inventory.shippers.deleted;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_account_id_by_supplier_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_account_id_by_supplier_id(_supplier_id integer);

CREATE FUNCTION inventory.get_account_id_by_supplier_id(_supplier_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN
        inventory.suppliers.account_id
    FROM inventory.suppliers
    WHERE inventory.suppliers.supplier_id = _supplier_id
    AND NOT inventory.suppliers.deleted;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_account_statement.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_account_statement
(
    _value_date_from        date,
    _value_date_to          date,
    _user_id                integer,
    _item_id                integer,
    _store_id               integer
);

CREATE FUNCTION inventory.get_account_statement
(
    _value_date_from        date,
    _value_date_to          date,
    _user_id                integer,
    _item_id                integer,
    _store_id               integer
)
RETURNS TABLE
(
    id                      integer,
    value_date              date,
    book_date               date,
    tran_code               text,
    statement_reference     text,
    debit                   decimal(24, 4),
    credit                  decimal(24, 4),
    balance                 decimal(24, 4),
    book                    text,
    item_id                 integer,
    item_code               text,
    item_name               text,
    posted_on               TIMESTAMP WITH TIME ZONE,
    posted_by               text,
    approved_by             text,
    verification_status     integer
)
VOLATILE AS
$$
BEGIN

    DROP TABLE IF EXISTS temp_account_statement;
    CREATE TEMPORARY TABLE temp_account_statement
    (
        id                      SERIAL,
        value_date              date,
        book_date               date,
        tran_code               text,
        statement_reference     text,
        debit                   decimal(24, 4),
        credit                  decimal(24, 4),
        balance                 decimal(24, 4),
        book                    text,
        item_id                 integer,
        item_code               text,
        item_name               text,
        posted_on               TIMESTAMP WITH TIME ZONE,
        posted_by               text,
        approved_by             text,
        verification_status     integer
    ) ON COMMIT DROP;

    INSERT INTO temp_account_statement(value_date, statement_reference, debit, item_id)
    SELECT 
        _value_date_from, 
        'Opening Balance',
        SUM
        (
            CASE inventory.checkout_details.transaction_type
            WHEN 'Dr' THEN base_quantity
            ELSE base_quantity * -1 
            END            
        ) as debit,
        _item_id
    FROM inventory.checkout_details
    INNER JOIN inventory.checkouts
    ON inventory.checkout_details.checkout_id = inventory.checkouts.checkout_id
    INNER JOIN finance.transaction_master
    ON inventory.checkouts.transaction_master_id = finance.transaction_master.transaction_master_id
    WHERE finance.transaction_master.verification_status_id > 0
    AND finance.transaction_master.value_date < _value_date_from
    AND inventory.checkout_details.store_id = _store_id
    AND inventory.checkout_details.item_id = _item_id;

    DELETE FROM temp_account_statement
    WHERE COALESCE(temp_account_statement.debit, 0) = 0
    AND COALESCE(temp_account_statement.credit, 0) = 0;

    UPDATE temp_account_statement SET 
    debit = temp_account_statement.credit * -1,
    credit = 0
    WHERE temp_account_statement.credit < 0;

    INSERT INTO temp_account_statement(value_date, book_date, tran_code, statement_reference, debit, credit, book, item_id, posted_on, posted_by, approved_by, verification_status)
    SELECT
        finance.transaction_master.value_date,
        finance.transaction_master.book_date,
        finance.transaction_master.transaction_code,
        finance.transaction_master.statement_reference,
        CASE inventory.checkout_details.transaction_type
        WHEN 'Dr' THEN base_quantity
        ELSE 0 END AS debit,
        CASE inventory.checkout_details.transaction_type
        WHEN 'Cr' THEN base_quantity
        ELSE 0 END AS credit,
        finance.transaction_master.book,
        inventory.checkout_details.item_id,
        finance.transaction_master.transaction_ts AS posted_on,
        account.get_name_by_user_id(finance.transaction_master.user_id),
        account.get_name_by_user_id(finance.transaction_master.verified_by_user_id),
        finance.transaction_master.verification_status_id
    FROM finance.transaction_master
    INNER JOIN inventory.checkouts
    ON finance.transaction_master.transaction_master_id = inventory.checkouts.transaction_master_Id
    INNER JOIN inventory.checkout_details
    ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
    WHERE finance.transaction_master.verification_status_id > 0
    AND finance.transaction_master.value_date >= _value_date_from
    AND finance.transaction_master.value_date <= _value_date_to
    AND inventory.checkout_details.store_id = _store_id 
    AND inventory.checkout_details.item_id = _item_id
    ORDER BY 
        finance.transaction_master.value_date,
        finance.transaction_master.last_verified_on;
    
    UPDATE temp_account_statement
    SET balance = c.balance
    FROM
    (
        SELECT
            temp_account_statement.id, 
            SUM(COALESCE(c.debit, 0)) 
            - 
            SUM(COALESCE(c.credit,0)) As balance
        FROM temp_account_statement
        LEFT JOIN temp_account_statement AS c 
            ON (c.id <= temp_account_statement.id)
        GROUP BY temp_account_statement.id
        ORDER BY temp_account_statement.id
    ) AS c
    WHERE temp_account_statement.id = c.id;

    UPDATE temp_account_statement SET 
        item_code = inventory.items.item_code,
        item_name = inventory.items.item_name
    FROM inventory.items
    WHERE temp_account_statement.item_id = inventory.items.item_id;

        
    RETURN QUERY
    SELECT * FROM temp_account_statement;
END
$$
LANGUAGE plpgsql;



--SELECT * FROM inventory.get_account_statement('1-1-2010', '1-1-2020', 2, 1, 1);




-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_associated_unit_list.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_associated_unit_list(_any_unit_id integer);

CREATE FUNCTION inventory.get_associated_unit_list(_any_unit_id integer)
RETURNS integer[]
VOLATILE
AS
$$
    DECLARE root_unit_id integer;
BEGIN
    DROP TABLE IF EXISTS temp_unit;
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_unit(unit_id integer) ON COMMIT DROP; 
    
    SELECT inventory.get_root_unit_id(_any_unit_id) INTO root_unit_id;
    
    INSERT INTO temp_unit(unit_id) 
    SELECT root_unit_id
    WHERE NOT EXISTS
    (
        SELECT * FROM temp_unit
        WHERE temp_unit.unit_id=root_unit_id
    );
    
    WITH RECURSIVE cte(unit_id)
    AS
    (
         SELECT 
            compare_unit_id
         FROM 
            inventory.compound_units
         WHERE 
            base_unit_id = root_unit_id

        UNION ALL

         SELECT
            units.compare_unit_id
         FROM 
            inventory.compound_units units
         INNER JOIN cte 
         ON cte.unit_id = units.base_unit_id
    )
    
    INSERT INTO temp_unit(unit_id)
    SELECT cte.unit_id FROM cte;
    
    DELETE FROM temp_unit
    WHERE temp_unit.unit_id IS NULL;
    
    RETURN ARRAY(SELECT temp_unit.unit_id FROM temp_unit);
END
$$
LANGUAGE plpgsql;

--SELECT * FROM inventory.get_associated_unit_list(1);

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_associated_units.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_associated_units(_any_unit_id integer);

CREATE FUNCTION inventory.get_associated_units(_any_unit_id integer)
RETURNS TABLE
(
    unit_id integer, 
    unit_code text, 
    unit_name text
)
VOLATILE
AS
$$
    DECLARE root_unit_id integer;
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_unit(unit_id integer) ON COMMIT DROP; 
    
    SELECT inventory.get_root_unit_id(_any_unit_id) INTO root_unit_id;
    
    INSERT INTO temp_unit(unit_id) 
    SELECT root_unit_id
    WHERE NOT EXISTS
    (
        SELECT * FROM temp_unit
        WHERE temp_unit.unit_id=root_unit_id
    );
    
    WITH RECURSIVE cte(unit_id)
    AS
    (
         SELECT 
            compare_unit_id
         FROM 
            inventory.compound_units
         WHERE 
            base_unit_id = root_unit_id

        UNION ALL

         SELECT
            units.compare_unit_id
         FROM 
            inventory.compound_units units
         INNER JOIN cte 
         ON cte.unit_id = units.base_unit_id
    )
    
    INSERT INTO temp_unit(unit_id)
    SELECT cte.unit_id FROM cte;
    
    DELETE FROM temp_unit
    WHERE temp_unit.unit_id IS NULL;
    
    RETURN QUERY 
    SELECT 
        inventory.units.unit_id,
        inventory.units.unit_code::text,
        inventory.units.unit_name::text
    FROM
        inventory.units
    WHERE
        inventory.units.unit_id 
    IN
    (
        SELECT temp_unit.unit_id FROM temp_unit
    );
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_associated_units_by_item_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_associated_units_by_item_id(_item_id integer);

CREATE FUNCTION inventory.get_associated_units_by_item_id(_item_id integer)
RETURNS TABLE
(
    unit_id integer, 
    unit_code text, 
    unit_name text
)
AS
$$
    DECLARE _unit_id integer;
BEGIN
    SELECT inventory.items.unit_id INTO _unit_id
    FROM inventory.items
    WHERE inventory.items.item_id = _item_id
	AND NOT inventory.items.deleted;

    RETURN QUERY
    SELECT * FROM inventory.get_associated_units(_unit_id);
END
$$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS inventory.get_associated_units_by_item_code(_item_code text);

CREATE FUNCTION inventory.get_associated_units_by_item_code(_item_code text)
RETURNS TABLE
(
    unit_id integer, 
    unit_code text, 
    unit_name text
)
AS
$$
    DECLARE _unit_id integer;
BEGIN
    SELECT inventory.items.unit_id INTO _unit_id
    FROM inventory.items
    WHERE LOWER(item_code) = LOWER(_item_code)
	AND NOT inventory.items.deleted;

    RETURN QUERY
    SELECT * FROM inventory.get_associated_units(_unit_id);
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_base_quantity_by_unit_name.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_base_quantity_by_unit_name(text, numeric);

CREATE FUNCTION inventory.get_base_quantity_by_unit_name(text, numeric)
RETURNS decimal
STABLE
AS
$$
	DECLARE _unit_id integer;
	DECLARE _root_unit_id integer;
	DECLARE _factor decimal;
BEGIN
    _unit_id := inventory.get_unit_id_by_unit_name($1);
    _root_unit_id = inventory.get_root_unit_id(_unit_id);
    _factor = inventory.convert_unit(_unit_id, _root_unit_id);

    RETURN _factor * $2;
END
$$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS inventory.get_base_quantity_by_unit_id(integer, numeric);

CREATE FUNCTION inventory.get_base_quantity_by_unit_id(integer, numeric)
RETURNS decimal
STABLE
AS
$$
	DECLARE _root_unit_id integer;
	DECLARE _factor decimal;
BEGIN
    _root_unit_id = inventory.get_root_unit_id($1);
    _factor = inventory.convert_unit($1, _root_unit_id);

    RETURN _factor * $2;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_base_unit_id_by_unit_name.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_base_unit_id_by_unit_name(text);

CREATE FUNCTION inventory.get_base_unit_id_by_unit_name(text)
RETURNS integer
STABLE
AS
$$
DECLARE _unit_id integer;
BEGIN
    _unit_id := inventory.get_unit_id_by_unit_name($1);

    RETURN inventory.get_root_unit_id(_unit_id);
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_brand_id_by_brand_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_brand_id_by_brand_code(text);

CREATE FUNCTION inventory.get_brand_id_by_brand_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN brand_id
        FROM inventory.brands
        WHERE inventory.brands.brand_code=$1
		AND NOT inventory.brands.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_cash_account_id_by_store_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_cash_account_id_by_store_id(_store_id integer);

CREATE FUNCTION inventory.get_cash_account_id_by_store_id(_store_id integer)
RETURNS bigint
STABLE
AS
$$
BEGIN
    RETURN inventory.stores.default_cash_account_id
    FROM inventory.stores
    WHERE inventory.stores.store_id=_store_id
    AND NOT inventory.stores.deleted;
END
$$
LANGUAGE plpgsql;




-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_cash_repository_id_by_store_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_cash_repository_id_by_store_id(_store_id integer);

CREATE FUNCTION inventory.get_cash_repository_id_by_store_id(_store_id integer)
RETURNS bigint
STABLE
AS
$$
BEGIN
    RETURN inventory.stores.default_cash_repository_id
    FROM inventory.stores
    WHERE inventory.stores.store_id=_store_id
    AND NOT inventory.stores.deleted;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_checkout_id_by_transaction_master_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_checkout_id_by_transaction_master_id(_checkout_id bigint);

CREATE FUNCTION inventory.get_checkout_id_by_transaction_master_id(_checkout_id bigint)
RETURNS bigint
AS
$$
BEGIN
        RETURN
        (
            SELECT inventory.checkouts.checkout_id
            FROM inventory.checkouts
            WHERE inventory.checkouts.transaction_master_id=$1
        );
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_cost_of_good_method.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_cost_of_good_method(_office_id integer);

CREATE FUNCTION inventory.get_cost_of_good_method(_office_id integer)
RETURNS text
AS
$$
BEGIN
    RETURN inventory.inventory_setup.cogs_calculation_method
    FROM inventory.inventory_setup
    WHERE inventory.inventory_setup.office_id=$1;
END
$$
LANGUAGE plpgsql;

--SELECT * FROM inventory.get_cost_of_good_method(1);

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_cost_of_goods_sold.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_cost_of_goods_sold(_item_id integer, _unit_id integer, _store_id integer, _quantity decimal);

CREATE FUNCTION inventory.get_cost_of_goods_sold(_item_id integer, _unit_id integer, _store_id integer, _quantity decimal)
RETURNS money_strict
AS
$$
    DECLARE _backup_quantity            decimal;
    DECLARE _base_quantity              decimal;
    DECLARE _base_unit_id               integer;
    DECLARE _base_unit_cost             money_strict;
    DECLARE _total_sold                 integer;
    DECLARE _office_id                  integer = inventory.get_office_id_by_store_id($3);
    DECLARE _method                     text = inventory.get_cost_of_good_method(_office_id);
BEGIN
    --backup base quantity in decimal
    _backup_quantity                := inventory.get_base_quantity_by_unit_id($2, $4);
    --convert base quantity to whole number
    _base_quantity                  := CEILING(_backup_quantity);
    _base_unit_id                   := inventory.get_root_unit_id($2);
        
    IF(_method = 'MAVCO') THEN
        --RAISE NOTICE '% % % %',_item_id, _store_id, _base_quantity, 1.00;
        RETURN transactions.get_mavcogs(_item_id, _store_id, _base_quantity, 1.00);
    END IF; 


    SELECT COALESCE(SUM(base_quantity), 0) INTO _total_sold
    FROM inventory.verified_checkout_details_view
    WHERE transaction_type='Cr';

    DROP TABLE IF EXISTS temp_cost_of_goods_sold;
    CREATE TEMPORARY TABLE temp_cost_of_goods_sold
    (
        id                     BIGSERIAL,
        checkout_detail_id     bigint,
        audit_ts               TIMESTAMP WITH TIME ZONE,
        value_date             date,
        price                  money_strict,
        transaction_type       text
                    
    ) ON COMMIT DROP;


    /*TODO:
    ALTERNATIVE AND MUCH EFFICIENT APPROACH
        SELECT
            *,
            (
                SELECT SUM(base_quantity)
                FROM inventory.verified_checkout_details_view AS i
                WHERE i.checkout_detail_id <= v.checkout_detail_id
                AND item_id = 1
            ) AS total
        FROM inventory.verified_checkout_details_view AS v
        WHERE item_id = 1
        ORDER BY value_date, checkout_id;
    */
    WITH stock_cte AS
    (
        SELECT
            checkout_detail_id, 
            audit_ts,
            value_date,
            generate_series(1, base_quantity::integer) AS series,
            (price * quantity) / base_quantity AS price,
            transaction_type
        FROM inventory.verified_checkout_details_view
        WHERE item_id = $1
        AND store_id = $3
    )
        
    INSERT INTO temp_cost_of_goods_sold(checkout_detail_id, audit_ts, value_date, price, transaction_type)
    SELECT checkout_detail_id, audit_ts, value_date, price, transaction_type FROM stock_cte
    ORDER BY value_date, audit_ts, checkout_detail_id;


    IF(_method = 'LIFO') THEN
        SELECT SUM(price) INTO _base_unit_cost
        FROM 
        (
            SELECT price
            FROM temp_cost_of_goods_sold
            WHERE transaction_type ='Dr'
            ORDER BY id DESC
            OFFSET _total_sold
            LIMIT _base_quantity
        ) S;
    ELSIF (_method = 'FIFO') THEN
        SELECT SUM(price) INTO _base_unit_cost
        FROM 
        (
            SELECT price
            FROM temp_cost_of_goods_sold
            WHERE transaction_type ='Dr'
            ORDER BY id
            OFFSET _total_sold
            LIMIT _base_quantity
        ) S;
    ELSIF (_method != 'MAVCO') THEN
        RAISE EXCEPTION 'Invalid configuration: COGS method.'
        USING ERRCODE='P6010';
    END IF;

    --APPLY DECIMAL QUANTITY PROVISON
    _base_unit_cost := _base_unit_cost * (_backup_quantity / _base_quantity);

    RETURN _base_unit_cost;
END
$$
LANGUAGE PLPGSQL;

--SELECT * FROM inventory.get_cost_of_goods_sold(1,1, 1, 3.5);

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_cost_of_goods_sold_account_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_cost_of_goods_sold_account_id(_item_id integer);

CREATE FUNCTION inventory.get_cost_of_goods_sold_account_id(_item_id integer)
RETURNS integer
STABLE
AS
$$
BEGIN
    RETURN
        cost_of_goods_sold_account_id
    FROM inventory.item_groups
    INNER JOIN inventory.items
    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
    WHERE inventory.items.item_id = $1
	AND NOT inventory.item_groups.deleted;    
END
$$
LANGUAGE plpgsql;

--SELECT inventory.get_cost_of_goods_sold_account_id(1);

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_currency_code_by_customer_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_currency_code_by_customer_id(_customer_id integer);

CREATE FUNCTION inventory.get_currency_code_by_customer_id(_customer_id integer)
RETURNS national character varying(12)
AS
$$
BEGIN
    RETURN inventory.customers.currency_code
    FROM inventory.customers
    WHERE inventory.customers.customer_id = _customer_id
    AND NOT inventory.customers.deleted;
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_currency_code_by_supplier_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_currency_code_by_supplier_id(_supplier_id integer);

CREATE FUNCTION inventory.get_currency_code_by_supplier_id(_supplier_id integer)
RETURNS national character varying(12)
AS
$$
BEGIN
    RETURN inventory.suppliers.currency_code
    FROM inventory.suppliers
    WHERE inventory.suppliers.supplier_id = _supplier_id
    AND NOT inventory.suppliers.deleted;
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_customer_id_by_customer_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_customer_id_by_customer_code(text);

CREATE FUNCTION inventory.get_customer_id_by_customer_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN customer_id
        FROM inventory.customers
        WHERE inventory.customers.customer_code=$1
		AND NOT inventory.customers.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_customer_type_id_by_customer_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_customer_type_id_by_customer_id(_customer_id integer);

CREATE FUNCTION inventory.get_customer_type_id_by_customer_id(_customer_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN inventory.customers.customer_type_id
    FROM inventory.customers
    WHERE inventory.customers.customer_id = _customer_id
    AND NOT inventory.customers.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_customer_type_id_by_customer_type_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_customer_type_id_by_customer_type_code(text);

CREATE FUNCTION inventory.get_customer_type_id_by_customer_type_code(text)
RETURNS integer
STABLE
AS
$$
BEGIN
    RETURN customer_type_id
    FROM inventory.customer_types
    WHERE inventory.customer_types.customer_type_code=$1
	AND NOT inventory.customer_types.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_inventory_account_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_inventory_account_id(_item_id integer);

CREATE FUNCTION inventory.get_inventory_account_id(_item_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN
        inventory_account_id
    FROM inventory.item_groups
    INNER JOIN inventory.items
    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
    WHERE inventory.items.item_id = $1
	AND NOT inventory.item_groups.deleted;    
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_item_cost_price.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_item_cost_price(_item_id integer, _unit_id integer);

CREATE FUNCTION inventory.get_item_cost_price(_item_id integer, _unit_id integer)
RETURNS public.money_strict2
STABLE
AS
$$
    DECLARE _price              public.money_strict2;
    DECLARE _costing_unit_id    integer;
    DECLARE _factor             decimal;
  
BEGIN    
    SELECT 
        cost_price, 
        unit_id
    INTO 
        _price, 
        _costing_unit_id
    FROM inventory.items
    WHERE inventory.items.item_id = _item_id
	AND NOT inventory.items.deleted;

    --Get the unitary conversion factor if the requested unit does not match with the price defition.
    _factor := inventory.convert_unit(_unit_id, _costing_unit_id);
    RETURN _price * _factor;
END
$$
LANGUAGE plpgsql;

--SELECT * FROM inventory.get_item_cost_price(6, 7);


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_item_group_id_by_item_group_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_item_group_id_by_item_group_code(text);

CREATE FUNCTION inventory.get_item_group_id_by_item_group_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN item_group_id
        FROM inventory.item_groups
        WHERE inventory.item_groups.item_group_code=$1
		AND NOT inventory.item_groups.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_item_id_by_item_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_item_id_by_item_code(_item_code text);

CREATE FUNCTION inventory.get_item_id_by_item_code(_item_code text)
RETURNS integer
AS
$$
BEGIN
    RETURN item_id
    FROM inventory.items
    WHERE inventory.items.item_code = _item_code
	AND NOT inventory.items.deleted;
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_item_name_by_item_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_item_name_by_item_id(item_id_ int);

CREATE OR REPLACE FUNCTION inventory.get_item_name_by_item_id(item_id_ int)
  RETURNS character varying(50) AS
$$
BEGIN
    RETURN item_name
    FROM inventory.items
    WHERE inventory.items.item_id = item_id_
	AND NOT inventory.items.deleted;
END
$$
  LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_item_type_id_by_item_type_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_item_type_id_by_item_type_code(text);

CREATE FUNCTION inventory.get_item_type_id_by_item_type_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN item_type_id
        FROM inventory.item_types
        WHERE inventory.item_types.item_type_code=$1
		AND NOT inventory.item_types.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_mavcogs.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_mavcogs(_item_id integer, _store_id integer, _base_quantity decimal, _factor decimal(24, 4));

CREATE FUNCTION inventory.get_mavcogs(_item_id integer, _store_id integer, _base_quantity decimal, _factor decimal(24, 4))
RETURNS decimal(24, 4)
AS
$$
    DECLARE _base_unit_cost money_strict;
BEGIN
    CREATE TEMPORARY TABLE temp_staging
    (
            id              SERIAL NOT NULL,
            value_date      date,
            audit_ts        TIMESTAMP WITH TIME ZONE,
            base_quantity   decimal,
            price           decimal
            
    ) ON COMMIT DROP;


    INSERT INTO temp_staging(value_date, audit_ts, base_quantity, price)
    SELECT value_date, audit_ts, 
    CASE WHEN tran_type = 'Dr' THEN
    base_quantity ELSE base_quantity  * -1 END, 
    CASE WHEN tran_type = 'Dr' THEN
    (price * quantity/base_quantity)
    ELSE
    0
    END
    FROM inventory.verified_checkout_details_view
    WHERE item_id = $1
    AND store_id=$2
    order by value_date, audit_ts, stock_detail_id;




    WITH RECURSIVE stock_transaction(id, base_quantity, price, sum_m, sum_base_quantity, last_id) AS 
    (
      SELECT id, base_quantity, price, base_quantity * price, base_quantity, id
      FROM temp_staging WHERE id = 1
      UNION ALL
      SELECT child.id, child.base_quantity, 
             CASE WHEN child.base_quantity < 0 then parent.sum_m / parent.sum_base_quantity ELSE child.price END, 
             parent.sum_m + CASE WHEN child.base_quantity < 0 then parent.sum_m / parent.sum_base_quantity ELSE child.price END * child.base_quantity,
             parent.sum_base_quantity + child.base_quantity,
             child.id 
      FROM temp_staging child JOIN stock_transaction parent on child.id = parent.last_id + 1
    )

    SELECT 
            --base_quantity,                                                        --left for debuging purpose
            --price,                                                                --left for debuging purpose
            --base_quantity * price AS amount,                                      --left for debuging purpose
            --SUM(base_quantity * price) OVER(ORDER BY id) AS cv_amount,            --left for debuging purpose
            --SUM(base_quantity) OVER(ORDER BY id) AS cv_quantity,                  --left for debuging purpose
            SUM(base_quantity * price) OVER(ORDER BY id)  / SUM(base_quantity) OVER(ORDER BY id) INTO _base_unit_cost
    FROM stock_transaction
    ORDER BY id DESC
    LIMIT 1;

    RETURN _base_unit_cost * _factor * _base_quantity;
END
$$
LANGUAGE plpgsql;




-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_office_id_by_store_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_office_id_by_store_id(integer);

CREATE FUNCTION inventory.get_office_id_by_store_id(integer)
RETURNS integer
AS
$$
BEGIN
    RETURN inventory.stores.office_id
    FROM inventory.stores
    WHERE inventory.stores.store_id=$1
	AND NOT inventory.stores.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_opening_inventory_status.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_opening_inventory_status
(
    _office_id                                      integer
);

CREATE FUNCTION inventory.get_opening_inventory_status
(
    _office_id                                      integer
)
RETURNS TABLE
(
    office_id                                       integer,
    multiple_inventory_allowed                      boolean,
    has_opening_inventory                           boolean
)
STABLE
AS
$$
    DECLARE _multiple_inventory_allowed             boolean;
    DECLARE _has_opening_inventory                  boolean = false;

BEGIN
    SELECT inventory.inventory_setup.allow_multiple_opening_inventory 
    INTO _multiple_inventory_allowed    
    FROM inventory.inventory_setup
    WHERE inventory.inventory_setup.office_id = _office_id;

    IF EXISTS
    (
        SELECT 1
        FROM finance.transaction_master
        WHERE finance.transaction_master.book = 'Opening Inventory'
        AND finance.transaction_master.office_id = _office_id
    ) THEN
        _has_opening_inventory                      := true;
    END IF;
    
    RETURN QUERY
    SELECT _office_id, _multiple_inventory_allowed, _has_opening_inventory;
END
$$
LANGUAGE plpgsql;

--SELECT * FROM inventory.get_opening_inventory_status(1);

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_purchase_account_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_purchase_account_id(_item_id integer);

CREATE FUNCTION inventory.get_purchase_account_id(_item_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN
        purchase_account_id
    FROM inventory.item_groups
    INNER JOIN inventory.items
    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
    WHERE inventory.items.item_id = $1
	AND NOT inventory.item_groups.deleted;    
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_purchase_discount_account_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_purchase_discount_account_id(_item_id integer);

CREATE FUNCTION inventory.get_purchase_discount_account_id(_item_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN
        purchase_discount_account_id
    FROM inventory.item_groups
    INNER JOIN inventory.items
    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
    WHERE inventory.items.item_id = $1
	AND NOT inventory.item_groups.deleted;    
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_root_unit_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_root_unit_id(_any_unit_id integer);

CREATE FUNCTION inventory.get_root_unit_id(_any_unit_id integer)
RETURNS integer
AS
$$
    DECLARE root_unit_id integer;
BEGIN
    SELECT base_unit_id INTO root_unit_id
    FROM inventory.compound_units
    WHERE inventory.compound_units.compare_unit_id=_any_unit_id
	AND NOT inventory.compound_units.deleted;

    IF(root_unit_id IS NULL) THEN
        RETURN _any_unit_id;
    ELSE
        RETURN inventory.get_root_unit_id(root_unit_id);
    END IF; 
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_sales_account_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_sales_account_id(_item_id integer);

CREATE FUNCTION inventory.get_sales_account_id(_item_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN inventory.item_groups.sales_account_id
    FROM inventory.item_groups
    INNER JOIN inventory.items
    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
    WHERE inventory.items.item_id = _item_id
    AND NOT inventory.item_groups.deleted;    
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_sales_discount_account_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_sales_discount_account_id(_item_id integer);

CREATE FUNCTION inventory.get_sales_discount_account_id(_item_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN inventory.item_groups.sales_discount_account_id
    FROM inventory.item_groups
    INNER JOIN inventory.items
    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
    WHERE inventory.items.item_id = _item_id
    AND NOT inventory.item_groups.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_sales_return_account_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_sales_return_account_id(_item_id integer);

CREATE FUNCTION inventory.get_sales_return_account_id(_item_id integer)
RETURNS integer
AS
$$
BEGIN
    RETURN inventory.item_groups.sales_return_account_id
    FROM inventory.item_groups
    INNER JOIN inventory.items
    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
    WHERE inventory.items.item_id = _item_id
    AND NOT inventory.item_groups.deleted;    
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_shipper_id_by_shipper_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_shipper_id_by_shipper_code(_shipper_code national character varying(24));

CREATE FUNCTION inventory.get_shipper_id_by_shipper_code(_shipper_code national character varying(24))
RETURNS integer
AS
$$
BEGIN
    RETURN inventory.shippers.shipper_id
    FROM inventory.shippers
    WHERE inventory.shippers.shipper_code = _shipper_code;
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_shipper_id_by_shipper_name.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_shipper_id_by_shipper_name(_shipper_name national character varying(24));

CREATE FUNCTION inventory.get_shipper_id_by_shipper_name(_shipper_name national character varying(24))
RETURNS integer
AS
$$
BEGIN
    RETURN inventory.shippers.shipper_id
    FROM inventory.shippers
    WHERE inventory.shippers.shipper_name = _shipper_name;
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_store_id_by_store_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_store_id_by_store_code(_store_code text);

CREATE FUNCTION inventory.get_store_id_by_store_code(_store_code text)
RETURNS integer
STABLE
AS
$$
BEGIN
    RETURN
    (
        SELECT inventory.stores.store_id
        FROM inventory.stores
        WHERE inventory.stores.store_code=_store_code 
        AND NOT inventory.stores.deleted
    );
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_store_id_by_store_name.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_store_id_by_store_name(_store_name text);

CREATE FUNCTION inventory.get_store_id_by_store_name(_store_name text)
RETURNS integer
AS
$$
BEGIN
    RETURN store_id
    FROM inventory.stores
    WHERE inventory.stores.store_name = _store_name
	AND NOT inventory.stores.deleted;
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_store_type_id_by_store_type_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_store_type_id_by_store_type_code(text);

CREATE FUNCTION inventory.get_store_type_id_by_store_type_code(text)
RETURNS integer
STABLE
AS
$$
BEGIN
    RETURN store_type_id
    FROM inventory.store_types
    WHERE inventory.store_types.store_type_code=$1
	AND NOT inventory.store_types.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_supplier_id_by_supplier_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_supplier_id_by_supplier_code(text);

CREATE FUNCTION inventory.get_supplier_id_by_supplier_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN supplier_id
        FROM inventory.suppliers
        WHERE inventory.suppliers.supplier_code=$1
		AND NOT inventory.suppliers.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_supplier_type_id_by_supplier_type_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_supplier_type_id_by_supplier_type_code(text);

CREATE FUNCTION inventory.get_supplier_type_id_by_supplier_type_code(text)
RETURNS integer
STABLE
AS
$$
BEGIN
    RETURN supplier_type_id
    FROM inventory.supplier_types
    WHERE inventory.supplier_types.supplier_type_code=$1
	AND NOT inventory.supplier_types.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_unit_id_by_unit_code.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_unit_id_by_unit_code(text);

CREATE FUNCTION inventory.get_unit_id_by_unit_code(text)
RETURNS integer
AS
$$
BEGIN
        RETURN inventory.units.unit_id
        FROM inventory.units
        WHERE inventory.units.unit_code=$1
		AND NOT inventory.units.deleted;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_unit_id_by_unit_name.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_unit_id_by_unit_name(_unit_name text);

CREATE FUNCTION inventory.get_unit_id_by_unit_name(_unit_name text)
RETURNS integer
AS
$$
BEGIN
    RETURN unit_id
    FROM inventory.units
    WHERE inventory.units.unit_name = _unit_name
	AND NOT inventory.units.deleted;
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_unit_name_by_unit_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_unit_name_by_unit_id(_unit_id integer);

CREATE FUNCTION inventory.get_unit_name_by_unit_id(_unit_id integer)
RETURNS national character varying(1000)
AS
$$
BEGIN
    RETURN unit_name
    FROM inventory.units
    WHERE inventory.units.unit_id = _unit_id
	AND NOT inventory.units.deleted;
END
$$
LANGUAGE plpgsql;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.get_write_off_cost_of_goods_sold.sql --<--<--
DROP FUNCTION IF EXISTS inventory.get_write_off_cost_of_goods_sold(_checkout_id bigint, _item_id integer, _unit_id integer, _quantity integer);

CREATE FUNCTION inventory.get_write_off_cost_of_goods_sold(_checkout_id bigint, _item_id integer, _unit_id integer, _quantity integer)
RETURNS money_strict2
AS
$$
    DECLARE _base_unit_id integer;
    DECLARE _factor decimal;
BEGIN
    _base_unit_id    = inventory.get_root_unit_id(_unit_id);
    _factor          = inventory.convert_unit(_unit_id, _base_unit_id);


    RETURN
        SUM((cost_of_goods_sold / base_quantity) * _factor * _quantity)     
         FROM inventory.checkout_details
    WHERE checkout_id = _checkout_id
    AND item_id = _item_id;    
END
$$
LANGUAGE plpgsql;


--SELECT * FROM inventory.get_write_off_cost_of_goods_sold(7, 3, 1, 1);


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.is_parent_unit.sql --<--<--
DROP FUNCTION IF EXISTS inventory.is_parent_unit(parent integer, child integer);

CREATE FUNCTION inventory.is_parent_unit(parent integer, child integer)
RETURNS boolean
AS
$$      
BEGIN
    IF $1!=$2 THEN
        IF EXISTS
        (
            WITH RECURSIVE unit_cte(unit_id) AS 
            (
             SELECT tn.compare_unit_id
                FROM inventory.compound_units AS tn 
				WHERE tn.base_unit_id = $1
				AND NOT tn.deleted
            UNION ALL
             SELECT
                c.compare_unit_id
                FROM unit_cte AS p, 
              inventory.compound_units AS c 
                WHERE base_unit_id = p.unit_id
            )

            SELECT * FROM unit_cte
            WHERE unit_id=$2
        ) THEN
            RETURN TRUE;
        END IF;
    END IF;
    RETURN false;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.is_periodic_inventory.sql --<--<--
DROP FUNCTION IF EXISTS inventory.is_periodic_inventory(_office_id integer);

CREATE FUNCTION inventory.is_periodic_inventory(_office_id integer)
RETURNS boolean
AS
$$
BEGIN
    IF EXISTS(SELECT * FROM inventory.inventory_setup WHERE inventory_system = 'Periodic' AND office_id = _office_id) THEN
        RETURN true;
    END IF;

    RETURN false;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.is_purchase.sql --<--<--
DROP FUNCTION IF EXISTS inventory.is_purchase(_transaction_master_id bigint);

CREATE FUNCTION inventory.is_purchase(_transaction_master_id bigint)
RETURNS boolean
AS
$$
BEGIN
    IF EXISTS
    (
        SELECT * FROM finance.transaction_master
        WHERE finance.transaction_master.transaction_master_id = $1
        AND book IN ('Purchase')
    ) THEN
            RETURN true;
    END IF;

    RETURN false;
END
$$
LANGUAGE plpgsql;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.is_valid_unit_id.sql --<--<--
DROP FUNCTION IF EXISTS inventory.is_valid_unit_id(_unit_id integer, _item_id integer);

CREATE FUNCTION inventory.is_valid_unit_id(_unit_id integer, _item_id integer)
RETURNS boolean
AS
$$
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inventory.items
        WHERE inventory.items.item_id = $2
        AND inventory.get_root_unit_id($1) = inventory.get_root_unit_id(unit_id)
		AND NOT inventory.items.deleted
    ) THEN
        RETURN true;
    END IF;

    RETURN false;
END
$$
LANGUAGE plpgsql;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.list_closing_stock.sql --<--<--
DROP FUNCTION IF EXISTS inventory.list_closing_stock
(
    _store_id               integer
);

CREATE FUNCTION inventory.list_closing_stock
(
    _store_id               integer
)
RETURNS
TABLE
(
    item_id                 integer,
    item_code               text,
    item_name               text,
    unit_id                 integer,
    unit_name               text,
    quantity                decimal
)
AS
$$
BEGIN
    DROP TABLE IF EXISTS temp_closing_stock;

    CREATE TEMPORARY TABLE temp_closing_stock
    (
        item_id             integer,
        item_code           text,
        item_name           text,
        unit_id             integer,
        unit_name           text,
        quantity            decimal,
        maintain_inventory  boolean
    ) ON COMMIT DROP;

    INSERT INTO temp_closing_stock(item_id, unit_id, quantity)
    SELECT 
        inventory.verified_checkout_details_view.item_id, 
        inventory.verified_checkout_details_view.base_unit_id,
        SUM(CASE WHEN inventory.verified_checkout_details_view.transaction_type='Dr' THEN inventory.verified_checkout_details_view.base_quantity ELSE inventory.verified_checkout_details_view.base_quantity * -1 END)
    FROM inventory.verified_checkout_details_view
    WHERE inventory.verified_checkout_details_view.store_id = _store_id
    GROUP BY inventory.verified_checkout_details_view.item_id, inventory.verified_checkout_details_view.store_id, inventory.verified_checkout_details_view.base_unit_id;

    UPDATE temp_closing_stock SET 
        item_code = inventory.items.item_code,
        item_name = inventory.items.item_name,
        maintain_inventory = inventory.items.maintain_inventory
    FROM inventory.items
    WHERE temp_closing_stock.item_id = inventory.items.item_id;

    DELETE FROM temp_closing_stock WHERE NOT temp_closing_stock.maintain_inventory;

    UPDATE temp_closing_stock SET 
        unit_name = inventory.units.unit_name
    FROM inventory.units
    WHERE temp_closing_stock.unit_id = inventory.units.unit_id;

    RETURN QUERY
    SELECT 
        temp_closing_stock.item_id, 
        temp_closing_stock.item_code, 
        temp_closing_stock.item_name, 
        temp_closing_stock.unit_id, 
        temp_closing_stock.unit_name, 
        temp_closing_stock.quantity
    FROM temp_closing_stock
    ORDER BY item_id;
END;
$$
LANGUAGE plpgsql;


--SELECT * FROM inventory.list_closing_stock(1);

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.post_adjustment.sql --<--<--
DROP FUNCTION IF EXISTS inventory.post_adjustment
(
    _office_id                              integer,
    _user_id                                integer,
    _login_id                               bigint,
    _store_id                               integer,
    _value_date                             date,
    _book_date                              date,
    _reference_number                       national character varying(24),
    _statement_reference                    text,
    _details                                inventory.adjustment_type[]
);


CREATE FUNCTION inventory.post_adjustment
(
    _office_id                              integer,
    _user_id                                integer,
    _login_id                               bigint,
    _store_id                               integer,
    _value_date                             date,
    _book_date                              date,
    _reference_number                       national character varying(24),
    _statement_reference                    text,
    _details                                inventory.adjustment_type[]
)
RETURNS bigint
AS
$$
    DECLARE _transaction_master_id          bigint;
    DECLARE _checkout_id                    bigint;
    DECLARE _book_name                      text='Inventory Adjustment';
    DECLARE _is_periodic                    boolean = inventory.is_periodic_inventory(_office_id);
    DECLARE _default_currency_code          national character varying(12);
BEGIN
    IF NOT finance.can_post_transaction(_login_id, _user_id, _office_id, _book_name, _value_date) THEN
        return 0;
    END IF;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_stock_details
    (
        tran_type                       national character varying(2),
        store_id                        integer,
        item_id                         integer,
        item_code                       national character varying(12),
        unit_id                         integer,
        base_unit_id                    integer,
        unit_name                       national character varying(50),
        quantity                        public.decimal_strict,
        base_quantity                   public.decimal_strict,                
        price                           money_strict,
        cost_of_goods_sold              money_strict2 DEFAULT(0),
        inventory_account_id            integer,
        cost_of_goods_sold_account_id   integer
    ) 
    ON COMMIT DROP; 

    DROP TABLE IF EXISTS temp_transaction_details;
    CREATE TEMPORARY TABLE temp_transaction_details
    (
        tran_type                   national character varying(2), 
        account_id                  integer, 
        statement_reference         text, 
        cash_repository_id          integer, 
        currency_code               national character varying(12), 
        amount_in_currency          money_strict, 
        local_currency_code         national character varying(12), 
        er                          decimal_strict, 
        amount_in_local_currency    money_strict
    ) ON COMMIT DROP;

    INSERT INTO temp_stock_details(tran_type, store_id, item_code, unit_name, quantity)
    SELECT tran_type, _store_id, item_code, unit_name, quantity FROM explode_array(_details);

    IF EXISTS
    (
        SELECT * FROM temp_stock_details
        WHERE tran_type = 'Dr'
    ) THEN
        RAISE EXCEPTION 'A stock adjustment entry can not contain debit item(s).'
        USING ERRCODE='P5201';
    END IF;

    IF EXISTS
    (
        SELECT 1 FROM temp_stock_details
        GROUP BY item_code
        HAVING COUNT(item_code) <> 1
    ) THEN
        RAISE EXCEPTION 'An item can appear only once in a store.'
        USING ERRCODE='P5202';
    END IF;

    UPDATE temp_stock_details 
    SET 
        item_id         = inventory.get_item_id_by_item_code(item_code),
        unit_id         = inventory.get_unit_id_by_unit_name(unit_name);

    IF EXISTS
    (
        SELECT * FROM temp_stock_details
        WHERE item_id IS NULL OR unit_id IS NULL OR store_id IS NULL
    ) THEN
        RAISE EXCEPTION 'Invalid data supplied.'
        USING ERRCODE='P3000';
    END IF;

    UPDATE temp_stock_details 
    SET
        tran_type                       = 'Cr',
        base_quantity                   = inventory.get_base_quantity_by_unit_id(unit_id, quantity),
        base_unit_id                    = inventory.get_root_unit_id(unit_id),
        price                           = inventory.get_item_cost_price(item_id, unit_id),
        inventory_account_id            = inventory.get_inventory_account_id(item_id),
        cost_of_goods_sold_account_id   = inventory.get_cost_of_goods_sold_account_id(item_id);


    IF EXISTS
    (
            SELECT 1
            FROM 
            inventory.stores
            WHERE inventory.stores.store_id
            IN
            (
                SELECT temp_stock_details.store_id
                FROM temp_stock_details
            )
            HAVING COUNT(DISTINCT inventory.stores.office_id) > 1

    ) THEN
        RAISE EXCEPTION E'Access is denied!\nA stock adjustment transaction cannot references multiple branches.'
        USING ERRCODE='P9012';
    END IF;

    IF EXISTS
    (
            SELECT 1
            FROM 
            temp_stock_details
            WHERE tran_type = 'Cr'
            AND quantity > inventory.count_item_in_stock(item_id, unit_id, store_id)
    ) THEN
        RAISE EXCEPTION 'Negative stock is not allowed.'
        USING ERRCODE='P5001';
    END IF;

    --No accounting treatment is needed for periodic accounting system.
    IF(_is_periodic = false) THEN
        _default_currency_code  := core.get_currency_code_by_office_id(_office_id);

        UPDATE temp_stock_details 
        SET 
            cost_of_goods_sold = inventory.get_cost_of_goods_sold(item_id, unit_id, store_id, quantity);
    
        INSERT INTO temp_transaction_details(tran_type, account_id, statement_reference, currency_code, amount_in_currency, er, local_currency_code, amount_in_local_currency)
        SELECT 'Dr', cost_of_goods_sold_account_id, _statement_reference, _default_currency_code, SUM(COALESCE(cost_of_goods_sold, 0)), 1, _default_currency_code, SUM(COALESCE(cost_of_goods_sold, 0))
        FROM temp_stock_details
        GROUP BY cost_of_goods_sold_account_id;

        INSERT INTO temp_transaction_details(tran_type, account_id, statement_reference, currency_code, amount_in_currency, er, local_currency_code, amount_in_local_currency)
        SELECT 'Cr', inventory_account_id, _statement_reference, _default_currency_code, SUM(COALESCE(cost_of_goods_sold, 0)), 1, _default_currency_code, SUM(COALESCE(cost_of_goods_sold, 0))
        FROM temp_stock_details
        GROUP BY inventory_account_id;
    END IF;
    
    _transaction_master_id  := nextval(pg_get_serial_sequence('finance.transaction_master', 'transaction_master_id'));

    INSERT INTO finance.transaction_master
    (
            transaction_master_id,
            transaction_counter,
            transaction_code,
            book,
            value_date,
            book_date,
            login_id,
            user_id,
            office_id,
            reference_number,
            statement_reference
    )
    SELECT
            _transaction_master_id, 
            finance.get_new_transaction_counter(_value_date), 
            finance.get_transaction_code(_value_date, _office_id, _user_id, _login_id),
            _book_name,
            _value_date,
            _book_date,
            _login_id,
            _user_id,
            _office_id,
            _reference_number,
            _statement_reference;

    INSERT INTO finance.transaction_details(office_id, value_date, book_date, transaction_master_id, tran_type, account_id, statement_reference, cash_repository_id, currency_code, amount_in_currency, local_currency_code, er, amount_in_local_currency)
    SELECT _office_id, _value_date, _book_date, _transaction_master_id, tran_type, account_id, statement_reference, cash_repository_id, currency_code, amount_in_currency, local_currency_code, er, amount_in_local_currency
    FROM temp_transaction_details
    ORDER BY tran_type DESC;

    INSERT INTO inventory.checkouts(checkout_id, transaction_master_id, value_date, book_date, transaction_book, posted_by, office_id)
    SELECT nextval(pg_get_serial_sequence('inventory.checkouts', 'checkout_id')), _transaction_master_id, _value_date, _book_date, _book_name, _user_id, _office_id;

    _checkout_id                                := currval(pg_get_serial_sequence('inventory.checkouts', 'checkout_id'));

    INSERT INTO inventory.checkout_details(checkout_id, value_date, book_date, transaction_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price)
    SELECT _checkout_id, _value_date, _book_date, tran_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price
    FROM temp_stock_details;

    PERFORM finance.auto_verify(_transaction_master_id, _office_id);
    
    RETURN _transaction_master_id;
END
$$
LANGUAGE plpgsql;


-- SELECT * FROM inventory.post_adjustment(1, 1, 1, 1, NOW()::date, NOW()::date, '22', 'Test', 
-- ARRAY[
-- ROW('Cr', 'RMBP', 'Piece', 1)::inventory.adjustment_type,
-- ROW('Cr', '11MBA', 'Piece', 1)::inventory.adjustment_type
-- ]
-- );



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.post_opening_inventory.sql --<--<--
DROP FUNCTION IF EXISTS inventory.post_opening_inventory
(
    _office_id                              integer,
    _user_id                                integer,
    _login_id                               bigint,
    _value_date                             date,
    _book_date                              date,
    _reference_number                       national character varying(24),
    _statement_reference                    text,
    _details                                inventory.opening_stock_type[]    
);

CREATE FUNCTION inventory.post_opening_inventory
(
    _office_id                              integer,
    _user_id                                integer,
    _login_id                               bigint,
    _value_date                             date,
    _book_date                              date,
    _reference_number                       national character varying(24),
    _statement_reference                    text,
    _details                                inventory.opening_stock_type[]    
)
RETURNS bigint
VOLATILE
AS
$$
    DECLARE _book_name                      text = 'Opening Inventory';
    DECLARE _transaction_master_id          bigint;
    DECLARE _checkout_id                bigint;
    DECLARE _tran_counter                   integer;
    DECLARE _transaction_code               text;
BEGIN
    IF NOT finance.can_post_transaction(_login_id, _user_id, _office_id, _book_name, _value_date) THEN
        return 0;
    END IF;

    DROP TABLE IF EXISTS temp_stock_details;
    
    CREATE TEMPORARY TABLE temp_stock_details
    (
        id                              SERIAL PRIMARY KEY,
        tran_type                       national character varying(2),
        store_id                        integer,
        item_id                         integer, 
        quantity                        integer_strict,
        unit_id                         integer,
        base_quantity                   decimal,
        base_unit_id                    integer,                
        price                           money_strict
    ) ON COMMIT DROP;

    INSERT INTO temp_stock_details(store_id, item_id, quantity, unit_id, price)
    SELECT store_id, item_id, quantity, unit_id, price
    FROM explode_array(_details);

    UPDATE temp_stock_details 
    SET
        tran_type                       = 'Dr',
        base_quantity                   = inventory.get_base_quantity_by_unit_id(unit_id, quantity),
        base_unit_id                    = inventory.get_root_unit_id(unit_id);

    IF EXISTS
    (
        SELECT * FROM temp_stock_details
        WHERE store_id IS NULL
        OR item_id IS NULL
        OR unit_id IS NULL
    ) THEN
        RAISE EXCEPTION 'Access is denied. Invalid values supplied.'
        USING ERRCODE='P9011';
    END IF;

    IF EXISTS
    (
            SELECT 1 FROM temp_stock_details AS details
            WHERE inventory.is_valid_unit_id(details.unit_id, details.item_id) = false
            LIMIT 1
    ) THEN
        RAISE EXCEPTION 'Item/unit mismatch.'
        USING ERRCODE='P3201';
    END IF;

    
    _transaction_master_id  := nextval(pg_get_serial_sequence('finance.transaction_master', 'transaction_master_id'));
    _checkout_id            := nextval(pg_get_serial_sequence('inventory.checkouts', 'checkout_id'));
    _tran_counter           := finance.get_new_transaction_counter(_value_date);
    _transaction_code       := finance.get_transaction_code(_value_date, _office_id, _user_id, _login_id);

    INSERT INTO finance.transaction_master(transaction_master_id, transaction_counter, transaction_code, book, value_date, book_date, user_id, login_id, office_id, reference_number, statement_reference) 
    SELECT _transaction_master_id, _tran_counter, _transaction_code, _book_name, _value_date, _book_date, _user_id, _login_id, _office_id, _reference_number, _statement_reference;

    INSERT INTO inventory.checkouts(transaction_book, value_date, book_date, checkout_id, transaction_master_id, posted_by, office_id)
    SELECT _book_name, _value_date, _book_date, _checkout_id, _transaction_master_id, _user_id, _office_id;

    INSERT INTO inventory.checkout_details(value_date, book_date, checkout_id, transaction_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price)
    SELECT _value_date, _book_date, _checkout_id, tran_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price
    FROM temp_stock_details;
    
    PERFORM finance.auto_verify(_transaction_master_id, _office_id);    
    RETURN _transaction_master_id;
END;
$$
LANGUAGE plpgsql;

-- 
-- SELECT * FROM inventory.post_opening_inventory
-- (
--     2,
--     2,
--     5,
--     '1-1-2020',
--     '1-1-2020',
--     '3424',
--     'ASDF',
--     ARRAY[
--          ROW(1, 1, 1, 1,180000)::inventory.opening_stock_type,
--          ROW(1, 2, 1, 1,130000)::inventory.opening_stock_type,
--          ROW(1, 3, 1, 1,110000)::inventory.opening_stock_type]);
-- 


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/02.functions-and-logic/inventory.post_transfer.sql --<--<--
DROP FUNCTION IF EXISTS inventory.post_transfer
(
    _office_id                              integer,
    _user_id                                integer,
    _login_id                               bigint,
    _value_date                             date,
    _book_date                              date,
    _reference_number                       national character varying(24),
    _statement_reference                    text,
    _details                                inventory.transfer_type[]
);


CREATE FUNCTION inventory.post_transfer
(
    _office_id                              integer,
    _user_id                                integer,
    _login_id                               bigint,
    _value_date                             date,
    _book_date                              date,
    _reference_number                       national character varying(24),
    _statement_reference                    text,
    _details                                inventory.transfer_type[]
)
RETURNS bigint
AS
$$
    DECLARE _transaction_master_id          bigint;
    DECLARE _checkout_id                    bigint;
    DECLARE _book_name                      text='Inventory Transfer';
BEGIN
    IF NOT finance.can_post_transaction(_login_id, _user_id, _office_id, _book_name, _value_date) THEN
        RETURN 0;
    END IF;

    CREATE TEMPORARY TABLE IF NOT EXISTS temp_stock_details
    (
        tran_type       national character varying(2),
        store_id        integer,
        store_name      national character varying(50),
        item_id         integer,
        item_code       national character varying(12),
        unit_id         integer,
        base_unit_id    integer,
        unit_name       national character varying(50),
        quantity        public.decimal_strict,
        base_quantity   public.decimal_strict,                
        price           money_strict                             
    ) 
    ON COMMIT DROP; 

    INSERT INTO temp_stock_details(tran_type, store_name, item_code, unit_name, quantity)
    SELECT tran_type, store_name, item_code, unit_name, quantity FROM explode_array(_details);

    IF EXISTS
    (
        SELECT 1 FROM temp_stock_details
        GROUP BY item_code, store_name
        HAVING COUNT(item_code) <> 1
    ) THEN
        RAISE EXCEPTION 'An item can appear only once in a store.'
        USING ERRCODE='P5202';
    END IF;

    UPDATE temp_stock_details SET 
    item_id         = inventory.get_item_id_by_item_code(item_code),
    unit_id         = inventory.get_unit_id_by_unit_name(unit_name),
    store_id        = inventory.get_store_id_by_store_name(store_name);

    IF EXISTS
    (
        SELECT * FROM temp_stock_details
        WHERE item_id IS NULL OR unit_id IS NULL OR store_id IS NULL
    ) THEN
        RAISE EXCEPTION 'Invalid data supplied.'
        USING ERRCODE='P3000';
    END IF;

    UPDATE temp_stock_details 
    SET
        base_unit_id    = inventory.get_root_unit_id(unit_id),
        base_quantity   = inventory.get_base_quantity_by_unit_id(unit_id, quantity),
        price           = inventory.get_item_cost_price(item_id, unit_id);

    IF EXISTS
    (
        SELECT item_code FROM temp_stock_details
        GROUP BY item_code
        HAVING SUM(CASE WHEN tran_type='Dr' THEN base_quantity ELSE base_quantity *-1 END) <> 0
    ) THEN
        RAISE EXCEPTION 'Referencing sides are not equal.'
        USING ERRCODE='P5000';        
    END IF;


    IF EXISTS
    (
            SELECT 1
            FROM 
            inventory.stores
            WHERE inventory.stores.store_id
            IN
            (
                SELECT temp_stock_details.store_id
                FROM temp_stock_details
            )
            HAVING COUNT(DISTINCT inventory.stores.office_id) > 1

    ) THEN
        RAISE EXCEPTION E'Access is denied!\nA stock journal transaction cannot references multiple branches.'
        USING ERRCODE='P9013';
    END IF;

    IF EXISTS
    (
            SELECT 1
            FROM 
            temp_stock_details
            WHERE tran_type = 'Cr'
            AND quantity > inventory.count_item_in_stock(item_id, unit_id, store_id)
    ) THEN
        RAISE EXCEPTION 'Negative stock is not allowed.'
        USING ERRCODE='P5001';
    END IF;

    INSERT INTO finance.transaction_master(transaction_master_id, transaction_counter, transaction_code, book, value_date, book_date, login_id, user_id, office_id, reference_number, statement_reference)
    SELECT
            nextval(pg_get_serial_sequence('finance.transaction_master', 'transaction_master_id')), 
            finance.get_new_transaction_counter(_value_date), 
            finance.get_transaction_code(_value_date, _office_id, _user_id, _login_id),
            _book_name,
            _value_date,
            _book_date,
            _login_id,
            _user_id,
            _office_id,
            _reference_number,
            _statement_reference;


    _transaction_master_id  := currval(pg_get_serial_sequence('finance.transaction_master', 'transaction_master_id'));


    INSERT INTO inventory.checkouts(checkout_id, transaction_master_id, transaction_book, value_date, book_date, posted_by, office_id)
    SELECT nextval(pg_get_serial_sequence('inventory.checkouts', 'checkout_id')), _transaction_master_id, _book_name, _value_date, _book_date, _user_id, _office_id;

    _checkout_id  := currval(pg_get_serial_sequence('inventory.checkouts', 'checkout_id'));

    INSERT INTO inventory.checkout_details(checkout_id, value_date, book_date, transaction_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price)
    SELECT _checkout_id, _value_date, _book_date, tran_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price
    FROM temp_stock_details;
    
    
    PERFORM finance.auto_verify(_transaction_master_id, _office_id);
    RETURN _transaction_master_id;
END
$$
LANGUAGE plpgsql;


-- SELECT * FROM inventory.post_transfer(1, 1, 1, '1-1-2020', '1-1-2020', '22', 'Test', 
-- ARRAY[
-- ROW('Cr', 'Store 1', 'RMBP', 'Dozen', 2)::inventory.transfer_type,
-- ROW('Dr', 'Godown 1', 'RMBP', 'Piece', 24)::inventory.transfer_type
-- ]
-- );




-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/03.menus/menus.sql --<--<--
DELETE FROM auth.menu_access_policy
WHERE menu_id IN
(
    SELECT menu_id FROM core.menus
    WHERE app_name = 'Inventory'
);

DELETE FROM auth.group_menu_access_policy
WHERE menu_id IN
(
    SELECT menu_id FROM core.menus
    WHERE app_name = 'Inventory'
);

DELETE FROM core.menus
WHERE app_name = 'Inventory';


SELECT * FROM core.create_app('Inventory', 'Inventory', '1.0', 'MixERP Inc.', 'December 1, 2015', 'cart teal', '/dashboard/inventory/tasks/inventory-transfers', NULL::text[]);

SELECT * FROM core.create_menu('Inventory', 'Tasks', '', 'lightning', '');
SELECT * FROM core.create_menu('Inventory', 'Inventory Transfers', '/dashboard/inventory/tasks/inventory-transfers', 'exchange', 'Tasks');
SELECT * FROM core.create_menu('Inventory', 'Inventory Adjustments', '/dashboard/inventory/tasks/inventory-adjustments', 'grid layout', 'Tasks');
SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Verification', '/dashboard/inventory/tasks/inventory-transfers/verification', 'checkmark box', 'Tasks');
SELECT * FROM core.create_menu('Inventory', 'Inventory Adjustment Verification', '/dashboard/inventory/tasks/inventory-adjustments/verification', 'checkmark', 'Tasks');
-- SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Request', '/dashboard/inventory/tasks/inventory-transfer/request', 'food', 'Tasks');
-- SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Authorization', '/dashboard/inventory/tasks/inventory-transfer/authorization', 'keyboard', 'Tasks');
-- SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Delivery', '/dashboard/inventory/tasks/inventory-transfer/delivery', 'users', 'Tasks');
-- SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Acknowledgement', '/dashboard/inventory/tasks/inventory-transfer/acknowledgement', 'users', 'Tasks');
-- SELECT * FROM core.create_menu('Inventory', 'Inventory Transfer Acknowledgement', '/dashboard/inventory/tasks/inventory-transfer/acknowledgement', 'users', 'Tasks');

SELECT * FROM core.create_menu('Inventory', 'Setup', 'square outline', 'configure', '');
SELECT * FROM core.create_menu('Inventory', 'Inventory Items', '/dashboard/inventory/setup/inventory-items', 'content', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Item Groups', '/dashboard/inventory/setup/item-groups', 'cubes', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Item Types', '/dashboard/inventory/setup/item-types', 'ellipsis vertical', 'Setup');
--SELECT * FROM core.create_menu('Inventory', 'Cost Prices', '/dashboard/inventory/setup/cost-prices', 'money', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Store Types', '/dashboard/inventory/setup/store-types', 'block layout', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Stores', '/dashboard/inventory/setup/stores', 'cube', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Counters', '/dashboard/inventory/setup/counters', 'square outline', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Customer Types', '/dashboard/inventory/setup/customer-types', 'users', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Supplier Types', '/dashboard/inventory/setup/supplier-types', 'spy', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Customers', '/dashboard/inventory/setup/customers', 'user', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Suppliers', '/dashboard/inventory/setup/suppliers', 'male', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Brands', '/dashboard/inventory/setup/brands', 'bold', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Units of Measure', '/dashboard/inventory/setup/units-of-measure', 'underline', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Compound Units of Measure', '/dashboard/inventory/setup/compound-units-of-measure', 'move', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Shippers', '/dashboard/inventory/setup/shippers', 'ship', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Attributes', '/dashboard/inventory/setup/attributes', 'crosshairs', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Variants', '/dashboard/inventory/setup/variants', 'align center', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Item Variants', '/dashboard/inventory/setup/item-variants', 'unordered list', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Opening Inventory', '/dashboard/inventory/setup/opening-inventory', 'toggle on', 'Setup');
SELECT * FROM core.create_menu('Inventory', 'Opening Inventory Verification', '/dashboard/inventory/setup/opening-inventory/verification', 'check circle outline', 'Setup');

SELECT * FROM core.create_menu('Inventory', 'Reports', '', 'block layout', '');
SELECT * FROM core.create_menu('Inventory', 'Inventory Account Statement', '/dashboard/reports/view/Areas/MixERP.Inventory/Reports/AccountStatement.xml', 'book', 'Reports');


SELECT * FROM auth.create_app_menu_policy
(
    'Admin', 
    core.get_office_id_by_office_name('Default'), 
    'Inventory',
    '{*}'::text[]
);



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/04.default-values/01.default-values.sql --<--<--
INSERT INTO inventory.inventory_setup(office_id, inventory_system, cogs_calculation_method, default_discount_account_id)
SELECT office_id, 'Perpetual', 'FIFO', finance.get_account_id_by_account_number('40270')
FROM core.offices;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/05.scrud-views/inventory.customer_scrud_view.sql --<--<--
DROP VIEW IF EXISTS inventory.customer_scrud_view;

CREATE VIEW inventory.customer_scrud_view
AS
SELECT
    inventory.customers.customer_id,
    inventory.customers.customer_code,
    inventory.customers.customer_name,
    inventory.customer_types.customer_type_code || ' (' || inventory.customer_types.customer_type_name || ')' AS customer_type,
    inventory.customers.currency_code,
    inventory.customers.company_name,
    inventory.customers.company_phone_numbers,
    inventory.customers.contact_first_name,
    inventory.customers.contact_middle_name,
    inventory.customers.contact_last_name,
    inventory.customers.contact_phone_numbers,
    inventory.customers.photo
FROM inventory.customers
INNER JOIN inventory.customer_types
ON inventory.customer_types.customer_type_id = inventory.customers.customer_type_id;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/05.scrud-views/inventory.item_scrud_view.sql --<--<--
DROP VIEW IF EXISTS inventory.item_scrud_view;

CREATE VIEW inventory.item_scrud_view
AS
SELECT
    inventory.items.item_id,
    inventory.items.item_code,
    inventory.items.item_name,
    inventory.items.barcode,
    inventory.items.item_group_id,
    inventory.item_groups.item_group_name,
    inventory.item_types.item_type_id,
    inventory.item_types.item_type_name,
    inventory.items.brand_id,
    inventory.brands.brand_name,
    inventory.items.preferred_supplier_id,
    inventory.items.unit_id,
    inventory.units.unit_code,
    inventory.units.unit_name,
    inventory.items.hot_item,
    inventory.items.cost_price,
    inventory.items.selling_price,
    inventory.items.maintain_inventory,
    inventory.items.allow_sales,
    inventory.items.allow_purchase,
    inventory.items.photo
FROM inventory.items
INNER JOIN inventory.item_groups
ON inventory.item_groups.item_group_id = inventory.items.item_group_id
INNER JOIN inventory.item_types
ON inventory.item_types.item_type_id = inventory.items.item_type_id
INNER JOIN inventory.brands
ON inventory.brands.brand_id = inventory.items.brand_id
INNER JOIN inventory.units
ON inventory.units.unit_id = inventory.items.unit_id
WHERE NOT inventory.items.deleted
AND inventory.items.allow_purchase
AND inventory.items.maintain_inventory;



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/05.views/inventory.checkout_detail_view.sql --<--<--
DROP VIEW IF EXISTS inventory.checkout_detail_view;

CREATE VIEW inventory.checkout_detail_view
AS
SELECT
	inventory.checkouts.transaction_master_id,
	inventory.checkouts.checkout_id,
	inventory.checkout_details.checkout_detail_id,
	inventory.checkout_details.transaction_type,
	inventory.checkout_details.store_id,
	inventory.stores.store_code,
	inventory.stores.store_name,
	inventory.checkout_details.item_id,
	inventory.items.item_code,
	inventory.items.item_name,
	inventory.checkout_details.quantity,
	inventory.checkout_details.unit_id,
	inventory.units.unit_code,
	inventory.units.unit_name,
	inventory.checkout_details.base_quantity,
	inventory.checkout_details.base_unit_id,
	base_unit.unit_code AS base_unit_code,
	base_unit.unit_name AS base_unit_name,
	inventory.checkout_details.price,
	inventory.checkout_details.discount,
	inventory.checkout_details.shipping_charge,
	(inventory.checkout_details.price * inventory.checkout_details.quantity) + inventory.checkout_details.shipping_charge - inventory.checkout_details.discount AS amount
FROM inventory.checkout_details
INNER JOIN inventory.checkouts
ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
INNER JOIN inventory.stores
ON inventory.stores.store_id = inventory.checkout_details.store_id
INNER JOIN inventory.items
ON inventory.items.item_id = inventory.checkout_details.item_id
INNER JOIN inventory.units
ON inventory.units.unit_id = inventory.checkout_details.unit_id
INNER JOIN inventory.units AS base_unit
ON base_unit.unit_id = inventory.checkout_details.base_unit_id;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/05.views/inventory.checkout_view.sql --<--<--
DROP VIEW IF EXISTS inventory.checkout_view CASCADE;

CREATE VIEW inventory.checkout_view
AS
SELECT
	finance.transaction_master.transaction_master_id,
	inventory.checkouts.checkout_id,
	inventory.checkout_details.checkout_detail_id,
	finance.transaction_master.book,
	finance.transaction_master.transaction_counter,
	finance.transaction_master.transaction_code,
	finance.transaction_master.value_date,
	finance.transaction_master.transaction_ts,
	finance.transaction_master.login_id,
	finance.transaction_master.user_id,
	finance.transaction_master.office_id,
	finance.transaction_master.cost_center_id,
	finance.transaction_master.reference_number,
	finance.transaction_master.statement_reference,
	finance.transaction_master.last_verified_on,
	finance.transaction_master.verified_by_user_id,
	finance.transaction_master.verification_status_id,
	finance.transaction_master.verification_reason,
	inventory.checkout_details.transaction_type,
	inventory.checkout_details.store_id,
	inventory.checkout_details.item_id,
	inventory.checkout_details.quantity,
	inventory.checkout_details.unit_id,
	inventory.checkout_details.base_quantity,
	inventory.checkout_details.base_unit_id,
	inventory.checkout_details.price,
	inventory.checkout_details.discount,
	inventory.checkout_details.shipping_charge,
	inventory.checkout_details.price * inventory.checkout_details.quantity + inventory.checkout_details.discount AS amount
FROM inventory.checkout_details
INNER JOIN inventory.checkouts
ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
INNER JOIN finance.transaction_master
ON finance.transaction_master.transaction_master_id = inventory.checkouts.transaction_master_id;




-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/05.views/inventory.item_view.sql --<--<--
DROP VIEW IF EXISTS inventory.item_view;

CREATE VIEW inventory.item_view
AS
SELECT
    inventory.items.item_id,
    inventory.items.item_code,
    inventory.items.item_name,
    inventory.items.barcode,
    inventory.items.item_group_id,
    inventory.item_groups.item_group_name,
    inventory.item_types.item_type_id,
    inventory.item_types.item_type_name,
    inventory.items.brand_id,
    inventory.brands.brand_name,
    inventory.items.preferred_supplier_id,
    inventory.items.unit_id,
    array_to_string(inventory.get_associated_unit_list(inventory.items.unit_id), ',') AS valid_units,
    inventory.units.unit_code,
    inventory.units.unit_name,
    inventory.items.hot_item,
    inventory.items.cost_price,
    inventory.items.cost_price_includes_tax,
    inventory.items.selling_price,
    inventory.items.selling_price_includes_tax,
    inventory.items.photo,
	inventory.items.maintain_inventory
FROM inventory.items
INNER JOIN inventory.item_groups
ON inventory.item_groups.item_group_id = inventory.items.item_group_id
INNER JOIN inventory.item_types
ON inventory.item_types.item_type_id = inventory.items.item_type_id
INNER JOIN inventory.brands
ON inventory.brands.brand_id = inventory.items.brand_id
INNER JOIN inventory.units
ON inventory.units.unit_id = inventory.items.unit_id
WHERE NOT inventory.items.deleted;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/05.views/inventory.verified_checkout_details_view.sql --<--<--
DROP VIEW IF EXISTS inventory.verified_checkout_details_view;

CREATE VIEW inventory.verified_checkout_details_view
AS
SELECT inventory.checkout_details.* 
FROM inventory.checkout_details
INNER JOIN inventory.checkouts
ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
INNER JOIN finance.transaction_master
ON finance.transaction_master.transaction_master_id = inventory.checkouts.transaction_master_id
AND finance.transaction_master.verification_status_id > 0;


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/05.views/inventory.verified_checkout_view.sql --<--<--
DROP MATERIALIZED VIEW IF EXISTS inventory.verified_checkout_view;

CREATE MATERIALIZED VIEW inventory.verified_checkout_view
AS
SELECT * FROM inventory.checkout_view
WHERE verification_status_id > 0;

ALTER MATERIALIZED VIEW inventory.verified_checkout_view
OWNER TO frapid_db_user;

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/PostgreSQL/2.x/2.0/src/99.ownership.sql --<--<--
DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT * FROM pg_tables 
    WHERE NOT schemaname = ANY(ARRAY['pg_catalog', 'information_schema'])
    AND tableowner <> 'frapid_db_user'
    LOOP
        EXECUTE 'ALTER TABLE '|| this.schemaname || '.' || this.tablename ||' OWNER TO frapid_db_user;';
    END LOOP;
END
$$
LANGUAGE plpgsql;

DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT oid::regclass::text as mat_view
    FROM   pg_class
    WHERE  relkind = 'm'
    LOOP
        EXECUTE 'ALTER TABLE '|| this.mat_view ||' OWNER TO frapid_db_user;';
    END LOOP;
END
$$
LANGUAGE plpgsql;

DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT 'ALTER '
        || CASE WHEN p.proisagg THEN 'AGGREGATE ' ELSE 'FUNCTION ' END
        || quote_ident(n.nspname) || '.' || quote_ident(p.proname) || '(' 
        || pg_catalog.pg_get_function_identity_arguments(p.oid) || ') OWNER TO frapid_db_user;' AS sql
    FROM   pg_catalog.pg_proc p
    JOIN   pg_catalog.pg_namespace n ON n.oid = p.pronamespace
    WHERE  NOT n.nspname = ANY(ARRAY['pg_catalog', 'information_schema'])
    LOOP        
        EXECUTE this.sql;
    END LOOP;
END
$$
LANGUAGE plpgsql;


DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT * FROM pg_views
    WHERE NOT schemaname = ANY(ARRAY['pg_catalog', 'information_schema'])
    AND viewowner <> 'frapid_db_user'
    LOOP
        EXECUTE 'ALTER VIEW '|| this.schemaname || '.' || this.viewname ||' OWNER TO frapid_db_user;';
    END LOOP;
END
$$
LANGUAGE plpgsql;


DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT 'ALTER SCHEMA ' || nspname || ' OWNER TO frapid_db_user;' AS sql FROM pg_namespace
    WHERE nspname NOT LIKE 'pg_%'
    AND nspname <> 'information_schema'
    LOOP
        EXECUTE this.sql;
    END LOOP;
END
$$
LANGUAGE plpgsql;



DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'frapid_db_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT      'ALTER TYPE ' || n.nspname || '.' || t.typname || ' OWNER TO frapid_db_user;' AS sql
    FROM        pg_type t 
    LEFT JOIN   pg_catalog.pg_namespace n ON n.oid = t.typnamespace 
    WHERE       (t.typrelid = 0 OR (SELECT c.relkind = 'c' FROM pg_catalog.pg_class c WHERE c.oid = t.typrelid)) 
    AND         NOT EXISTS(SELECT 1 FROM pg_catalog.pg_type el WHERE el.oid = t.typelem AND el.typarray = t.oid)
    AND         typtype NOT IN ('b')
    AND         n.nspname NOT IN ('pg_catalog', 'information_schema')
    LOOP
        EXECUTE this.sql;
    END LOOP;
END
$$
LANGUAGE plpgsql;


DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'report_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT * FROM pg_tables 
    WHERE NOT schemaname = ANY(ARRAY['pg_catalog', 'information_schema'])
    AND tableowner <> 'report_user'
    LOOP
        EXECUTE 'GRANT SELECT ON TABLE '|| this.schemaname || '.' || this.tablename ||' TO report_user;';
    END LOOP;
END
$$
LANGUAGE plpgsql;

DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'report_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT 'GRANT EXECUTE ON '
        || CASE WHEN p.proisagg THEN 'AGGREGATE ' ELSE 'FUNCTION ' END
        || quote_ident(n.nspname) || '.' || quote_ident(p.proname) || '(' 
        || pg_catalog.pg_get_function_identity_arguments(p.oid) || ') TO report_user;' AS sql
    FROM   pg_catalog.pg_proc p
    JOIN   pg_catalog.pg_namespace n ON n.oid = p.pronamespace
    WHERE  NOT n.nspname = ANY(ARRAY['pg_catalog', 'information_schema'])
    LOOP        
        EXECUTE this.sql;
    END LOOP;
END
$$
LANGUAGE plpgsql;


DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'report_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT * FROM pg_views
    WHERE NOT schemaname = ANY(ARRAY['pg_catalog', 'information_schema'])
    AND viewowner <> 'report_user'
    LOOP
        EXECUTE 'GRANT SELECT ON '|| this.schemaname || '.' || this.viewname ||' TO report_user;';
    END LOOP;
END
$$
LANGUAGE plpgsql;


DO
$$
    DECLARE this record;
BEGIN
    IF(CURRENT_USER = 'report_user') THEN
        RETURN;
    END IF;

    FOR this IN 
    SELECT 'GRANT USAGE ON SCHEMA ' || nspname || ' TO report_user;' AS sql FROM pg_namespace
    WHERE nspname NOT LIKE 'pg_%'
    AND nspname <> 'information_schema'
    LOOP
        EXECUTE this.sql;
    END LOOP;
END
$$
LANGUAGE plpgsql;


