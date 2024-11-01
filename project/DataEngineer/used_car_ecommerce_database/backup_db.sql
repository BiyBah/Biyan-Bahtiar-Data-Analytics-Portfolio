PGDMP                  	    |            used_car_ecommerce     16.4 (Ubuntu 16.4-1.pgdg22.04+2)     16.4 (Ubuntu 16.4-1.pgdg22.04+2) <    h           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            i           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            j           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            k           1262    16388    used_car_ecommerce    DATABASE     z   CREATE DATABASE used_car_ecommerce WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
 "   DROP DATABASE used_car_ecommerce;
                postgres    false            �            1255    16522    enforce_password_policy()    FUNCTION     �   CREATE FUNCTION public.enforce_password_policy() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM password_check(NEW.password);
    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.enforce_password_policy();
       public          postgres    false            �            1255    41097     haversine_distance(point, point)    FUNCTION       CREATE FUNCTION public.haversine_distance(point1 point, point2 point) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
DECLARE
	lon1 float := radians(point1[0]);
	lat1 float := radians(point1[1]);
	lon2 float := radians(point2[0]);
	lat2 float := radians(point2[1]);

	dlon float := lon2 - lon1;
	dlat float := lat2 - lat1;

	a float;
	c float;
	r float := 6371;
	jarak float;
BEGIN
	a := sin(dlat/2)^2 * cos(lat1) * cos(lat2) * sin(dlon/2)^2;
	c := 2 * asin(sqrt(a));
	jarak := r*c;
	RETURN jarak;
END;
$$;
 E   DROP FUNCTION public.haversine_distance(point1 point, point2 point);
       public          postgres    false            �            1255    16521 !   password_check(character varying)    FUNCTION       CREATE FUNCTION public.password_check(passwd character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF LENGTH(passwd) < 8 THEN
		RAISE EXCEPTION 'Password harus terdiri dari 8 karakter';
	END IF;

	IF passwd !~ '[0-9]' THEN
		RAISE EXCEPTION 'Password harus berisi minimal 1 angka';
	END IF;

	IF passwd !~ '[A-Z]' THEN
		RAISE EXCEPTION 'Password harus berisi minimal 1 huruf kapital';
	END IF;

	IF passwd !~ '[a-z]' THEN
		RAISE EXCEPTION 'Password harus berisi minimal 1 huruf kecil';
	END IF;

	RETURN TRUE;
END;
$$;
 ?   DROP FUNCTION public.password_check(passwd character varying);
       public          postgres    false            �            1259    40992    ads    TABLE     �   CREATE TABLE public.ads (
    ads_id integer NOT NULL,
    title character varying(100) NOT NULL,
    description character varying(100) NOT NULL,
    user_id integer NOT NULL,
    date_created date NOT NULL
);
    DROP TABLE public.ads;
       public         heap    postgres    false            �            1259    41029    bid    TABLE     �   CREATE TABLE public.bid (
    bid_id integer NOT NULL,
    bid_price integer NOT NULL,
    user_id integer NOT NULL,
    car_id integer NOT NULL,
    date_created date NOT NULL,
    CONSTRAINT bid_bid_price_check CHECK ((bid_price > 0))
);
    DROP TABLE public.bid;
       public         heap    postgres    false            �            1259    41019    body    TABLE     �   CREATE TABLE public.body (
    body_id integer NOT NULL,
    body character varying(50) NOT NULL,
    date_created date NOT NULL
);
    DROP TABLE public.body;
       public         heap    postgres    false            �            1259    41024    brand    TABLE     �   CREATE TABLE public.brand (
    brand_id integer NOT NULL,
    brand character varying(20) NOT NULL,
    date_created date NOT NULL
);
    DROP TABLE public.brand;
       public         heap    postgres    false            �            1259    40997    car    TABLE     F  CREATE TABLE public.car (
    car_id integer NOT NULL,
    permit_bid boolean DEFAULT false NOT NULL,
    color character varying(20),
    mileage character varying(20),
    mfg_year_id integer NOT NULL,
    model_id integer NOT NULL,
    ads_id integer NOT NULL,
    price integer NOT NULL,
    date_created date NOT NULL
);
    DROP TABLE public.car;
       public         heap    postgres    false            �            1259    40978    city    TABLE     �   CREATE TABLE public.city (
    city_id integer NOT NULL,
    city character varying(100) NOT NULL,
    province_id integer NOT NULL,
    coordinate point NOT NULL,
    date_created date NOT NULL
);
    DROP TABLE public.city;
       public         heap    postgres    false            �            1259    40985    country    TABLE     �   CREATE TABLE public.country (
    country_id integer NOT NULL,
    country character varying(100) NOT NULL,
    date_created date NOT NULL
);
    DROP TABLE public.country;
       public         heap    postgres    false            �            1259    41002    mfg_year    TABLE     �   CREATE TABLE public.mfg_year (
    mfg_year_id integer NOT NULL,
    mfg_year integer NOT NULL,
    date_created date NOT NULL
);
    DROP TABLE public.mfg_year;
       public         heap    postgres    false            �            1259    41007    model    TABLE     �   CREATE TABLE public.model (
    model_id integer NOT NULL,
    model_name character varying(100) NOT NULL,
    transmission_id integer NOT NULL,
    body_id integer NOT NULL,
    brand_id integer NOT NULL,
    date_created date NOT NULL
);
    DROP TABLE public.model;
       public         heap    postgres    false            �            1259    40971    province    TABLE     �   CREATE TABLE public.province (
    province_id integer NOT NULL,
    province character varying(100) NOT NULL,
    country_id integer NOT NULL,
    date_created date NOT NULL
);
    DROP TABLE public.province;
       public         heap    postgres    false            �            1259    41012    transmission    TABLE     �   CREATE TABLE public.transmission (
    transmission_id integer NOT NULL,
    transmission text NOT NULL,
    date_created date NOT NULL
);
     DROP TABLE public.transmission;
       public         heap    postgres    false            �            1259    40964    users    TABLE     v  CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(100) NOT NULL,
    password character varying(8) NOT NULL,
    phone_number character varying(20) NOT NULL,
    social_media_address character varying(100) NOT NULL,
    domicile_address character varying(100) NOT NULL,
    city_id integer NOT NULL,
    date_created date NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            ^          0    40992    ads 
   TABLE DATA           P   COPY public.ads (ads_id, title, description, user_id, date_created) FROM stdin;
    public          postgres    false    219   �K       e          0    41029    bid 
   TABLE DATA           O   COPY public.bid (bid_id, bid_price, user_id, car_id, date_created) FROM stdin;
    public          postgres    false    226   �S       c          0    41019    body 
   TABLE DATA           ;   COPY public.body (body_id, body, date_created) FROM stdin;
    public          postgres    false    224   �{       d          0    41024    brand 
   TABLE DATA           >   COPY public.brand (brand_id, brand, date_created) FROM stdin;
    public          postgres    false    225   h|       _          0    40997    car 
   TABLE DATA           u   COPY public.car (car_id, permit_bid, color, mileage, mfg_year_id, model_id, ads_id, price, date_created) FROM stdin;
    public          postgres    false    220   k}       \          0    40978    city 
   TABLE DATA           T   COPY public.city (city_id, city, province_id, coordinate, date_created) FROM stdin;
    public          postgres    false    217   ��       ]          0    40985    country 
   TABLE DATA           D   COPY public.country (country_id, country, date_created) FROM stdin;
    public          postgres    false    218   ?�       `          0    41002    mfg_year 
   TABLE DATA           G   COPY public.mfg_year (mfg_year_id, mfg_year, date_created) FROM stdin;
    public          postgres    false    221   w�       a          0    41007    model 
   TABLE DATA           g   COPY public.model (model_id, model_name, transmission_id, body_id, brand_id, date_created) FROM stdin;
    public          postgres    false    222   �       [          0    40971    province 
   TABLE DATA           S   COPY public.province (province_id, province, country_id, date_created) FROM stdin;
    public          postgres    false    216   ��       b          0    41012    transmission 
   TABLE DATA           S   COPY public.transmission (transmission_id, transmission, date_created) FROM stdin;
    public          postgres    false    223   *�       Z          0    40964    users 
   TABLE DATA           �   COPY public.users (user_id, user_name, password, phone_number, social_media_address, domicile_address, city_id, date_created) FROM stdin;
    public          postgres    false    215   u�       �           2606    40996    ads ads_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (ads_id);
 6   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_pkey;
       public            postgres    false    219            �           2606    41034    bid bid_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_pkey PRIMARY KEY (bid_id);
 6   ALTER TABLE ONLY public.bid DROP CONSTRAINT bid_pkey;
       public            postgres    false    226            �           2606    41023    body body_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.body
    ADD CONSTRAINT body_pkey PRIMARY KEY (body_id);
 8   ALTER TABLE ONLY public.body DROP CONSTRAINT body_pkey;
       public            postgres    false    224            �           2606    41028    brand brand_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (brand_id);
 :   ALTER TABLE ONLY public.brand DROP CONSTRAINT brand_pkey;
       public            postgres    false    225            �           2606    41001    car car_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.car
    ADD CONSTRAINT car_pkey PRIMARY KEY (car_id);
 6   ALTER TABLE ONLY public.car DROP CONSTRAINT car_pkey;
       public            postgres    false    220            �           2606    40984    city city_city_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_city_key UNIQUE (city);
 <   ALTER TABLE ONLY public.city DROP CONSTRAINT city_city_key;
       public            postgres    false    217            �           2606    40982    city city_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);
 8   ALTER TABLE ONLY public.city DROP CONSTRAINT city_pkey;
       public            postgres    false    217            �           2606    40991    country country_country_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_country_key UNIQUE (country);
 E   ALTER TABLE ONLY public.country DROP CONSTRAINT country_country_key;
       public            postgres    false    218            �           2606    40989    country country_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);
 >   ALTER TABLE ONLY public.country DROP CONSTRAINT country_pkey;
       public            postgres    false    218            �           2606    41006    mfg_year mfg_year_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.mfg_year
    ADD CONSTRAINT mfg_year_pkey PRIMARY KEY (mfg_year_id);
 @   ALTER TABLE ONLY public.mfg_year DROP CONSTRAINT mfg_year_pkey;
       public            postgres    false    221            �           2606    41011    model model_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.model
    ADD CONSTRAINT model_pkey PRIMARY KEY (model_id);
 :   ALTER TABLE ONLY public.model DROP CONSTRAINT model_pkey;
       public            postgres    false    222            �           2606    40975    province province_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (province_id);
 @   ALTER TABLE ONLY public.province DROP CONSTRAINT province_pkey;
       public            postgres    false    216            �           2606    40977    province province_province_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_province_key UNIQUE (province);
 H   ALTER TABLE ONLY public.province DROP CONSTRAINT province_province_key;
       public            postgres    false    216            �           2606    41018    transmission transmission_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.transmission
    ADD CONSTRAINT transmission_pkey PRIMARY KEY (transmission_id);
 H   ALTER TABLE ONLY public.transmission DROP CONSTRAINT transmission_pkey;
       public            postgres    false    223            �           2606    40968    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    215            �           2606    40970    users users_user_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_name_key UNIQUE (user_name);
 C   ALTER TABLE ONLY public.users DROP CONSTRAINT users_user_name_key;
       public            postgres    false    215            �           2620    41096    users check_password    TRIGGER     �   CREATE TRIGGER check_password BEFORE INSERT OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.enforce_password_policy();
 -   DROP TRIGGER check_password ON public.users;
       public          postgres    false    228    215            �           2606    41055 
   car fk_ads    FK CONSTRAINT     �   ALTER TABLE ONLY public.car
    ADD CONSTRAINT fk_ads FOREIGN KEY (ads_id) REFERENCES public.ads(ads_id) ON UPDATE CASCADE ON DELETE CASCADE;
 4   ALTER TABLE ONLY public.car DROP CONSTRAINT fk_ads;
       public          postgres    false    219    220    3247            �           2606    41076    model fk_body    FK CONSTRAINT     �   ALTER TABLE ONLY public.model
    ADD CONSTRAINT fk_body FOREIGN KEY (body_id) REFERENCES public.body(body_id) ON UPDATE CASCADE;
 7   ALTER TABLE ONLY public.model DROP CONSTRAINT fk_body;
       public          postgres    false    3257    224    222            �           2606    41081    model fk_brand    FK CONSTRAINT     �   ALTER TABLE ONLY public.model
    ADD CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES public.brand(brand_id) ON UPDATE CASCADE;
 8   ALTER TABLE ONLY public.model DROP CONSTRAINT fk_brand;
       public          postgres    false    225    222    3259            �           2606    41091 
   bid fk_car    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT fk_car FOREIGN KEY (car_id) REFERENCES public.car(car_id) ON UPDATE CASCADE ON DELETE CASCADE;
 4   ALTER TABLE ONLY public.bid DROP CONSTRAINT fk_car;
       public          postgres    false    226    220    3249            �           2606    41035    users fk_city    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES public.city(city_id) ON UPDATE CASCADE ON DELETE CASCADE;
 7   ALTER TABLE ONLY public.users DROP CONSTRAINT fk_city;
       public          postgres    false    215    3241    217            �           2606    41045    province fk_country    FK CONSTRAINT     �   ALTER TABLE ONLY public.province
    ADD CONSTRAINT fk_country FOREIGN KEY (country_id) REFERENCES public.country(country_id) ON UPDATE CASCADE;
 =   ALTER TABLE ONLY public.province DROP CONSTRAINT fk_country;
       public          postgres    false    3245    216    218            �           2606    41060    car fk_mfg_year    FK CONSTRAINT     �   ALTER TABLE ONLY public.car
    ADD CONSTRAINT fk_mfg_year FOREIGN KEY (mfg_year_id) REFERENCES public.mfg_year(mfg_year_id) ON UPDATE CASCADE;
 9   ALTER TABLE ONLY public.car DROP CONSTRAINT fk_mfg_year;
       public          postgres    false    3251    221    220            �           2606    41065    car fk_model    FK CONSTRAINT     �   ALTER TABLE ONLY public.car
    ADD CONSTRAINT fk_model FOREIGN KEY (model_id) REFERENCES public.model(model_id) ON UPDATE CASCADE;
 6   ALTER TABLE ONLY public.car DROP CONSTRAINT fk_model;
       public          postgres    false    222    220    3253            �           2606    41040    city fk_province    FK CONSTRAINT     �   ALTER TABLE ONLY public.city
    ADD CONSTRAINT fk_province FOREIGN KEY (province_id) REFERENCES public.province(province_id) ON UPDATE CASCADE;
 :   ALTER TABLE ONLY public.city DROP CONSTRAINT fk_province;
       public          postgres    false    3235    216    217            �           2606    41071    model fk_transmission    FK CONSTRAINT     �   ALTER TABLE ONLY public.model
    ADD CONSTRAINT fk_transmission FOREIGN KEY (transmission_id) REFERENCES public.transmission(transmission_id) ON UPDATE CASCADE;
 ?   ALTER TABLE ONLY public.model DROP CONSTRAINT fk_transmission;
       public          postgres    false    223    3255    222            �           2606    41050    ads fk_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 5   ALTER TABLE ONLY public.ads DROP CONSTRAINT fk_user;
       public          postgres    false    3231    219    215            �           2606    41086    bid fk_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 5   ALTER TABLE ONLY public.bid DROP CONSTRAINT fk_user;
       public          postgres    false    215    226    3231            ^   �  x�]X�n�8<3_������0�8�dwO{�HtL@/������nR�1`��Ӭ��.�I�$U?m��6��6�������&�M��6�c�luI����$KOIyJ�O
d�]�A�fq꧱����O��n^�߳��j�w�~G��H�@~J�S�q�\=��m�ښE=ʫ�z��uv�����,uP�T �ӧ���z�m��:���z��i��7�	'Y�Sߣ��9B���R��9|�0L�z��:<����7[gFԧE(��2)P���Q}�z�Wg�~GKV�O�6So��H�_b� �����й�������֬ۢ_c�6y�:h���.���N��^&A���g�0�U���P��)����!���G��޶+Z�Z�=c��<�j*�&t�NϽi����F��� �4���x�Y �>e)H�3���Ѯ�"��N�H4�̔;(�)$�{�i5��4z�m	���݆��LdU RqJ.\ W���Q��U�����3a��v��P uP7��M�BZ��
8����z�e���S* ���!��m�z����z��k!�L!� V�@��6�Nzh�il]��+ԇo��´!J��0jH�S��2SJL4
�Q�����ֺa���� � ���E=� �$z�)�m��w�ndM�z� �R�����~��`~�pg���Y��%�1)KDL�v����he�|��Q�� �唕\ U����@�')rA�g��8�&Ob�ec~J.���A����'��A��_t���(�@Ո���9��ϓ�$gׁ</�'$p���M}�����O� Y9��nތ�3���ȵ���>L�Ŕ�{�՗����t���`S-�P =�A���6c`p�f%6	^]� �|peQcVcvWG��f"K���73^�����H(Lė` &:�<n
����#�Gd�Ѡ�L�86��!5N��ٶӈF��{4g�G�\ �;�)�$;�S ��v#�ub?8l=erlg��cx.�q�o$���x�地��.gx�����/q����b<B�{&F�꫻-1�Ս-�����C�i�Ys�F)P�} ���Ԁ�dR�: 
-����4`p� ��G��fTWِi���je����;(�r�+��54h�Z��Pޠe����rA�I�ʒ�Z=0s�ꑲ	����G2���T ��#�.`�0�+���ɧ{ޱo2���	| ��K%LL�S�~�7"A&[��E_���Z�w��,��4�	Fx��!?�g��@�c^�BĄ�v���(mc9�8�Y��<]���%�<���$`����3�]�f�����^�M�H⟲���qI{��i�)��EH�%��Po	-p�b�'bBh:¡��m[0W�i�jL�)�b)����nL��S�!�r"a]���1���R:����a"k!&�����k#�8�S:�E��1e1lg�@�Є�A9,��C0�`�'�#�� J�u�,	lܳ���� UR��E�P�݈m�3r�ƨ{h�ކ&fb�c���L=�΁�Iٶ?6���� [>���ɆB���0�����%,�2x�0%\�nZ���p�tׂP�,��C~�-o:�����B�8�o�H1�ՁHeu�a(�n�A4�X��Į������i|�_S���,��x���1(�#+K���i�1[������#�M!+����uv����Vb��o����׿y������D��7�q��7;��Bawb��rĮS������Y�FaI����	��6	��H'B��*�iiXMyU~;�|r�uQJ����V�rz��s��$7?�_DowbHBD�auѭ�K�,�� �q�I�#e	*�"GZ���I����k1�H�4�y�C�r�:�ہ��1F���nE7S�!�)K���E.�<Þ�����<�񋧥q1DWE~�yߍ�%�Q?^;�H�q�A&�s���aD��T����u�&C����ӧ��H�      e      x�}}[��(������������R�J��VT��.�m@H�ԃT�'�R�������K9���O�����i��=.��|��&�f�a�_z��:��f�Þ=�)I�=�a�7�iҗfV��w�~Isò<-5}Z���3��V�O�o{�)�S�=/7nd�������毦oX�ڰ��/�:l/��Æ|�3�"����i���"���=Ɇ�3,}Oӏ��$%۸�/'��y��.]��ؚ�I�.����Z�nDy��W�?m$���J����R�km���G���~��J��3l�oۿ�~_��ܘ�
㭓�5��R�l��
g�7�?m�+LN���t�"i,����ʊt�~k��f��j���6tX���V�<���>��|��ꊴ���Tu�������ٛ-�s���!���y�VM2s�g�\RYj��i�������W!�/�������WX�ċzҍ�'�eSu�'tݔ�(?���4ս�:,Ѣ贾��N,���^>��$aX��Ӣ��ïs-�$]4�?�k<h�\_	N*%�w�ν4c�h&҇2U9�����&ds�w���1~I��~�a�+������'��[���l�&�~��j�1޷B�jʺ���YE}���4����/�����XN�7�[�����q�a��a:z�����!�N]��ԽTë�5�i��7��Z�CH���*F¿�u��n��!��Va9���&���l!�ۊBW�e�Y�$������_W/��ߚM=��b���}V�n�6o��Թ��J �X��L]c��L�713�Kk��11�>�u��^QO^�lk�{�����: 1("���.������òȟ��t����f۴}>��IS��H�4Tz�m����ny��6��0 �q�g?�ۻ�E��eg7�ī���h��Yd�����*���w� ,�!��`/^l�eE��^%(-��Y�a9.J��g/�ll%uM�O �m�	(k�jsW�Z�`�O�������I,'���!f۟=g�0	l�86>�@p��e�$��i�����>N��I�h	oʺ���$y1��g��Z����,и_c�Y�H�e�xN!�,6����5B(5����ңY�-ے�Zg����mNvxV�ҿ�a����׍��"��^@���n ����k�޷b�F�s7��ͳ�^�X���������;N� 	[@x��l�����Q% *�D@W%�O��[�/����¦�����o��V%A�$�D>/������+~�}���0Ч7ņ�YyI�+t��-G  ?t'�Y����c.~'��瘲~���p���6�C&��y�3m���M6�����C��e���	��������K5�C�!�@�/:��#������T`[��\�d�2���l����ʚ���O�� ��X�~^�W�{�O����y��-r���E�u[����Z�]���0P~_;��6Bh�J.�C�=*�":o���;�ev��9���U�k鷵N�m�Fl����Y*��{�N�'a���|2�Y�>�Ur�qg�8ۯ�)�:i;����+�S��9
��,*w����<&w���S0�?k�gE �@>ٰ��K�Bb�m�k����?q��5�>z��'U�bLi_���ϗ��_�xS4��<Ʉx�ڞ�F��b�b�1���������{c�\?PM����]z�6]'���<�AS%����ނ��m��Lg��P�{�+��6gb��p���R�L��M7� �;��$���^��|�"˙�}�*z]wl��ޫL`�ۧ��mچ�N�7l�8mG��c���{� a���� �b�76A�(��/�����y�G<N��<c����D���"�7�������,[0�?>���uk�y"W;Ͽ���#����8�MW��z��<O)��0��pW�X�7i��i���p(�h�����w@P�aC!����)���UhAP2�~�y�2>���EI�+���y����o�&���L;����EqH�<i�=�/�ڎ6-qSiB���2q���f��(dxw�����5�,���C����
��O�>}ҙ��>,JQ<u܆���BA� ��T8��n%���1(��w�XR��x�P�{��P&S�^����������f�l��M���)3_�w"���'S��b/}��uT�8�lB�2����OPd!�zr`:?f ؍m���o��GD��x���
H�]�r?<��*J�A"� 1���Ğ	���G�>n��������|��; �(���	���J��yn;��w�|�`���e�� FOUMW�6O����1�´>��Z�	�Bá�cH����&�1�l[��,E%hȌ��f�Ztk	c+D"'�m1e��	�)�N�0N��p���� ]:N8�'����L޳�z�����	�b4==�����9~�@��/u���<�1��o�'t �K�e�,�dQ1�eSോ��'���̀�Kd�H�������A#�ݹ���}JI>��_�e�&�$ɏ��� ��C�|%�b�@Q�$(��+��m�*}�:�F0���/�<���|�@.�'����6qK*(�Â����1��/
*�31	�� w6N��mf��閈W�#��₺BM�7O����\��򽕩
nf�o�+;�����V����\fHE2&��Y����U�|��k�r�^8�J�T�4]�W��6�2o�4�P�♼]n�Z"�����ƀt:@��,h��9P����to��@PY���P�5j(p��8¹������'�`�c��Ba�ԓ9ߡ��p��]c��|�ai[�P�8J��Cn8�@�������b�/�~���ܔ�`�u!+���K'���M��Er�аt��_����a���*�j��x��Y�Xg�pʶ��?�x���Mg��$G/�)��~�3+��!��H����=:H\{�7�4���J� ������R��xvQ$)-<.c����o5Rȡm]�� A�?�a��C�&N�_ rmI����9F@�*>794m����GI_�3��|�cbB�K?�e��u
B�x�y+6
�"�;>�r'���4�-���v�)���	-�I��ÊGcx�̩��m��Tz�4[!.�[bc�|.�J����B��>&ʒ���8�����6�(��|�I<�G=6=�=���� ي�/�nEI+�Y<�$x��]�z��ɾ�ND�c���,N�`T��^��>�r��)q�hf�U��kO��[9�<��+�����.��{��g�g5�c8*�s)�
���ZG�m��@����,�O�X��N��a�� �?�NBJ�Ǆݙl�j�"v�Rz��v�q58e�-=^�,g~6�gNE�_�)Ħ��X�!���d.{��Y��=K{���ʞ��1PRH28�k����n�r���$���p?�Es�/"R��L_!#'�QX�pZE��t67�W��6aD���t��|(���S�v�ۭƜgio]!D�._�8�4�3.�J�L�Dr��10����bF}�5]��&�?j1�H6�N����iH������e8i�-%X�mfY���4M$��QTb����֕��s�@1�2��UA�L>�(D�U���f_zq�>���פ�o�:��@s�@%���9JqD*��t�$��R�|�Nu{w��J�˾���b=��Gp���1�q�.2���LB!X����X�m�2)�EZYr���vL��2�7(c��a����w4�91���eg��	�.�����3�<���nOb�IW���M���2LqD`��z�<��i{o���)tI�WR��g�lX��O���D{��E��O���O�qe��@��G��ZZ�\3��j�Ҙ�B�g{����l߁fO��i���3Y9��[����:k'���̻�N��E�La�A�	��.��i�`��W_��K�x� :M�4�MiDQ1����}�PbS1����~��r��/P_��R��ÑF��,���]�Y�)
� -őPP���:�����g�I"��MUlcC�bD�hFr��b�!����^R    �Ϝ�"��T�C��'�Yё����+��$�4_s�ĺ�[l)&�0����
*�����.!�99+�2Xǩ؊�3�2��nB'��N��!��^�z�]Y�LrZ9=oTВ&�v���l{�WeX����\Ix���}�xV81�;q^yc'��Ru��6�A �\��n/���f���[��Ra�l#�^*�({	 �	�=��G����e�끩h����*���<S��J�
�P ��m�BJT�;<��*o��Г�,V���l
H�h�*~�k-���*g깝7W������g�Aխ,I��X+���ʯ	/"�nY>�F��t��0N�� F3��Z%Q��$�asU�qg���w^�e��B`�&���PjY���Ъ���5xUn�dNq���>��B�"�a��l�K�6�[���k���)������;���U��mw)�6�>��*�m�-;R	^��S�� c	��B\S�Ҙ��쐺�~����ي�'���Ÿ�m���2����*��v�A��� l�;���IYg�+�Y@��IT�l�{������3G�j�߼I�(��zc�>e�Z��BB���T{iH�
���k#	�M�l�Y5z۠H=�`�ŧ��06;�e~�ϋ!&�� )�|��O~mΉ�*������`�+�X�&EAE��61_8�>sI�S��[���(CwUĂ�P�ީ�zH���qmLbp	 ��<S��L��.2�a�&�� {�cO���u!��
�����`"���
�8Lυ>	,�d[(���$g����f�9�P(��t����{&�����z2<nnirOc*j�.�p����6�Y`��m���|;fLU�g�S͸#�0��	Wlp~�Am=�����kL
x�����������(�����=T<;CY�R�6�7C<݀��Ej)��`�i�H~�\��ލ�[b2kx�Bb�>���|\�JH!��10�`e����@ڷ�Miz(vy�P�����u���E�Jֈ�䲪�쌐�ij��C�Oh��ҭPg�*���+��ֻ\ۥ8k~�pXb-�&-K���uƊ$���>/fj���	�;I9?=|��8C=�8.E�&;�Y�〶���՚3P����<s]L�[�lvyuz�����xg�+��s���������l;ۜ�}��mq��Px�q��%
#eꊉ��{(4d֭�=���cVi�����,�+��!\�E�l{,���t9G��7١u�(�ڶ�fg��h왇FW8� ���UhO�=j��ay�M��t���B������U��c��ߛTn�%%>K���rŲp�$c�֏Ao��haZ�h�:9]1u\�e�C�4_^����#���i�W�F�/�&��jHF`�g|袤�g�.
���NR�(G�F;�"*�u��W!��`���\ƭ��a�.�����Ay��ǎ�T��tr�,�!����R�u3��G�V܃B�'����sk#��,j��^ì�����0I>�{��>���-\�
��߶�o���}�HR�n%��a���-�2�i29�2.{�g\�f{l� u5JC�]h�ض�͹䨞t�Vb�l����
+�X����K�ۮmMN�b9�_��ip�R���0Y�%��VH��u'*���&3�XA�E��6�!�r��V
��~Vg�F��}8r'J��e熊�<��v��\�6C=�;����l�j�-��y��x���k�O���0���ԥi�g� �8_�go"�e"��\��Y����p�q�	w�9k�=nj̒�Gc9's�l#��9�G����=4�k ����/�h��M.�i�`Ĉ�����[E����|�k'k�\��/[��4�ԇ"����zp.�u�>�j��X�%1:�Ө"��z%��:�c��7�9�ַ���b�&�Z��'�b\�n	d�C��-qBWʩ�F!й�:2�R����ixس�5-���}�g�ƶ+@i{m���[XjZ!�D��Ca�%��GeavL�������쵋����ym3&�e�3�"s�wL�`������f(�7u�bH���e �A�M&2B�IN���|/L�s�}'Q~u�^TN���Ծ���-AU����ŭ<*�L��neI�p��rT�DǑ/�c�	 ȖXT�����lBi����eդ���Q��mÊ-�&q��G��ǩ�[cMR{������%	:_�>o�����"w=N~2X�K���f
!����O$���]d+A�O��VDK��X{\�a��Ӈ=�/9�i���v�Tica�2(�O�ÌJ�>�j\J�ֆ������@��m��J)P%
}�6J��bg_�vښ�����,N��By�d�Ģ~};��M�{[X,�o����1����:��g8ҹ]nꂄ�ng3^:��
m��N���M1���Ѽ�yYæ����u-%E�K����&���.
�(�o��ۀQw)3�]�o��Vĕ����f��O�Ta�!laŶ3����\n��m_�	�Vo�Y����NCԕ�"}r�fЭ(ѵP���𬶍���z[IM�\����1(������Rċ��T�v�3�b{��e��Ȑ����l���6,��u��ś	K��0y/�ǩ6��:=�"H֛�uz�,�Q*D���3�v{��;��t;�]e��v��m��Ɠ�ѥcڝ_�ʨ�v{r�F,ƭ&;�j!E(]�
��:�����z�(��q��#��"4:ս�$�3����=/��K��e��l��4��ƆTW
�j:��k�[O���~F��/���M^�Kd{�>�q�V�永x�R��w�_���X�$z�]���>��SBn/�j�T�޹�c
��=v4x��L9�h��=,�OKSAG�룑4�7���S�5V�����k|�qd]��%�t��M��U1/I-ȓ8�Ԩv6}��Q����ro�p*6����k��I�Qy������2p���b����i=N�@>n��$n3ݹ�ຓ�|�z�H��$t��19�X"8f�+��z<��f��w���٣>��
7>X����|.�����@z�U�i�יYB��������8!;lDX4C�����N3^b1c�u*���q�J<�+��1�o\�G� g �wVp��B��W�}���s�Ojz�}��U(O����u
k%.�8��}1E���݉=�����X�
�̖���b=9C�L7�<ǵ���]>�N(�����P	d���B<���,�y��-V�3��3Oz�6J#7{[��x���b��!�=c>�b�!����w�Xw��W����O�rauXzb�������`��G��YR�M~�@��ƦPtd�����%N!� ����co8�IM<��vN6k� -�fHd�hy`�x-�H��=�'l��#ܕ#�q���*��9xmlKn)�����!ɪ޿�j��ÅG�i����G|��g6v�`����^۩1��/��(����|n$ �Il���HQ��WK���0�h����x��ѝ-���AO	���uc�Nb� 
��'-�&ʛ�Y[�Q�w ���w1�C�oc�4�h���G����������}v���m<��rjQ���h�R�[ϣ�d�(ܢX��@�����+����r��6��ǉp�q�J�_����r��x��"���03��՛"�QcU$BǮ3�}�W�`��|Bjh5kaE�.�0�Vۮs)��ú�?!;l�p5^�r�c@Eq�+���uYDsQ9	��1�?�g���Ƨo��drZ�'9�'�n��R�
�Ϳn��y�*,���AօhH芒0c;�V��%_᭧Q+���,774Zv�%`d����K��=�wг�`O�Pֻ�]�Uqŵw5�=�ҽC��X��C����Cr��bǱew;9�E������\�2�S�V�=4��"�΅%��ܦtC��9���-�ڗP����|���eO^և.��[G�ɻ�O������s��ݮ����_w��ε��5q��ء�G<D�V����t��
��՗m3�Y�,���h2iMNh&�h���o�/(ዧ Z  ,�=fh���7e��i$���u��Q��1�5�f�c��+����ח�)�6ei�'�e-�'�=a�#w+l���p�<P��4���P��TǸʱY+�&^We�/�<�m����2��J���O=ޗ�d�b�m��c;��Tsŧ�V���������3eE��[��f&�'	�)s$g<�0�*h-�~n��<*�=4_��&�1ZW꩹�tfs�mƸв.\/;�d'��a�c�����G����f�7�&��m�Sn#����O	k?����tr���цgg�l�bG R����k`��)v��������S�p+�0��i���)�w�r�R�+imK�9���-�t�W�	]��y^�2_�bxvj�61��`�1�s�;�	�W�Y������`�b����t�;�9nF�{C�S\��8g�z[7C���Ge��A����A'],s�1�r�?�36\�וp0�,v.Țy �8���ތ�Yb7G#�]�n�x�ܙ�{BEY6�گ!���)7�%�W�*�M֎�y�e��ZC�4��PFej7�^�cT��!���Tq<.vs��Y���vi�i��kf��P]��"���Y٨��ws�^i��=B|�`�+ψ�4{�d��jJ�	���+��xdT�nR�$�K�-�+�$��/g{��9�E`�k�=�y��� �;� �[�QF��B�s ��N��w���WF��&��ܭ��n�vq0,�C�
V�^�})=��k���rY�8F�N�n��S�2TUޚQ�E �!W��������mb���+�V���q߷/{bUE��2�Ş�ѹSp�_�.`�k�m��V8�7�5/v���r�|���wSߤG�n��+p����E����f�{~�,F���H�gv�`$�̘���SBx��i��nMM)q��|A5fn?B�4�Jo]AB��xZ%y$I ���̐:kW��6�zж����tW�*j��u|\�0g�}F ���m[`w�'�N��)G���ʘ��q#�x�T��A�� ��:���n�i�o۸�n"�@��@E����Vn�kes��':�2côƅ�v��\D=�Q�/S6��J�{��
��c}ι��ϥ�.�^�D��~��U)��䔩�D\.�������@���[[�.�z�����%��Z��rɹ���[��qj��/¥;�����r���Xu\p�ᬐ��نx8!/Ox����$��\�5�v�k,��^Th���&v��� �W�#��
Ԓ ��w��k�a%\~we�gV� �}�F 5�+�Ȧ�W�FuB�����a,�9����m��'���%,�'��ȉR����,bYW�6�_g;5P��Y�ȕU�८���<�~�݄ϫ�x����VW�8�����5��d��؎�d�ɽ��y��#݈�k�����!=���a;
l F�N�������P�#�����O���ؕX���.�����FȮ�Կuu'�tK�)�Y%0Q(V�"E<o��Q��{h��Grע1�2.�3���}��j �L-��c=[�N�T�ܡ�$�D��J.�qV-��~]�:bޙ�q�<��wlI�G-��*_�~Z�}ć�u�B��ά����܂�Dy���df�n�L��Q�5qe��č3?����h�`�ͅ�56:Yu�I�ƴ�P���7&�.CKۥ]�����7���[�h��<�j�k��wP�-rPv��+Pҭ�Ò.��n���ng�"4%6�����~�~%�a\fV8s�yG�� �n��T�Y0�=.�+��׵@�b/�p���tr��Զ���-��d�r?,���t�zHٴ�ʼ&�U�z��xtNŴF}k��Y�D��]����]��xm�Qi]v߿�����x7�W��L=��u=z��j׍�/�t�`�k'��\'���{ENt#�ݳ��&�!E�SO��������r��O����~�.�}���ë[�}m����͞�n(G�C������b�'����������Ŵ�5h�D�2E8y�7��	`�g[}PeL�^9֬`	���(�
��@T�p����(�U�/�EJGG-n�}b*��Q%j�c#M��:�W��;�8>r�.�XX���n]I���t��lB�V��U�tX��M4��3�������/=�	�      c   \   x�31000�NMI��420��54�54�2
qz$�$g$%&g��,u��,e���	�p��u�,����a���&�Ff\1z\\\ �6      d   �   x�]�[K1��g�K�L��h�R���/����..�4j���^@����9'�#"���Z�D�IAE�{,ac�Gk���@Sx5݇�VG�GWM.�����9	Y�Ë۫��<26��8��΂0�n��h!d���QW��V��kxh�� !<��N<
XAp{��t|���L���p`�V���Σ0:�{�����ٱ���aݼ-	��Z�����"/aǶ[�FqOwF9b�S�WI��0�a      _     x�}�Ɏ]�@�W_�x�3�I H���l�l�aG��P��?�*�5�Vl�n�Y�C͇�\/�_?��|�F
��5�.\ !�k�9 ����e�G(������~�����}�6���p��lz���d����/�0L��3�+%%P���3��?=�ߜ7��U�F����q�G�Ӽ��˕��M�Ȳe��NBz͑�\�F�V������׵-�ʹh��]�ك�y�v��5������Ū*}�/5��#��?���ߞ������Sv\0�WslSG����@+���+�S�H��_^�W�#_�<.�:u��d�@�#����//(���#��^;ZJ~�N�I�71�*��!MO�3�u�0��O�����|}�J��O���2����+��?���x���Mu��7��sHZkqjm��m������/�+���x <"�	N�r�����蔓ሬ��ځ7ߍꪨ�<-��� 0O�<;����j"���sz�A,'N������뗫�]�N6�#��]�B�p��d��z���Q5�ŧ�@<a-cp $�s����>��؍_~���]�t�1ﳿ�ڕ2Pt���Hg����W�Kb/qn�YYx$�u=};/��q �l���im�̻�YLJ���mIL������OOtXp�}�-�9�ô�z��es]Nn(���G?=�:~��k�P�K�C���h1��4S�_>?�{uo�l���+직=E514+�֒�u���]WNI�\lM�G@p��VnHy+���� �Zk0}m[Y��tL��ΝWRLu�jwf��1���+�'���$�i�.8��ے���ɇI�4����� ��� <yw�6��0�0�O<.c�y��s���;6��#s��;�iT��(�_�}vY��j+Gq�"J*j�x����q<�㕟��0��'5�06 �󦘔���*�%(��m,
+��<͋����
$�o:nN�J�>�g�����^�F��bS�^Q�FIΫꋄO(ә�K�����*o31���.:��hlA�
b��%�V��36�+���,��Uf[k�JKy�4�����ģ&U��iE���H KґW;˞Kri+�y��3�� x�X:_&�y�m���*�hW��競,��}`�{~ƥ7W$���0(:�gP�-3�-mn㜰pĞ^է<�-є�@B72���c
e�wjKt\=�u�:���U�.�l &��Yqª �H�Vc�л_5�G��*�jv��ʬ�T�2��3�Q�񱄃�>i�(�U�m�Ɖߺ(�Q�G�@�ew�he�U��&�j�v���jn@����d�Q�B;��,'��Y<H�[��E���t���; ֱˌ��~���/ߴ������=Đ�[���8L��zٶ���U"�d�k@�)�6�hѵ��b%`n+���h�˱������Q��d�&*J������&��"�!6�Uh���C]�� V{��v:�� �>��/6 i�ԨU�y�q�0�R�6T'>��iϝFoZg����@*jeQ;~�wt����]�zxS�S'F �`��e�(����A�-drk֓UjϤ��\=�PH�n�f	_\�Ob��!���&9����Lw��^�����G�i��r9Β��fǯ��S$�w)}]T6��)H�����8$��n[��*��cV�v�0Ȁ�*���̾�$o.�l2�U
B(�E�h/K@��]f�~��!��@�ۗ�gm�C̴���#e�R�T����cs�Q��U��ҝNb
CF����*����P���7�Y�pG�N�Y����c�������:W��G��6�A��*����O!�D�[9 �j"��D X�{�1�S����Ud<�,2\������M	N8/ bKc!"��/��(�5ɳ���JN�(.D�ϣ��C��E�>��o
�"#�F�F �$�^��p�P��9%�9�Uަ�G���_��A���x9�.�f|�Y��a��M����L�Pt٠;׀Ǻ8�X*��:�(6��䫹Vr��ۆ]��5����LQ� p!�x��.A�.���t�Mv���گ��a��n�1�L���_�`��%g���m�`ܔ^\��Xx��΢'��i�ԭ�b����`&����+X #^�N 
�$�}���0[I�^B�����U��;0
�r�,�o���(�m���h[�e�� ���s �f#��艛�����U��H;lA��兠 �7��`�4�H��,�)�:g���R���� �A¾�;�Q`����Х�^zu�-W�5.6��a
�����n]���}�>���gso����|�H�� �;��뇵�r��m랮���z�,�#��R���0"K�0D�u<2VStA, �TN�d�X�6NѴu(�6\����Qn/0��(�Y��(�m��),��kF���?�H�$`ܺ�-'��#�CϺ)�A�BQ gg7�TQ�Vy�	����p>��fӔ�6M�|���'�G����Ȧ�-�8�H?�O|�5	dK�����œ��X,��<*�ƛ�&��)hr9�fO�E	wv��"O����~�.�^s��@�'��׃���F(
�d
����zӐV�$f�
�l>�ՏEP|��
��FP��(�
F���D���P�:�R�Lۣ��\K�Z��4F�Q���}��n&K1�UX
�}ű|hon8�-(j87��Q$NW�IItv�X
Z�۽��V��X/8έ����EDņ܍T�&G��Ae1�~W?)�����6(&�ܕ\`�0� e>
AO���V�Z��6�@�:�� �*Pm��
�kX�xp�H��4}��vޯzO9�}ET�k�K��X!���E���~^�{ÍTHk�n-T���`S�k�Ңt6*�d;�oq��f)���\�9\�����RZ6�?
�J��_�l�Ҋ�b���x~��J�V'�.�C@���t��l���`�?�����J����w�a���
��V��b)P=�Rm��TKX�ALǿXYo7�{J?�޹us�o�� G�W�_a�=0֚p%ܪ}��=�vE�-Q��ZW�
^�<BQ��O��P���V���;p��3(�-��+��]X����׀��ZvH���	W­�熡�S�d>[�Z�;��7�X�w8���Ʀ��8_Xfg���p�W��M�<�>o�2NfP�o@�#���ё�����,�r+~6_򢳻���K�[�,�;��CYwK2��+�����牊�Z��M%Ms�o���,:pe|�� !�*��,c��Aկ��ӥ]��6vߞ�o��]0a��޽{�?x�9      \   �  x�}W�n#G<��b�c�,T��q�v�<c@�踗֊��|�b���oTU7�m�&f��U��ཧ�G��þ�"~��mt"����;���䧎=孷��O�ݷ˽����i8��[�9|��?�7��e����<b�%/��6�K�r�$*1�T�M[��O�\�^�?��xz?��#�cV)��PV����S-U��vW��o�(T�EohM��@��B�mo��?���|��w_���E��S3��°e��?��؟��.�OD($v��&�1��� Q�����x��.3��He�Mn"�|\�Z�R�cx�g�*rQB����Ť�fX�jI�^��o�y��y_�Qyf&�
5�T��:��-I�O��po��R͢����i���>ƅj�� how�o�u�Vr��Sj�c��u)����}|�����C%�8�*G����2~Q3�k���?��y��5R�՜'����6ΓRK�rUi�x�×��yҪ��|�!ַ����S�150�U�A_5�L�;&T�$����9]��n�����-J�=�1{�L��������t>����w�<sȵ2; 5���Z�Խ��q�.H�YP$�r�?��(w�⒍�i:r�����R8�Y_�a_ĺ��ʀP��� &�J
͙-�S�m��e�2���ǃ A4[I�23}Gj��s�F�i�P�G��*��кJ������u|�\0 �-��2�T��y��S?_�X���q>IX̊C���u��ߋ��Z���S���CCu�P%q�)UB��`s��y� ��>�
  �	9����3��; ��g��5"�̼� 7ã�'��p*�<���'}E60XL�"t�Y��t_���~���|�]a��r �c���-	YXx��ԋ� �<� ƒ�Ȩ#hʇd�֛���g��9�l	���\U|9���J�UD�0�[���ZA�j9R�z��<�M?��"ݿ��n9?�B�����2���]�>��
^��ZR ���t�cQ�~�cm�[���*�c�dS8�<����}��>w����,FfI��<( ��{`#[jDD`s����0gVi�",ͷO��h�b�I^�����N�ǰ2�qk.�At�,>��Z�(�p��p����-�֜"Q�-�"ަx���킸-�vy�9+@Ԣ�C�t�,d˵���+�L��aaѦMF`M����r�P��6 ��@�Aɗ�8Ë0u�-��q|����i��O��e��R���^��p�lL��J4@���G �+C��U�~>�5��S� T�Yh�e5+U��o����WĮ�̷6)�/p�U
��"������v��B۠�U������Z_=HS���l�-��8W�tǚ������i�(LH�F��a!j�%B7���:����Z�J"���x�˖��:bF���t�hxr�h�rY(Y]��
Ωꟶ�g�����<�=lb�:j�[J	��^T�ݰ#�a���KJ����OӤ��:-;*��ҴU���3�Rua؋p��9J�����9pհN�ʥ*|��������G�P*���Z�XĳN�%Ѡ��$����0ݕ�4�dT�)L#-%��X�6bP"�~��fzV�~�o��}x���T<O`C���WA�h��irE�<<#%�'�L�%�*����_����J�~      ]   (   x�34000���K��K-�L�420��54�54����� �@      `   h   x�=��!D�s܋��Y��^�����,�� ~<kp8��v(t�N�zJ�Bg��k@)]3�`is��=@G���_�ݵ�f��������;�K�x��5��&�      a   �  x�uUIn�0]ӧ�Tp���:	ں� I�n���0bJIi�����h�����(J	��(_�V�ƛ?MQ�7�	!���P?)b��e����U�xZ(�P�B�Fh�By��z����,�*Q;�В�G�!�"��2��1�g���>�4�liǊ�V�L�
.d�����7:�n�Y�>��%��⨥#A8J�R�&-�Qt��u-�nu�pxv�%�f�I��=ltP�86���Č�k]��w���&tB�vs��}�^���������[sb�� GJ��em��&�[B�R�5Y�S��L����i.\o����g{����D#��ڭ�h���C����Oa��	Ϻ�G���R�}%`�u!E�{�9gs�L4"��t�M�%^��~�������{J���*]�%���m����,�t
�%��`C���"���[�v�f����j'��$�]�a�1��cQ����Ei��P���Ք.��B�=���i_�p2�t���Y��G����iBm
9(��<bq]�
�����)@���8u��xl��-l�Nڐ�JU�x������`�M�t�'���3h����[�K����������!�&ߚ
�f�=,�	;}h��i���ݝk�J�߳��Oac;ųy?���6���wj^I>sDCl�ͣ0��ԏ"{�.��OO���	f�|��^��ǥ���S��8H�p�}8����X,��@��      [   :  x�m��j�0�����xX�ooKa���X���nT0Y���Ԧ��'��6i ���tΑ�Bk��%W7�zj�m+��{�q�P�|a`kO�Q`pO��J�-�I�*�)^��G�QhMa򖩝u��#.S��ew�Kj�#�ZW��V���U�.�!�w:�-����PO;s)��B�i*�
)/�w��y���P�&{�?��D�$�B���c��;vs�dۦ �Wr�f�d¤�K�T�Q3���b��LT�
��ju�/��S����>���d@�a��o&O`�	p��}݄~$�^݌��vof����)��?���C      b   ;   x�36000�t,-��M,�L�420��54�54�2Jq�&�&��-u�Ȉ+F��� �O�      Z      x��]kS�8����W��� Ь%[��-wBh $����n�׸�����9G���{�ݪ�zgg�8B:��97� �w�f�t쟦�0g��m�q��m�ۖ��T�ϥ�r/��i/OG�����LI.y�r�)����瓹�7��Y�_Nv}�Ý�� �e;����#��'���8o����p�u�Y��Q�K��*Z���(��j��[LKV;̀��<J�=�b����o&}s�x�j��N�|>����� �<H�
�;H�����U�����N:��/v�&�]o{�d��홂`�g��qB�G���4K��|!&#{KG�^7��	�8f9������C6�����Ş/��92��a�-�!#�K6���Wy:��N�Mv���r��6�U��%��_գ�J�V����]���,��9��S�3���l�����a�;L�x'�'~��E��Q`�3nqs@�0�&���t��ݳnǛʵ��j0�s*����3\��9{F8��d6 ѣޮ�%맣)�aFG�N{��������n���i���(�"&m���{d	�?~��v֟��ڽh���܏��m[!�--����� ��
9��𐯠x�E�	�eܣ��"�?�*<
kQ��t�]gc�W4���x�P�.v����f.�f�Aق���A�H9�É
�d�6��}���gl�
��t��
�ޕfq��b< <
����I��p��#�������;���-?���TXW��ĒW#�':�=�/��^�Ogb���q�?��]�Y:H���Z'F�a��7-ݖ�Y[�����<pO!��Z�Γ�d���۝uǝt8Ks�x߹��_���.i
r"���� �� �L�a�1<x�_�^����I�ୈ��>u��E���{ڛ�e�=�����hL���~2��T��%��������o�O�<ϼσ�y�m�^2��72����J���]��t�5^���_p�Bmo�(�Ӎܤ�W�nǤj}��t������{��1�C%}��S���I<�qx7t���ώ�=�L��f��s�g����[?Hv�����*��/hn6�|�����K�܊TZ+TqݝwIh)�\��*����������~
ʔ;MKN���¿���A(YZ��`|�B�e:���b��M��6�b�i	��'�@<.�����@���Rk��'�_�f��#��~�d@z
^���3�����c��i7����v����%�m�R��i@*�[)<I�1��� ��&t�����C�P`�@�)�0i��!��q
�]��{��� >�4�P�4X�p�Q�`,~Dy�%#�̦s���n�����.�c����zSxZ<"�:�Z����c���;��?�,��l�̋������r
���x�K�I�R�Z���;����-���?c1L_��o�`�}xK&)�����c���|,���d��������4���� ����t���#eLo1��SV/,�w�p@����JF�5��uP�ō�k�̈��e:�g����}���������I��1�g�A�Kq�ƿ����y4�1�zYNS��>�?��Gd�g��G�y'85�����^�3UF�!��� y]�_Q����8��=��F�w��������?Aw�8�~\��D~�3�;�#<�O�����>f{^LhbA�+-/�2�(���)�60���{����������bm^  /�����;���|k����y(! ˨q݁H2�9I���9�0�)x����ꢈnCpN�EH�N0�N�qwh�.;��}3����,�I�4�c��@ y���T$�Oo�`�~���y�����*
(�sm�/�Ny{��{��y>���x�w&�2
ցmJ2�3н�g����2w�;�
e�*���E2��Er����a4Lc6��	�&��Gs1R�k�t����� ظ�G��r�<gg�f� �$�)� v���2_����P�  ����?�^'ώ�q`s2�pݼ�Ty2a
"V��У�ܢ�b.��w�!Fr�2����ꥼ�� ��
(�;ْ'õ�
X���4 ӈ䒴�C���I�ȝ�|ÀY?6)�(8��# �oG���S�ޖ
�k��� v,��F���`��抚a_ !$rp������݀�J�ϐZ�9�w������ �w��LF��"�p)a�b�I8����㚸���	 ���%�'�F6C��0�]�?��Y;��<��W����1$�7�#�w���7��߁�]g�b!c::/�Z�(#�����	��:��ŧm�y��T�-|�%"7�<�%��!��<K���� �2���g]�s�n�N���T�C���mpv_ �¥}����?�ｹ�k�Z1�/pQwӏ$�e�\H�^�g�5C�8����T��/E�I��Ӟ�]St�� [bh	9�^N�1r���Y����ؙ��5��`�	`BL�10A�7��c�j���޶�+�"�R�J���~�dd�Ȟw�w�������8��y	Xu��e$L��Y�a����u��"�	 �m?���םWP��E-�U�8�2��#+���L�Ir��8�0���5":�P��P�_n�;󿒓���}o�9���DQ	�⊯��Y�T
�J��@4p6 ��45m���P4�fH�o���`�� �ń��U�[��{]�\�w��u�!�7*5q�HF�=h{L6�?N疹��#DފHGB�SE$6�6�!�;b�~�>��1>��4y�wk���X�{G�~���1��;�<��OfO(�O.�eh���4@e�n=,RM�Q�޽��P}�Ȋ'��q��!r)��&	d8��GIj���o^���i9U���o�[�)��������^`okM|=��{EJ(�\�c����������5ŗ+�i��������A�j!�)�F̃��L.��6����B���Q�`]��A��,�cx����X���t�����YJ��gM�th���Vhn�{7�1��>|�������۱ufa��%�Ga԰�d��ɓ$�_;R�2UY"���E�1*)}b`�� �A>��
JP�Ox���������?O6��^���B]ԝ|N�RAS�l��G����|���X�w9C�L������s�"i�П�\ܭ�]� "t("0�fF�;�4~�$�I�������?t`9l�u�ٌca(�'��W����� ���M����wW�2��'A#4��݉Q֮Aj�	h#{�bc�<�8
�}������ښ~��m�PqJ������B�2�;��(�;�`ɮ�Q�\	Cz
n��Ў��l>yKꧣ<{�����wx`	�jE
�y�n##�̭�?�xW�T,���!+B�V�~N<(c��O���n��l+̗��+V�`���t���c�sYUo�A�a!���=� <��\'��C̦Si�p�q��� ��{�O��q/l��	�nP�Bt����P�������I
�q2�X��s5�1�? r�Ȅ�G��4~L�荭!��n�o?��`�D}�Ž)�Uk�@)z��4�D�9D�J��r���oe�X9�[�r� a�$'¶�x��˛�2	�"���A\�aC�J2#E8y�>y��,]��:��[j����L�hrTD�:Yhw�䝌�C|�����	����qS��I2I�$�����v�s$!�����Ba,�&\�Y����3L�-W���[w����=@x/�FR7�i`���<ҝ� ��ȒY�~������¾L������6�����審����E��x
����mĳ���Ŋ�9K�TC<���V��+�
�!��SΧ;�����#>��d�{��/�*F�Z�dV`g���+J�8�|g�eYn�s1
qpq��D��W�@d^���G��`�0@��%D���C�\2(��-�"Y%螞A8C�U8h8�~+�2�    �3��b�`;O�y�!>��w�b|3��H���%���$���h�ց��u�|��5NiR�.�*	"��ZMf~��)����9�d�C?�Wo�f*��+���l��5��n�J�EP�*ݓ(�9���R7�8j�S�x���~�H3�h�`g$X�j�'��s��Y�n#s����;�S UT�6C�4%�
����(����?g��b��X y
�nL�_H�խ��A|�8!*����%\�-JAd��|!���k���w���Fpw0xp��ܓ��E���q#�d�Jɡ�ԩb)����+��XE��PXwRey������.�G�K���߿��h� ���u߉���)	�[G�wLi=�O[=�j�"g'[e�ؗ��.�
t�Ta�ޚ��}�ȍ�R�m������
5���̋T�\!n�<�遹�ڔ�(�3��wp�����{�x�o��A'̍0��6�(�����*|[LިV�"�iO�	�9���p�+�Lv���	�YJB�� ��ց��7��[|;z��`�8�Ǫ���������H�����S!�����n�B�J+�~nӵ �*L���}�}~��|ߡO�Cl� 5BޡA�Fֺ���i���a2�5s9���E�!m�V*�K?ET[4F��G���{g�J"%�-�?_-gD�#�y�cD�6}�����瘲��sS�;Ml���A5��v����
�����?^�(�G��D#;�CA0K'H.��F�n�tт��Zl,Vw��ϒo�~V{�@;�K�CV��u9���n� �o����� ��I��K���n�px�)
�JC����<F�+�}��[m�ȓ��������d4���k�����|��o��@�"�
,^�"��2Wї���m����Wx�F"?�b�.���9 �Q�NPʺ��dt�����-��܁��`����1�p��{9=�K�Rw]���#@� �n��~�W��KQz���&c�}��?c� �bJD%T�e��?�;#؈`d�z�b���`�QT�8U�|*7"�ǘ�s�1v٪ZPB3�TI�6B�byf����h[5��q�6�FmD�QK�}p�"I�hl��K��D���b����� �Ȏ�:���ۙ������̴�`Y��j��F������2�v{�n��q��RT���'Jz�ϻ�#Ɋ��>��_\�U�`��E�������ņ:���:�w���c�2�3%�2`��+� (��+����ȋ�?�}��s�e�f�LX]��q��䕄m^��M���u�5� B��y8��B��?�^N\]2ƻcX�j�pee!�A��ڒ����JJ�zVk��	�(�����	O������ L/���j����b�mд¼���@���xc�E�2	`ǣ�!�0'	������`S�}ߤ2{�I�0�
��O�9�d�DMsm�3�= ���c�Թ\�2P
�1��>�L�uҾ��茭��\�&v΄�ktN2��cd�{��пXd3[%.Z��q(��-ۣ����;辠�>�ȼu�����i[�46E���%��i��u&�$�͐alg��wE��6��
ЃxW����7F�yfb�Q�C��z���.h��(±��M�/E��4őw;|A�A=� t6��&����V��r���J�N�8�Y��g�g[Wa�E`�*�J��� ?���9�u�@��L@�<����>?��}�"�#Ӭ��d2.%m�n:����b6���\��dUT�b,bQ�9�Wℼb�ur�d@$}�Xxӗ���n�P<n�pH��D��@2�XI׋���'b�$'�I�E:'kff"B��0h����w��?Q~�>�ƚx�x��Y��ك�a#TI��DU^J{I���]� q��2�˄u��1��Sֱ�o�`�5:3,bE�v+n��r�����P����`E�����i��I����/��b@ (���~�{���E��k�׍��#JP�%�-�^#� ���2��:k�.c�v���dRq��*�Y��l���7�.��6�P�k�i�
Ec����N�4�,���N��m�#Al�eؙ�ؚy'9�32��im�։��l�&�
&���*HQ����5�U3��x�¥�Gh���z%*���l�`ζ��z�?��x @�@,��7OPs0��R]�!�U�Ц�p(�^�R�&��W��Bb� 'b�!ҥ9bb�cp�!G��,���G%Y��@k���E��]�ll��esl�*�q�.���_G��"�H�,� �G��~w�&]�%h��}���c�KR'GT�,���h|$@
S3	ʾM�M��eS�����Ͽ����s� �LB�kE5K^�n�(���k�S�bZ�b���S����x1��aS�W�Oo���q t>p5��S!\��Ll�,�1e7�F,�BVƓ�����[�\�r�'�)��\�b�l��xZRVNV��5J��@ұ �:]�f��9�U�"LY.*ôib����LX�RA��b�8w�eG�Ձ��b(ayjE�^�,�<�4ܪ]*�Akl�F���wM��1�%fyO�5v�&��Ե�a�z([��%q�ScSt���	���XD.(]	6!�j�Ó�$���i��R���[�*���R�����j��@|u��_���q�1���4d���c��5����
�;c��gv78�����
��ЀX��[�����
Y�SK�9d������8*�{e���ł>\�"���ه������c=����lE;?�'c#nG ������:��r-6y���804;
K}ft��������ܨ���g_�<0s=���>�zX~ ��_�����޹I�N8�R�k�-�X�îBӳ�Y�ȡ� �.2`k7�B<��㭇�#u���5����Z4B�>�-��pc�U���%w���E�Z6��[@��?l����'p���;Nq 3�1��ɓ��8m���
0ag��΀L�\,y"���Y��+z`6:�����!����3�sE����;4�\)Q��&D�"�rz� ���\���)���|���7�9�a�Z(e�7����ե.Y&�cf��¸�{�D�w0��gsj��og z���&;y�9��r-�p�1�љ']+�,H=u�Y@�ZE�k%s�,�1"�ޏ
b`oI����4�P��#�������8�`pJ7�p�䉄����9띋�s1�]	�G��ڴw 0`4�9C:����>L��z*XDG�1招�4>�6榞�m��8����jD�E1���ZL\�e�0*j>�����{o��N^l;��� �ۢ<M�Ȃ�� �]��J����Zȸ̏���0Ʊ�1W16Xf���g�ӷ���#
B��6�e����U	>g 49��I��X�e1����م�T?��l��l;8ی�}��'�����>2Ҙx4��f����J%S�V���{lF�p����m�O��[��p>�J�In��M�Ǥ�qfD��ũÇn���8��{$�Dp�B�+s@��KᅙN�k$��^?/*I���nǶ�Q
 ��-�)�,Or��-��mE	Ij�3�k��KWF�?����{u��\��ag��q����7���{�+� ��O�GѲ�TF�%��_��ھ��!7o�@���
i� ����0�΍k�X��8�Z��v�땄�\�^.d���>�ĩ��-;�MzgOL�p��ٓ%�ov� �`۟����H�y�L�p��� �̌v�l�²�����\�<bXL�1����� ֋��=l}P�l���@?j*��-!�'[�J���i�Y�*�e۬�!��1�=���s4��������X5��W���H��[Z�Nv��,F ,�f�]+Sp�m��9l�ϣN�ef�<�Z��u�@,&�z�Q�X������wL�4)�*�c��s�q��>!�*Ʊ�0�޷mu����g��3�˸���/.���9[�S7������j�b�����m�]04���|8z���0�d�a�2n��� hǧ��il:�    D��L��<+w)��n7<2�k����.�����G�ܼ����Fqû�B�dddL�c��A�I���҆	�c�X �+�$�)�x��?ƶ��e��u7�k���)�%����+]��cꄻi=$j����}�W��B�/�}�jI�J6:`��R����(�r�%��V&҉"��ǉMX�мB��'QQE�2j��V�.L�R�f�%?�ܦ!Q aV"a�0�t��Ӝ�9eQ׿mG?7?8NGg!O���z�$������j�'�7ն�I�8�g�C]S/&�(���1Sv2��7��{_�ߢN1ybm,�׌���$�����h*�E���:)�Y$*�H �r��;նG
(?���?ڑJ�4��e+�����B�&�boP�M�c�PX� N�k:�Oh/��Fx���F����o0��m����Ka�i�UKD�~�Ϲ`���_m����d��[p�<�$�ܢ�'�R��y���b�ӊ��V�v�ŌC}*���.���I�¿(�Be�{{�����v3��0�6��3Tg���P�'�S|��
M��# ��N!9��@q~�����y��d4I0�ݝ]:
L��pa8�R�<�7�-�7\�Ҫ-Y��p���cS��n�ݿ�B�}c���R�}�+��?:�,��3�D�^������Q�]'S�O��(�yK^�0���iq��+p"	n7�����q!P� ��<�WZ�5Jн��H�/
~r��'���d6M?/�FXY��
ioɢޭ���Z��#�n�����l�[��U�Et��4ŕ*g�	�0Z`S���V� ���iDŎN6������x��} رȕ�Ec�L�BX�0B��꩖��]Lo�%��1{e�S[�a@�Mú����������S�%�h鸱��t�Wfj�j�b�ǚT�*d�����d-f�M>�	⽿�6���� �����k�1�J�OO N��ҴI���#F��t�6t��N?���8�������B���h�n������ j�~���|�p^�v$2x~�#�>��^��ý��.�+q��Z�jzR̟>���ېW.�R���\ހ�)�7&��8�'�v�җ�}-��S2�p�N,8x���X�;�6��K2f3j=�� Jkw���Y�D�S�v�c��oGg}8���Rj���

�%��	�%B/��o��D��Tj�*%��bN�FZX6*b����9^���c�v6�Ʊp��8�� ]��˕Mx�����V�QtG�BR� ��j��z��$\\��q�x+j6�A���6j�kw ����]uǋ>��R��)԰L@D���"͌�t�\fdK�x=�_c�i��j����.�"Qj��.��C�E�w���F �ٖ&V�k�m�+{��V[p?������v7	b ��`�*���@��B�U�M�ʀJ���OEia�J��y�0��[ѯ�E �%^c��%pY
I�K�]�^�	������l� ;�`�)���
�զ4�.^B�Cb�F���ױ�œ�/'���e`�.xR�Y���/�,1�_0*:���0����%;���?��
7��Hj�������I���T�Fi�K�Z����!Ҷ2VZ��U�?nc�( �}s�@�ZA�+��AygF�U̞9�y�;pU�ʼ!�^�܀�ȹ*e�s@�0r��	A�v�V|�y9C��`.Z4r�V¦ �n4�+*]p����D1Ӝ�K,W[� �L���E�{I,?�;�k��q0�R��f��وт�l�Oz��,��ѡ�C��eڋ��`��?�Ԭ'L�����u���ZQ��w��S'�Weׂ��l,J��;T�%�ь��IL)gct��p�U� �������5*k��q��E��c)}�'~"������ꊻ��ڕ��$�	H�{�Q&�� �*���v39rcs���F�ިY�Q� ��^Q��b��r�9���^Y�X�_2/Ǜv�4�-�ۈ{�ݺ���D;�~�j̙�/������1���G�A��W%��L�X|�[;��[��O?@X4<�������O��ZfB@4Q�lk�����B��
�9\_��6S(�]���H��!@9�V��E��}����4��0�t����	Gx���>o�aʒI�h����$�ʜ�4k��w��siB[7��w�J���,�6"uq5��Dq9�1vјD��j���fj��o)_Bڎ݆����(M~B�#�\c٭��k?�]lI����[��i#U���JE0]�}j�Qb����r+�RyWYe���:;z�1ȧp'�K���`cV�vi"m}&O5ltF�6�2�J>@��(�S�������ѥsiMi ��7�Q�%�i�2T[Qp�_2S��qSR��;6��0�����eCew_ma�;���}���W��/'K�K�e�Y�����'\'�iƬ\�]���}R�5�4�9���N�ʭY���P-�����
�%W}v)A{{��u��b#�/������gK6��$Wn��(�=W����z�1��yA1�b�8RSG�c�?@�qٷ�闸����A��\��t���|�5�"�;>6�
���,�	�b��!���>���p��m׌[����ou�u�e��~�ya��l�Lu!���s�ղ�CH����s���w���٨҃��&Ϸ�8�GQ���՜�*mX�:��(P%s��] n!'�\�	� d��7H����ƣ-��V�c@��~ڃԱB���Jİ�|�b���/� p�?9Jo@�I�f2�4^��]�֧_?�_o�g��38.�Y1;��n#��̜���<V6�p���Td����->���ևf�b�}\��r����b㕖V�EAm'Ӎ��K�M��`J����X3�֧r�a�XC����I �{�*틅��2�9G���XV:q�b�#�FUm�)�n��?�[��-�x�WV�]s��z���y���d���n�A9mf4�n,�3��k�ck�$��y�����&;3(V�B�L���������M��z>;����⺾J[827c�׸|�OJ�n|X��Z_3���m4w��ZY@�V�oN��i�j�)s���t���T��w2���`q:�qc!�+J��Sզ�6�� 2-�Lw���L�R�O`k�	w�6�y��mƦ���"�kp�o����;+�Ѳg���b�f�Y�2�C���Kˋ l@�ͶS����>=;qx���b�3
�~��K�c�
 �ɮ���*�fP�mq\~��]]N�^��U�aؒqc���C�9��°��;��CnG��We�&�q�q�`�rM;V�a�-�Ͼ�T%�����fGD�� �I�����2W���� n�d������.���L2�)L���}oK\���j5w�J�ؒe
#F�vx4�'ø���v_�.��.L5�v�[���ȯ�2�Pᬗ� �V#S���"�{�A�Z�kCC�2x93nJ�b�aB�o�ݦ>>��Ӵ{j[!$�� �T�U�������)逗żF[^�������p��*}���舣�W���c��C���]���f�&|KV�U�#/�pk��l�3{c�f�F7x�k�x].��"�;�1.�]1A=�ʑ��>��W�ZS��/�j��D,�e7�1n��'Ԁ���Ŏ^Y����C��*n�f�����ܫ2h�k�z�~����'D�J���W�-ӽ�������p'����F�!��	�c��W�-e��6H�U]�_�<�%����B-fb��O��N^��!\���V4N��T;3�.�_Z�����
7'p���Y6e'�DO��g.�}~�|J�����S�����8-V��?euS�kǖ^[I��ɸ^����q���ɛ������u��3���ii���4��2�{��XVVy���@qWG��@Vf'?q~p��[Z��-�]�)	-~,����KU @��bj�uHia���LN?�_�fw�W]����狁��-�/b���(9���~J�N��ڄr=��}god����da{\c���_K���=c*�lJ/�$�?�   ����)�;�� ���b�`��v�WV��Ol�|�n��[
m�c��n��n!��-:7�i:f��@����8?������F�j$��?Xa�w$a��U	����}�ߔa�eP��F�bu��V�ra�����}3�������| ��-�e��3ն�R��4l;���Sh��V]��w�s���(�Z�1�ӨUd(��V��nh%��3i~�b��˔�4��q�-u}�u_?�.����l!0j�1{\�w�x=1�������UT��b���w�?������b�     