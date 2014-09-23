<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version = '1.0'
    xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
     >

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />

<xsl:param name="fortune.id"></xsl:param>

<!-- The purpose of this function is to recursively copy elements without a
namespace-->
<xsl:template mode="copy-html-ns" match="*">
    <xsl:element xmlns="http://www.w3.org/1999/xhtml" name="{local-name()}">
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates mode="copy-html-ns"/>
    </xsl:element>
</xsl:template>

<xsl:template name="copy_html_ns_by_name">
    <xsl:element xmlns="http://www.w3.org/1999/xhtml" name="{local-name()}">
            <xsl:copy-of select="@*" />
            <xsl:call-template name="copy_html_ns_by_name" />
    </xsl:element>
</xsl:template>
<xsl:template match="@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
</xsl:template>

<xsl:template match="/myxml">
    <facts>
        <head />
        <xsl:apply-templates />
    </facts>
</xsl:template>

<xsl:template match="l">
    <l>
        <xsl:copy-of select="@*"/>
        <body>
            <xsl:apply-templates select="*" />
        </body>
    </l>
</xsl:template>

<xsl:template match="tt">
    <xsl:apply-templates select="*" />
</xsl:template>

<xsl:template match="lip">
    <li>
        <p>
            <xsl:apply-templates select="*" />
        </p>
    </li>
</xsl:template>

</xsl:stylesheet>
