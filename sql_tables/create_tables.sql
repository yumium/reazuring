-- Constraints

-- Indexes

-- Enums

CREATE TYPE code_types as ENUM('verify_account','reset_password');
CREATE TYPE sponsor_types as ENUM('silent','active');

-- Tables

    -- Users

    create table users(
        user_id serial primary key,
        username varchar(30) not null,
        email varchar(200) not null,
        phone_no varchar(20),
        hashed_password varchar(100) not null,
        registration_ts timestamp not null,
        last_login_ts timestamp,
        school_id varchar(10),
        guardian_id varchar(10),
        corporation_id varchar(10),
        sponsor_id varchar(10),
        admin boolean,
        enabled boolean
    );

    -- Verification Codes

    create table verification_codes(
            code_id serial primary key,
            user_id int,
            type code_types,
            code varchar(10),
            expiry_ts timestamp
        );

    -- Guardians

    create table guardians(
        guardian_id varchar(10) primary key,
        school_id varchar(10),
        forename varchar(50),
        surname varchar(50),
        address varchar(300),
        postcode varchar(10),
        phone_no varchar(20)
    );

    -- Schools

    create table schools(
        school_id varchar(10) primary key,
        name varchar(50),
        address varchar(300),
        postcode varchar(10)
    );

    -- Corporations
    create table corporations(
        corporation_id varchar(10) primary key,
        name varchar(50),
        address varchar(300),
        postcode varchar(10),
        vat_number varchar(20)
    );

    -- Sponsors
        create table sponsors(
            sponsor_id varchar(10) primary key,
            type sponsor_types,
            forename varchar(50),
            surname varchar(50),
            payment_info_id varchar(10),
            address varchar(300),
            postcode varchar(10),
            child_id varchar(10)
    );

    -- Children
        create table children(
            child_id varchar(10) primary key,
            school_id varchar(10),
            sponsor_id varchar(10),
            forename varchar(50),
            surname varchar(50),
            dob varchar(10),
            guardian_id varchar(10),
            ethnicity varchar(50),
            vulnerable boolean
        );
    -- Letters
        create table letters(
            letter_id serial primary key,
            child_id varchar(10),
            sponsor_id varchar(10),
            initiator varchar(10),
            created_ts timestamp,
            review_complete boolean,
            review_ts timestamp,
            content text,
            attachments varchar[]
        );