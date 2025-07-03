OWNER=brandymint
REPO=helm-charts

deps:
	brew tap helm/tap
	brew install chart-releaser

package:
	cr package charts/ror

upload:
	cr upload --owner ${OWNER} --git-repo ${REPO} --packages-with-index --token ${TOKEN} --push --skip-existing

index:
	cr index --owner ${OWNER} --git-repo ${REPO} --packages-with-index --index-path . --token ${TOKEN} --push
