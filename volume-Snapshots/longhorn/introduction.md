# Volume Snapshots
***
## Introduction:
***
- ### VolumeSnapshotContent:
  - VolumeSnapshotContents are resources in the cluster
  - Is a snapshot taken from a volume in the cluster.It is a resource in the cluster just like a PersistentVolume.
- ### VolumeSnapshot:
  - Is a request for snapshot of a volume by a user. It is similar to a PersistentVolumeClaim.
  - Volume snapshots provide Kubernetes users with a standardized way to copy a volume's contents at a particular point in time without creating an entirely new volume.
  - VolumeSnapshots are requests for VolumeSnapshotContents
- ### VolumeSnapshotClass:
  - It’s allows you to specify different attributes belonging to a VolumeSnapshot
- ### Deployment process of VolumeSnapshot:
  - snapshot controller and a sidecar helper container called csi-snapshotter to be deployed.into the control plane.
  - snapshot controller watches VolumeSnapshot and VolumeSnapshotContent objects and is responsible for the creation and deletion of VolumeSnapshotContent object.
  - sidecar csi-snapshotter watches VolumeSnapshotContent objects and triggers CreateSnapshot and DeleteSnapshot operations against a CSI endpoint.
- ### Lifecycle of a volume snapshot and volume snapshot content:
    - two ways snapshots may be provisioned:
        - #### pre-provisioned:
          - cluster administrator creates a number of VolumeSnapshotContents
          - They carry the details of the real volume snapshot on the storage system which is available for use by cluster users.
        - #### dynamically provisioned:
          - Instead of using a pre-existing snapshot, you can request that a snapshot to be dynamically taken from a PersistentVolumeClaim.
    - #### Binding:
      - controller handles the binding of a VolumeSnapshot object with an appropriate VolumeSnapshotContent object
      - binding is a one-to-one mapping.
      - In the case of pre-provisioned binding, the VolumeSnapshot will remain unbound until the requested VolumeSnapshotContent object is created.
    - #### Delete:
      - Deletion is triggered by deleting the VolumeSnapshot object, and the DeletionPolicy will be followed.
      - If the DeletionPolicy is Delete, then the underlying storage snapshot will be deleted along with the VolumeSnapshotContent object.
      - If the DeletionPolicy is Retain, then both the underlying snapshot and VolumeSnapshotContent remain. 

