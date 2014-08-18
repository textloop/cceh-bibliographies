<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
	<ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
	<!--  -->
	<!--  -->
	<!-- Typenbergreifende Prüfungen -->
	<pattern id="idno">
		<rule context="tei:idno">
			<assert test="@type" role="error">idno muss über @type verfügen [idno_001]</assert>
		</rule>
	</pattern>
	<pattern id="relatedItem">
		<rule context="tei:biblStruct">
			<report test="count(tei:relatedItem[@type='translationOf']) > 1" role="warning">Mehr als ein relatedItem als "translationOf" angegeben [biblStruct_relatedItem_001]</report>
			<report test="count(tei:relatedItem[@type='reviewOf']) > 1" role="warning">Mehr als ein relatedItem als "reviewOf" angegeben [biblStruct_relatedItem_002]</report>
			<report test="count(tei:relatedItem[@type='reprintOf']) > 1" role="warning">Mehr als ein relatedItem als "reprintOf" angegeben [biblStruct_relatedItem_003]</report>
			<report test="count(tei:relatedItem[@type='partOf']) > 1" role="warning">Mehr als ein relatedItem als "partOf" angegeben [biblStruct_relatedItem_004]</report>
		</rule>
	</pattern>
	<pattern id="series">
		<rule context="tei:series">
			<assert test="tei:title" role="error">Obligatorisches Element "title" innerhalb von "series" fehlt [series_001]</assert>
			<assert test="tei:biblScope[@type='vol' or @type='part']" role="error">Obligatorisches Element "biblScope" mit @type="vol" oder @type="part" innerhalb von "series" fehlt [series_002]</assert>
		</rule>
	</pattern>
	<!--  -->
	<!--  -->
	<!-- Prüfungen in verstreuten editor-Elementen -->
	<pattern id="editor">
		<rule context="tei:editor">
			<assert test="tei:persName or tei:orgName" role="error">Weder persName noch Organisation angegeben</assert>
			<assert test="*/tei:surname" role="error">Nachname fehlt</assert>
		</rule>
	</pattern>
	<!-- Prüfungen in verstreuten author-Elementen -->
	<pattern id="author">
		<rule context="tei:author">
			<assert test="*/tei:surname or tei:orgName" role="error">Weder Nachname noch Organisation angegeben</assert>
		</rule>
	</pattern>
	
	<!--  -->
	<!--  -->
	<!-- Typ book -->
	<pattern id="biblStruct_book">
		<rule context="tei:biblStruct[@type='book']">
			<report test="tei:analytic" role="error">Nicht zugelassenes Element "analytic" innerhalb von "biblStruct type='book'" [biblStruct_book_001]</report>
			<assert test="tei:monogr" role="error">Obligatorisches Element "monogr" innerhalb von "biblStruct type='book'" fehlt [biblStruct_book_002]</assert>
		</rule>
	</pattern>
	<pattern id="biblStruct_book_monogr">
		<rule context="tei:biblStruct[@type='book']/tei:monogr">
			<assert test="tei:title[@type='main']" role="error">Haupttitel nicht angegeben [biblStruct_book_monogr_001]</assert>
			<report test="count(tei:title[@type='main']) > 1" role="warning">Mehr als ein Haupttitel angegeben [biblStruct_book_monogr_002]</report>
			<!-- FixMe:<idno type="short_title"> obligatorisch, max 60 Zeichen -->
			<!-- <idno type="short_title"> auch in <analytic> obligatorisch? -->
			<assert test="tei:title[@level='m']" role="error">Level des Titel nicht angegeben [biblStruct_book_monogr_003]</assert>
			<assert test="tei:idno[@type='short_title']" role="error">Kurztitel nicht angegeben [biblStruct_book_monogr_004]</assert>
			<report test="count(tei:idno[@type='short_title']) > 1" role="warning">Mehr als 1 Kurztitel angegeben [biblStruct_book_monogr_005]</report>
			<assert test="tei:editor or tei:author" role="error">Weder Autor noch Herausgeber angegeben [biblStruct_book_monogr_006]</assert>
			<assert test="tei:edition" role="error">Enthält keine Informationen zur Auflage(edition) [biblStruct_book_monogr_007]</assert>
			<assert test="tei:imprint/tei:pubPlace" role="error">Erscheinungsort fehlt (pubPlace) [biblStruct_book_monogr_008]</assert>
			<assert test="tei:imprint/tei:publisher" role="error">Herausgeber fehlt (publisher) [biblStruct_book_monogr_009]</assert>
			<assert test="tei:imprint/tei:date" role="error">Erscheinungsjahr fehlt (date) [biblStruct_book_monogr_010]</assert>
		</rule>
	</pattern>
	<!--  -->
	<!--  -->
	<!-- Typ journalArticle -->
	<pattern id="biblStruct_journalArticle">
		<rule context="tei:biblStruct[@type='journalArticle']">
			<assert test="tei:monogr" role="error">Obligatorisches Element "monogr" innerhalb von "biblStruct type='journalArticle'" fehlt [biblStruct_journalArticle_001]</assert>
			<assert test="tei:analytic" role="error">Obligatorisches Element "journalArticle" innerhalb von "biblStruct type='journalArticle'" fehlt [biblStruct_journalArticle_002]</assert>
		</rule>
	</pattern>
	<pattern id="biblStruct_journalArticle_monogr">
		<rule context="tei:biblStruct[@type='journalArticle']/tei:monogr">
			<assert test="tei:title[@type='main']" role="error">Haupttitel nicht angegeben [biblStruct_journalArticle_monogr_001]</assert>
			<report test="count(tei:title[@type='main']) > 1" role="warning">Mehr als ein Haupttitel angegeben [biblStruct_journalArticle_monogr_002]</report>
			<assert test="tei:title[@level='j']" role="error">Level des Titel nicht angegeben [biblStruct_journalArticle_monogr_003]</assert>
			<assert test="tei:imprint/tei:biblScope[@type='vol']" role="error">Bandangabe fehlt [biblStruct_journalArticle_monogr_004]</assert>
			<assert test="tei:imprint/tei:biblScope[@unit='issue']" role="error">Bandnummer fehlt[biblStruct_journalArticle_monogr_005]</assert>
			<assert test="tei:imprint/tei:biblScope[@type='pp']" role="error">Seitenangabe fehlt [biblStruct_journalArticle_monogr_006]</assert>
			<assert test="tei:imprint/tei:date" role="error">Erscheinungsjahr fehlt [biblStruct_journalArticle_monogr_007]</assert>
		</rule>
	</pattern>
	<pattern id="biblStruct_journalArticle_analytic">
		<rule context="tei:biblStruct[@type='journalArticle']/tei:analytic">
			<assert test="tei:title[@type='main']" role="error">Haupttitel nicht angegeben [biblStruct_journalArticle_analytic_001]</assert>
			<report test="count(tei:title[@type='main']) > 1" role="warning">Mehr als ein Haupttitel angegeben [biblStruct_journalArticle_analytic_002]</report>
			<!-- <idno type="short_title"> auch in <analytic> obligatorisch? -->
			<assert test="tei:idno[@type='short_title']" role="error">Kurztitel nicht angegeben [biblStruct_journalArticle_monogr_003]</assert>
			<assert test="tei:title[@level='a']" role="error">Level des Titel nicht angegeben [biblStruct_journalArticle_analytic_004]</assert>
			<assert test="tei:author" role="error">Autor fehlt [biblStruct_journalArticle_analytic_004]</assert>
		</rule></pattern>
	<!--  -->
	<!--  -->
	<!-- Typ bookSection -->
	<pattern id="biblStruct_bookSection">
		<rule context="tei:biblStruct[@type='bookSection']">
			<assert test="tei:monogr" role="error">Obligatorisches Element "monogr" innerhalb von "biblStruct type='bookSection'" fehlt [biblStruct_bookSection_001]</assert>
			<assert test="tei:analytic" role="error">Obligatorisches Element "journalArticle" innerhalb von "biblStruct type='bookSection'" fehlt [biblStruct_bookSection_002]</assert>
		</rule>
	</pattern>
	<pattern id="biblStruct_bookSection_monogr">
		<rule context="tei:biblStruct[@type='bookSection']/tei:monogr">
			<assert test="tei:title[@type='main']" role="error">Haupttitel nicht angegeben [biblStruct_bookSection_monogr_001]</assert>
			<report test="count(tei:title[@type='main']) > 1" role="warning">Mehr als ein Haupttitel angegeben [biblStruct_bookSection_monogr_002]</report>
			<!-- FixMe:<idno type="short_title"> obligatorisch, max 60 Zeichen -->
			<!-- <idno type="short_title"> auch in <analytic> obligatorisch? -->
			<assert test="tei:title[@level='m']" role="error">Level des Titel nicht angegeben [biblStruct_bookSection_monogr_003]</assert>
			<report test="count(tei:idno[@type='short_title']) > 1" role="warning">Mehr als 1 Kurztitel angegeben [biblStruct_bookSection_monogr_004]</report>
			<assert test="tei:editor or tei:author" role="error">Weder Autor noch Herausgeber angegeben [biblStruct_bookSection_monogr_005]</assert>
			<assert test="tei:edition" role="error">Enthält keine Informationen zur Auflage(edition) [biblStruct_bookSection_monogr_006]</assert>
			<assert test="tei:imprint/tei:pubPlace" role="error">Erscheinungsort fehlt (pubPlace) [biblStruct_bookSection_monogr_007]</assert>
			<assert test="tei:imprint/tei:publisher" role="error">Herausgeber fehlt (publisher) [biblStruct_bookSection_monogr_008]</assert>
			<assert test="tei:imprint/tei:date" role="error">Erscheinungsjahr fehlt (date) [biblStruct_bookSection_monogr_009]</assert>
			<assert test="tei:imprint/tei:biblScope[@type='pp']" role="error">Seitenangabe fehlt [biblStruct_bookSection_monogr_010]</assert>
			<assert test="tei:imprint/tei:biblScope[@type='chap']" role="error">Kapitelangabe fehlt[biblStruct_bookSection_monogr_011]</assert>
		</rule>
	</pattern>
	<pattern id="biblStruct_bookSection_analytic">
		<rule context="tei:biblStruct[@type='bookSection']/tei:analytic">
			<assert test="tei:title[@type='main']" role="error">Haupttitel nicht angegeben [biblStruct_bookSection_analytic_001]</assert>
			<report test="count(tei:title[@type='main']) > 1" role="warning">Mehr als ein Haupttitel angegeben [biblStruct_bookSection_analytic_002]</report>
			<!-- <idno type="short_title"> auch in <analytic> obligatorisch? -->
			<assert test="tei:idno[@type='short_title']" role="error">Kurztitel nicht angegeben [biblStruct_bookSection_monogr_003]</assert>
			<assert test="tei:title[@level='a']" role="error">Level des Titel nicht angegeben [biblStruct_bookSection_analytic_004]</assert>
			<assert test="tei:author" role="error">Autor fehlt [biblStruct_bookSection_analytic_005]</assert>
		</rule></pattern>
	<!--  -->
	<!--  -->
	<!-- Typ webPublication -->
	<pattern id="biblStruct_webPublication">
		<rule context="tei:biblStruct[@type='webPublication']">
			<assert test="tei:monogr" role="error">Obligatorisches Element "monogr" innerhalb von "biblStruct type='webPublication'" fehlt [biblStruct_webPublication_001]</assert>
		</rule>
	</pattern>
	<pattern id="biblStruct_webPublication_monogr">
		<rule context="tei:biblStruct[@type='webPublication']/tei:monogr">
			<assert test="tei:title[@type='main']" role="error">Haupttitel nicht angegeben [biblStruct_webPublication_monogr_001]</assert>
			<report test="count(tei:title[@type='main']) > 1" role="warning">Mehr als ein Haupttitel angegeben [biblStruct_webPublication_monogr_002]</report>
			<assert test="tei:title[@level='m']" role="error">Level des Titel nicht angegeben [biblStruct_webPublication_monogr_003]</assert>
			<!-- <idno type="short_title"> auch in <analytic> obligatorisch? -->
			<assert test="tei:idno[@type='URL']" role="error">URL nicht angegeben [biblStruct_webPublication_monogr_005]</assert>
			<assert test="tei:imprint/tei:date[@type='posting']" role="error">Erstellungsdatum der Webressource [biblStruct_webPublication_monogr_006]</assert>
			<assert test="tei:imprint/tei:date[@type='access']" role="error">Datum des letzten Zugriffs auf die Webressource fehlt [biblStruct_webPublication_monogr_007]</assert>
			</rule>
	</pattern>
	<!--Wenn analytic vorhanden-->
	<!--<pattern id="biblStruct_webPublication_analytic">
		<rule context="tei:biblStruct[@type='webPublication']/tei:analytic">
			<assert test="tei:title[@type='main']" role="warning">Haupttitel nicht angegeben [biblStruct_webPublication_analytic_001]</assert>
			<report test="count(tei:title[@type='main']) > 1" role="warning">Mehr als ein Haupttitel angegeben [biblStruct_webPublication_analytic_002]</report>
			<assert test="tei:idno[@type='short_title']" role="error">Kurztitel nicht angegeben [biblStruct_webPublication_analytic_003]</assert>
			<assert test="tei:title[@level='a']" role="warning">Level des Titel nicht angegeben [biblStruct_webPublication_analytic_004]</assert>
			<assert test="tei:author" role="warning">Autor fehlt [biblStruct_webPublication_analytic_004]</assert>
		</rule></pattern>-->
	</schema>
