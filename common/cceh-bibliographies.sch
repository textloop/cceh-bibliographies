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
			<assert test="tei:idno[@type='short_title']" role="error">Kurztitel nicht angegeben [biblStruct_book_monogr_003]</assert>
			<report test="count(tei:idno[@type='short_title']) > 1" role="warning">Mehr als 1 Kurztitel angegeben [biblStruct_book_monogr_004]</report>
			<assert test="tei:editor or tei:author" role="error">Weder Autor noch Herausgeber angegeben</assert>
			<assert test="tei:edition" role="error">Enthält keine Informationen zur Auflage(edition)</assert>
			<assert test="tei:imprint/tei:pubPlace" role="error">Erscheinungsort fehlt (pubPlace)</assert>
			<assert test="tei:imprint/tei:publisher" role="error">Herausgeber fehlt (publisher)</assert>
			<assert test="tei:imprint/tei:date" role="error">Erscheinungsjahr fehlt (date)</assert>
		</rule>
	</pattern>
</schema>
