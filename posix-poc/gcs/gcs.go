package gcs

import (
	"cloud.google.com/go/storage"
	"context"
	"fmt"
	"google.golang.org/api/option"
	"io"
	"log"
	"os"
	"time"

	"gocloud.dev/blob"
	_ "gocloud.dev/blob/gcsblob"

	_ "gocloud.dev/blob/s3blob"
)

const (
	bucket         = "appscode-testing"
	credentialPath = "/home/anisur/GCS_CREDENTIAL/GOOGLE_SERVICE_ACCOUNT_JSON_KEY"
)

func Gcs() {
	ctx := context.Background()
	//client, err := storage.NewClient(ctx, option.WithCredentialsFile(credentialPath))
	//if err != nil {
	//	log.Fatal(err)
	//}
	blobfile := "ishtiaq/metadata.yaml"
	myfile := "sunny/s3cptestdir/s3cptest.txt"
	solrFile := "sunny-gui/kubedb-backup1/kubedb-system/backup_0.properties"
	_ = blobfile
	_ = myfile
	_ = solrFile

	//_, err := getMetadata(os.Stdout, bucket, solrFile)
	//if err != nil {
	//	log.Fatal(err)
	//}

	//deleteACL(bucket, myfile, "user-anisur@appscode.com")

	//if err := uploadFileWithACL(bucket, "./s3cptestdir/s3cptest.txt", "from-code/s3cptest.txt"); err != nil {
	//	log.Fatal(err)
	//}

	//uploadFile(bucket, "./s3cptestdir/s3cptest.txt", "from-code/")

	//b, err := blob.OpenBucket(ctx, "gs://appscode-testing")
	b, err := blob.OpenBucket(ctx, "s3://kubedb?region=us-east-1")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error opening bucket: %v\n", err)
	}
	defer b.Close()

	w, err := b.NewWriter(ctx, "from-code/", nil)
	if err != nil {
		log.Fatalf(err.Error())
	}

	_, writeErr := w.Write([]byte(""))
	//_, writeErr := fmt.Fprintln(w, "")
	// Always check the return value of Close when writing.
	closeErr := w.Close()
	if writeErr != nil {
		log.Fatal(writeErr)
	}
	if closeErr != nil {
		log.Fatal(closeErr)
	}
	fmt.Println("------------___Written Successfully-----------")
}

func uploadFileWithACL(bucket, filePath string, objName string) error {
	ctx := context.Background()
	client, err := storage.NewClient(ctx, option.WithCredentialsFile(credentialPath))
	if err != nil {
		return fmt.Errorf("storage.NewClient: %w", err)
	}
	defer client.Close()

	ctx, cancel := context.WithTimeout(ctx, time.Second*10)
	defer cancel()

	acls := []storage.ACLRule{
		{
			Entity: storage.ACLEntity("project-owners-176319405093"),
			Role:   storage.RoleOwner,
			ProjectTeam: &storage.ProjectTeam{
				ProjectNumber: "176319405093",
				Team:          "owners",
			},
		},
		{Entity: storage.ACLEntity("project-editors-176319405093"),
			Role: storage.RoleOwner,
			ProjectTeam: &storage.ProjectTeam{
				ProjectNumber: "176319405093",
				Team:          "editors",
			},
		},
		{
			Entity: storage.ACLEntity("project-viewers-176319405093"),
			Role:   storage.RoleReader,
			ProjectTeam: &storage.ProjectTeam{
				ProjectNumber: "176319405093",
				Team:          "viewers",
			},
		},
		{
			Entity: storage.ACLEntity("user-anisur@appscode-testing.iam.gserviceaccount.com"),
			Email:  "anisur@appscode-testing.iam.gserviceaccount.com",
			Role:   storage.RoleOwner,
		},
	}

	// Open the file to upload.
	f, err := os.Open(filePath)
	if err != nil {
		log.Fatalf("Failed to open file: %v", err)
	}
	defer f.Close()

	// Create the writer with custom ACLs.
	wc := client.Bucket(bucket).Object(objName).NewWriter(ctx)
	wc.ACL = acls

	// Upload the file to Google Cloud Storage.
	if _, err := io.Copy(wc, f); err != nil {
		log.Fatalf("Failed to write object: %v", err)
	}

	// Close the writer to complete the upload.
	if err := wc.Close(); err != nil {
		log.Fatalf("Failed to close object writer: %v", err)
	}

	fmt.Printf("File %v uploaded to bucket %v with custom ACLs.\n", objName, bucket)
	return nil
}

func deleteACL(bucket, object string, entity string) {
	ctx := context.Background()
	client, err := storage.NewClient(ctx, option.WithCredentialsFile(credentialPath))
	if err != nil {
		log.Fatalf("storage.NewClient: %w", err)
	}
	defer client.Close()

	ctx, cancel := context.WithTimeout(ctx, time.Second*10)
	defer cancel()

	obj := client.Bucket(bucket).Object(object)

	// Get the current ACL.
	acl, err := obj.ACL().List(ctx)
	if err != nil {
		log.Fatalf("Failed to list ACLs: %v", err)
	}

	// Find and delete the specific ACL entry.
	for _, r := range acl {
		if string(r.Entity) == entity {
			err := obj.ACL().Delete(ctx, storage.ACLEntity(entity))
			if err != nil {
				log.Fatalf("Failed to delete ACL entry: %v", err)
			}
			fmt.Printf("Deleted ACL entry for %s\n", entity)
		}
	}
}

func getMetadata(w io.Writer, bucket, object string) (*storage.ObjectAttrs, error) {
	// bucket := "bucket-name"
	// object := "object-name"
	ctx := context.Background()
	client, err := storage.NewClient(ctx, option.WithCredentialsFile(credentialPath))
	if err != nil {
		return nil, fmt.Errorf("storage.NewClient: %w", err)
	}
	defer client.Close()

	ctx, cancel := context.WithTimeout(ctx, time.Second*10)
	defer cancel()

	o := client.Bucket(bucket).Object(object)
	attrs, err := o.Attrs(ctx)
	if err != nil {
		return nil, fmt.Errorf("Object(%q).Attrs: %w", object, err)
	}
	fmt.Fprintf(w, "\n\nMetadata\n")
	for key, value := range attrs.Metadata {
		fmt.Fprintln(w, "\t%v = %v\n", key, value)
	}
	fmt.Fprintf(w, "\n\nACL\n")
	for _, acl := range attrs.ACL {
		fmt.Fprintln(w, "\tACL\n", acl)
	}

	return attrs, nil
}

func uploadFile(bucketName, filePath string, objectName string) {
	ctx := context.Background()
	client, err := storage.NewClient(ctx, option.WithCredentialsFile(credentialPath))
	if err != nil {
		log.Fatalf("storage.NewClient: %w", err)
	}
	defer client.Close()

	ctx, cancel := context.WithTimeout(ctx, time.Second*10)
	defer cancel()

	// Open the file to upload.
	f, err := os.Open(filePath)
	if err != nil {
		log.Fatalf("Failed to open file: %v", err)
	}
	defer f.Close()

	// Define custom metadata for the object.
	//attrs := map[string]string{
	//	"gid":  "1001",
	//	"uid":  "1001",
	//	"mode": "0777",
	//}

	// Upload the file to GCS with custom metadata.
	obj := client.Bucket(bucketName).Object(objectName)

	wc := obj.NewWriter(ctx)
	//wc.PredefinedACL = "bucketownerfullcontrol"
	//wc.ContentType = "text/plain"
	//wc.Metadata = attrs // Set custom metadata
	//wc.ACL, err = client.Bucket(bucket).ACL().List(ctx)
	//if err != nil {
	//	log.Fatalf("Failed to list ACLs: %v", err)
	//}
	//wc.ForceEmptyContentType = true
	//wc.ContentType = "application/x-www-form-urlencoded;charset=UTF-8"

	_, err = wc.Write([]byte(""))
	if err != nil {
		log.Fatalf("Fail")
	}

	// Upload the file to Google Cloud Storage.
	//if _, err := io.Copy(wc, f); err != nil {
	//	log.Fatalf("Failed to write object: %v", err)
	//}

	if err := wc.Close(); err != nil {
		log.Fatalf("Failed to close object writer: %v", err)
	}
	fmt.Printf("File %v uploaded to bucket %v with custom metadata.\n", objectName, bucketName)

}
