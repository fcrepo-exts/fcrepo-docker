# exit when any command fails:
set -e

context="$1"

if [ -z "$context" ]
then
    context="."
fi

# Use maven to get the artifact either from the local maven repository or from Sonatype
mvn dependency:copy -Dartifact=org.fcrepo:fcrepo-webapp:$VERSION:war -DoutputDirectory="$context" -Dmdep.stripVersion=true

docker build --tag fcrepo/fcrepo "$context"
