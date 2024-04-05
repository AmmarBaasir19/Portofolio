TASK 1
CREATE DATABASE Mini_project1;

--Make Table---
CREATE TABLE IF NOT EXISTS public.customers_dataset
(
    customer_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    customer_unique_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    customer_zip_code_prefix numeric(6, 0) NOT NULL,
    customer_city character varying(50) COLLATE pg_catalog."default" NOT NULL,
    customer_state character varying(5) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT customers_dataset_pkey PRIMARY KEY (customer_id),
    CONSTRAINT customers_dataset_customer_id_customer_id1_key UNIQUE (customer_id)
        INCLUDE(customer_id)
);

COMMENT ON TABLE public.customers_dataset
    IS 'tabel yang menyimpan data dari customers : 
- customer_id : id dari customers,
- customer_unique_id : unique id dari customers,
- customer_zip_code_prefix : kode pos tempat tinggal dari customers,
- customer_city : nama kota dari customers,
- customer_state  nama state (kode negara bagian) tempat tinggal dari customers: ';

CREATE TABLE IF NOT EXISTS public.geolocations_dataset
(
    geolocation_zip_code_prefix numeric(6, 0) NOT NULL,
    geolocation_lat numeric(20, 0) NOT NULL,
    "geolocation_Ing" numeric(20, 0) NOT NULL,
    geolocation_city character varying(50) COLLATE pg_catalog."default" NOT NULL,
    geolocation_state character varying(6) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE public.geolocations_dataset
    IS 'tabel yang menyimpan data geolocations : 
- geolocation_zip_code_prefix : menunjukkan kode pos dari lokasi geografis,
- geolocation_lat : menunjukkan posisi lintang(latitude) dari lokasi geografis,
- geolocation_lng : menunjukkan posisi bujur(longitude) dari lokasi geografis,
- geolocation_city : menunjukkan nama kota dari lokasi geografis,
- geolocation_state : menunjukkan nama (kode nama) dari state (negara bagian)';

CREATE TABLE IF NOT EXISTS public.order_items_dataset
(
    order_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    order_item_id numeric(3, 0) NOT NULL,
    product_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    seller_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    shipping_limit_date timestamp with time zone NOT NULL,
    price double precision NOT NULL,
    freight_value double precision NOT NULL
);

COMMENT ON TABLE public.order_items_dataset
    IS 'tabel ini menyimpan data order atau transaksi dari customers :
- order_id : menunjukkan id order,
- order_item_id : menunjukkan banyaknya item yang di order,
- product_id : menunjukkan id product,
- seller_id : menunjukkan id sellers,
- shipping_limit_date : menunjukkan batas waktu pengiriman product (pesanan) dimana batasan waktu yang diberikan kepada sellers yang harus menyerahkan product pada ekspedisi pengiriman,
- price : menunjukkan harga dari product,
- freight_value : menunjukkan biaya pengiriman (ongkos kirim)';

CREATE TABLE IF NOT EXISTS public.orders_dataset
(
    order_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    customer_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    order_status character varying(12) COLLATE pg_catalog."default" NOT NULL,
    order_purchase_timestamp timestamp with time zone NOT NULL,
    order_approved_at timestamp with time zone,
    order_delivered_carrier_date timestamp with time zone,
    order_delivered_customer_date timestamp with time zone,
    order_estimated_delivery_date timestamp with time zone,
    CONSTRAINT orders_dataset_pkey PRIMARY KEY (order_id),
    CONSTRAINT orders_dataset_order_id_order_id1_key UNIQUE (order_id)
        INCLUDE(order_id)
);

COMMENT ON TABLE public.orders_dataset
    IS 'tabel ini berisikan data order dari customers : 
order_id : menunjukkan id order,
customer_id : menunjukkan id customer,
order_status : menunjukkan status dari order,
order_purchase_timestamp : menunjukkan waktu pertama kali customer melakukan order,
order_approved_at : menunjukkan waktu pesanan dari customer disetujui oleh sistem,
order_delivered_carrier_date : menunjukkan waktu dimana pesanan customer diterima ekspedisi pengiriman.
order_delivered_customer_date : menunjukkan waktu dimana pesanan telah diterima customer (pihak ekspedisi pengiriman menyerahkan kepada customer).
order_estimated_delivery_date : menunjukkan waktu dimana estimasi awal pesanan yang diterima customer (lama waktu dari customer memesan hingga customer menerima pesanannya)';

CREATE TABLE IF NOT EXISTS public.payments_dataset
(
    order_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    payment_sequential numeric(3, 0) NOT NULL,
    payment_type character varying(15) COLLATE pg_catalog."default" NOT NULL,
    payment_installments numeric(2, 0) NOT NULL,
    payment_value numeric(5, 0) NOT NULL
);

COMMENT ON TABLE public.payments_dataset
    IS 'tabel ini berisikan data payments dari customers : 
- order_id : menunjukkan id order,
- payment_sequential : menunjukkan jumlah atau banyaknya pembayaran yang dilakukan dalam satu pesanan,
- payment_type : menunjukkan jenis tipe pembayaran yang digunakan, 
- payment_installments : menunjukkan banyaknya (berapa kali) pembayaran yang dilakukan ini dapat berisi banyaknya jumlah angsuran,
- payment_value : menunjukkan jumlah besaran pembayaran yang dilakukan';

CREATE TABLE IF NOT EXISTS public.products_dataset
(
    product_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    product_category_name character varying(50) COLLATE pg_catalog."default",
    product_name_lenght double precision,
    product_description_lenght double precision,
    product_photos_qty double precision,
    product_weight_g double precision,
    product_length_cm double precision,
    product_height_cm double precision,
    product_width_cm double precision,
    CONSTRAINT products_dataset_pkey PRIMARY KEY (product_id),
    CONSTRAINT products_dataset_product_id_product_id1_key UNIQUE (product_id)
        INCLUDE(product_id)
);

COMMENT ON TABLE public.products_dataset
    IS 'tabel ini menyimpan data dari jenis - jenis product :
- product_id : menunjukkan id product
- product_category_name : menunjukkan nama kategori dari product,
- product_name_lenght : menunjukkan panjang nama product,
- product_description_lenght : menunjukkan panjang deskripsi dari product,
- product_photos_qty : menunjukkan gambar quantity dati product
- product_weight_g : menunjukkan ukuran berat product berdasarkan gram
- product_length_cm : menunjukkan ukuran panjang product berdasarkan cm
- product_height_cm : menunjukkan ukuran tinggi product berdasarkan cm
- product_width_cm : menunjukkan ukuran lebar product berdasarkan cm';

CREATE TABLE IF NOT EXISTS public.reviews_dataset
(
    review_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    order_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    review_score numeric(1, 0) NOT NULL,
    review_comment_title character varying(50) COLLATE pg_catalog."default",
    review_comment_message character varying(350) COLLATE pg_catalog."default",
    review_creation_date timestamp with time zone NOT NULL,
    review_answer_timestamp timestamp with time zone NOT NULL
);

COMMENT ON TABLE public.reviews_dataset
    IS 'tabel ini menyimpan data reviews dari customers :
- review_id : menunjukkan id review,
- order_id : menunjukkan id order,
- review_score : menunjukkan nilai review dari customer, 
- review_comment_title : menunjukkan judul review dari customer
- review_comment_message : menunjukkan isi review dari customer
- review_creation_date : menunjukkan waktu riview yang dibuat atau diberikan oleh customer
- review_answer_timestamp : menunjukkan waktu dari jawaban (feedback) yang diberikan atas review dari customer';

CREATE TABLE IF NOT EXISTS public.sellers_dataset
(
    seller_id character varying(36) COLLATE pg_catalog."default" NOT NULL,
    seller_zip_code_prefix numeric(6, 0) NOT NULL,
    seller_city character varying(50) COLLATE pg_catalog."default" NOT NULL,
    seller_state character varying(5) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT sellers_dataset_pkey PRIMARY KEY (seller_id),
    CONSTRAINT sellers_dataset_seller_id_seller_id1_key UNIQUE (seller_id)
        INCLUDE(seller_id)
);

COMMENT ON TABLE public.sellers_dataset
    IS 'tabel yang menyimpan data dari sellers : 
- seller_id : menunjukkan id unique dari sellers,
- seller_zip_code_prefix : menunjukkan kode pos tempat tinggal sellers,
- seller_city : menunjukkan nama kota tempat tinggal sellers,
- seller_state : menunjukkan nama state (kode negara bagian) tempat tinggal sellers';

ALTER TABLE IF EXISTS public.order_items_dataset
    ADD CONSTRAINT order_items_dataset_order_id_fkey FOREIGN KEY (order_id)
    REFERENCES public.orders_dataset (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.order_items_dataset
    ADD CONSTRAINT order_items_dataset_product_id_fkey FOREIGN KEY (product_id)
    REFERENCES public.products_dataset (product_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.order_items_dataset
    ADD CONSTRAINT order_items_dataset_seller_id_fkey FOREIGN KEY (seller_id)
    REFERENCES public.sellers_dataset (seller_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.orders_dataset
    ADD CONSTRAINT orders_dataset_customer_id_fkey FOREIGN KEY (customer_id)
    REFERENCES public.customers_dataset (customer_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.payments_dataset
    ADD CONSTRAINT payments_dataset_order_id_fkey FOREIGN KEY (order_id)
    REFERENCES public.orders_dataset (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
END;
Pada database Mini_project1 ini terdiri atas 8 tabel yang telah didefinisikan pada query diatas. 8 tabel yang dibuat menyimpan informasi yang berbeda – beda, yakni sebagai berikut : 
-   customers_dataset : 
tabel ini menyimpan informasi data – data dari customers yang melakukan pembelian pada ecommerce. Data – data customers ini berupa Alamat, customers id, city, dll.

-   geolocations_dataset : 
tabel yang menyimpan informasi data geolocation dari customers maupun sellers. Data geolocation berupa garis lintang (latitude, longitude).

-   order_items_dataset : 
tabel yang menyimpan informasi mengenai data product yang dibeli oleh customers. Data yang tersimpan pada tabel ini berupa data harga product, ongkos kirim, dll.

-   orders_dataset : 
tabel yang menyimpan informasi mengenai informasi pesanan dari customers. Data yang tersimpan pada tabel ini berupa data waktu customers orders, status orders, hingga waktu pesanan customers tiba (diterima).

-   payments_dataset : 
tabel ini menyimpan informasi mengenai tipe – tipe pembayaran yang digunakan oleh customers saat melakukan pembelanjaan.

-   products_dataset : 
tabel ini menyimpan informasi mengenai detail product yang dibeli oleh customers. Ini berupa nama product, category product, dll.

-   reviews_dataset : 
tabel ini menyimpan informasi mengenai review yang diberikan oleh customer setelah mereka membeli product dari ecommerce.

-   sellers_dataset : 
tabel ini menyimpan detail informasi mengenai seller yang menjual productnya pada ecommerce. 





TASK 2
---Tabel Utama---
WITH master_table AS(
	SELECT
		database_customers.customer_id,
		database_customers.customer_unique_id,
		database_order.order_id,
		database_order.order_status,
		database_order.order_purchase_timestamp AS tanggal_order,
		database_order_item.order_item_id AS jumlah_order,
		database_order_item.price,
		database_order_item.freight_value,
		database_product.product_id,
		database_product.product_category_name
	FROM
		public.customers_dataset AS database_customers
	JOIN
		public.orders_dataset AS database_order
	ON
		database_order.customer_id = database_customers.customer_id
	JOIN
		public.order_items_dataset AS database_order_item
	ON 
		database_order_item.order_id = database_order.order_id
	JOIN
		public.products_dataset AS database_product
	ON
		database_product.product_id = database_order_item.product_id
),

--Monthly Active User--
monthly_active_user AS(
	SELECT
		EXTRACT(YEAR FROM tanggal_order) AS tahun,
		COUNT(DISTINCT customer_id) AS monthly_active_user
	FROM
		master_table
	GROUP BY
		1
),

--New Customers By Years--
new_customers AS(
	SELECT
		EXTRACT(YEAR FROM tanggal_order) AS tahun,
		COUNT(DISTINCT(customer_unique_id)) AS new_customers
	FROM
		master_table
	GROUP BY
		1
),

repeat_order AS(
	SELECT
		EXTRACT(YEAR FROM tanggal_order) AS tahun,
		COUNT(DISTINCT customer_id) - COUNT(DISTINCT customer_unique_id) AS total_repeat_order
	FROM
		master_table
	GROUP BY
		1
),

frequency_order AS(
	SELECT
		EXTRACT(YEAR FROM tanggal_order) AS tahun,
		ROUND(AVG(jumlah_order), 3) AS average_freq_order
	FROM
		master_table
	GROUP BY
		1
)

SELECT
	mau.tahun,
	mau.monthly_active_user,
	nc.new_customers,
	ro.total_repeat_order,
	fo.average_freq_order
FROM
	monthly_active_user mau
JOIN
	new_customers nc ON mau.tahun = nc.tahun
JOIN
	repeat_order ro ON nc.tahun = ro.tahun
JOIN
	frequency_order fo ON ro.tahun = fo.tahun






TASK 3
--Table Total Revenue Perusahaan--
revenue_table AS(
	SELECT
		EXTRACT(YEAR FROM tanggal_order) AS tahun,
		ROUND(SUM(CAST((price + freight_value) AS numeric)), 2) AS total_revenue_year
	FROM
		master_table
	WHERE
		order_status = 'delivered'
	GROUP BY
		1
),

--Table Total Canceled Order--
canceled_table AS(
	SELECT
		EXTRACT(YEAR FROM tanggal_order) AS tahun,
		SUM(jumlah_order) AS total_canceled_year
	FROM
		master_table
	WHERE
		order_status = 'canceled'
	GROUP BY
		1
	ORDER BY
		1 DESC
),

--Table Product Category by Top Revenue--
product_top_revenue AS(
	SELECT
		EXTRACT(YEAR FROM tanggal_order) AS tahun,
		product_category_name AS product_category_revenue,
		ROUND(SUM(CAST((price + freight_value) AS numeric)), 2) AS total_revenue_product,
		RANK() OVER(PARTITION BY 
					EXTRACT(YEAR FROM tanggal_order) 
					ORDER BY ROUND(SUM(CAST((price + freight_value) AS numeric)), 2) DESC) AS top_rank
	FROM
		master_table
	WHERE
		order_status = 'delivered' AND product_category_name IS NOT NULL
	GROUP BY
		1, 2
	ORDER BY
		1, 4 ASC
),

--Table Product Category By Top Canceled-- 
product_top_canceled AS(
	SELECT
		EXTRACT(YEAR FROM tanggal_order) AS tahun,
		product_category_name AS product_category_canceled,
		SUM(jumlah_order) AS total_canceled_product,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM tanggal_order)
					ORDER BY SUM(jumlah_order) DESC) AS top_rank
	FROM
		master_table
	WHERE
		order_status = 'canceled'
	GROUP BY
		1, 2
	ORDER BY
		1, 4
)

SELECT
	rt.tahun,
	ptr.product_category_revenue,
	ptr.total_revenue_product,
	rt.total_revenue_year,
	ptc.product_category_canceled,
	ptc.total_canceled_product,
	ct.total_canceled_year
FROM
	revenue_table rt
JOIN
	canceled_table ct ON rt.tahun = ct.tahun
JOIN
	product_top_revenue ptr ON ct.tahun = ptr.tahun
JOIN
	product_top_canceled ptc ON ptr.tahun = ptc.tahun
WHERE
	ptr.top_rank = 1 AND ptc.top_rank = 1
ORDER BY
	1



TASK 4
WITH payments_fav AS(
	SELECT
		EXTRACT(YEAR FROM od.order_purchase_timestamp) AS tahun,
		pd.payment_type,
		COUNT(2) AS total_used
	FROM
		payments_dataset pd
	JOIN
		orders_dataset od ON pd.order_id = od.order_id
	GROUP BY
		1, 2
	ORDER BY
		1, 3 DESC
)

SELECT
	payment_type,
	SUM(CASE WHEN tahun = 2016 THEN total_used ELSE 0 END) AS tahun_2016,
	SUM(CASE WHEN tahun = 2017 THEN total_used ELSE 0 END) AS tahun_2017,
	SUM(CASE WHEN tahun = 2018 THEN total_used ELSE 0 END) AS tahun_2018
FROM
	payments_fav
GROUP BY
	1