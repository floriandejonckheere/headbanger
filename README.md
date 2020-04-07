# Headbanger

Headbanger is a music recommendation and discovery platform.

## Releasing

Update the changelog and bump the version in `lib/headbanger/version.rb`.
Create a tag for the version and push it to Github.
A Docker image will automatically be built and pushed to the registry.

```
git add lib/headbanger/version.rb
git commit -m "Bump version to v1.0.0"
git tag v1.0.0
git push origin master
git push origin v1.0.0
```
