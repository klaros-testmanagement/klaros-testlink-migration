<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns="http://klaros-testmanagement.com/export-testcases-1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

   <xsl:output method="xml" version="1.0" encoding="UTF-8"
      omit-xml-declaration="no" indent="yes"/>

  <xsl:template match="/">
    <xsl:element name="container">
      <xsl:element name="testcases">
        <xsl:apply-templates />
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="//testsuite">
      <xsl:apply-templates select="//testcase" />
  </xsl:template>

  <xsl:template match="//testcase">
    <xsl:if test="active/text() = '1'">
      <xsl:element name="testcase">
        <xsl:element name="shortname">
          <xsl:value-of select="@name" />
        </xsl:element>
        <xsl:apply-templates />
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="estimated_exec_duration">
    <xsl:element name="estimatedDuration">
      <xsl:value-of select="text() * 60000" />
    </xsl:element>
  </xsl:template>

  <xsl:template match="preconditions">
    <xsl:element name="precondition">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="summary">
    <xsl:element name="description">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="execution_type">
    <xsl:element name="execution">
      <xsl:choose>
        <xsl:when test="text() = '1'">
          <xsl:text>MANUAL</xsl:text>
        </xsl:when>
        <xsl:when test="text() = '2'">
          <xsl:text>AUTO</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <xsl:template match="importance">
    <xsl:element name="priority">
      <xsl:choose>
        <xsl:when test="text() = '1'">
          <xsl:text>LOW</xsl:text>
        </xsl:when>
        <xsl:when test="text() = '2'">
          <xsl:text>MEDIUM</xsl:text>
        </xsl:when>
        <xsl:when test="text() = '3'">
          <xsl:text>HIGH</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <xsl:template match="status">
    <xsl:element name="state">
      <xsl:choose>
        <xsl:when test="text() = '7'">
          <xsl:text>APPROVED</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>NEW</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <xsl:template match="steps">
    <xsl:element name="steps">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="step">
    <xsl:element name="step">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="actions">
    <xsl:element name="description">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="expectedresults">
    <xsl:element name="expectedResult">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="custom_fields">
    <xsl:element name="attributes">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="custom_field">
    <xsl:element name="attribute">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="node_order|externalid|version|active|is_open|step_number|step/execution_type" />
  
  <xsl:template match="node()|@*|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
