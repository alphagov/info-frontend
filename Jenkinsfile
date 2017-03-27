#!/usr/bin/env groovy

node {
  def govuk = load '/var/lib/jenkins/groovy_scripts/govuk_jenkinslib.groovy'
  // 'false' parameter prevents the SASS from being linted
  govuk.buildProject(false)
}
