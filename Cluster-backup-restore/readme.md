## Backup

Cluster:
Map with [group/version/kind]
Cluster Scope
Namespace Scope
Preferred Version for Restore: **Restore cluster must exist this version crds**
Cluster Scope
Namespace Scope
Application:
`--include-resources=deployments, pods, PVC, PV, config maps, secrets, services` 
this flag is to ensure the users require yamls to take backup. 



Namespace:
`--include-resources=deployments, pods, PVC, PV, config maps, secrets, services` 
this flag is to ensure the users require yamls to take backup. 


Group/Version/Kind:
`--include-resources=deployments, pods, PVC, PV, config maps, secrets, services` 
this flag is to ensure the users require yamls to take backup. 


Restore
Always restore CRDs first.
Namespaces
Cluster-scope resources
Only restore the PV/PVC resources, data will be restored using another addon
`--include-resources` Resources to include in the restore
``
`--resourcePririty`: This flag will ensure the priority of restoring resources.

Note: Can we handle PV/PVC differently? 
