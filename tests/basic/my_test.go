package basic

import (
	"testing"

	"github.com/fanovilla/terraform-unit-testing/tut"
	"github.com/jmespath/go-jmespath"
	"github.com/stretchr/testify/assert"
)

func TestJmespath(t *testing.T) {
	plan := tut.Plan(t)

	alertresults, _ := jmespath.Search("resource_changes[?type=='newrelic_nrql_alert_condition']", plan.Plan)
	assert.Len(t, alertresults, 4)

	alertpolicy, _ := jmespath.Search("resource_changes[?type=='newrelic_alert_policy']", plan.Plan)
	assert.Len(t, alertpolicy, 1)

	alertchannel, _ := jmespath.Search("resource_changes[?type=='newrelic_alert_channel']", plan.Plan)
	assert.Len(t, alertchannel, 1)

	plan.AssertResourceCounts(t, map[string]int{
		"newrelic_nrql_alert_condition": 4,
		"newrelic_alert_policy":         1,
		"newrelic_alert_channel":        1,
	})

}
