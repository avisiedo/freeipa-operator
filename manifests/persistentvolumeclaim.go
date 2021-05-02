package helper

import (
	"github.com/freeipa/freeipa-operator/api/v1alpha1"
	corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// IsEmpty Check when a ResourceRequirements is empty.
func IsResourceRequirementsEmpty(r *corev1.ResourceRequirements) bool {
	return r == nil
}

func IsPersistentVolumeClaimSpecEmpty(pvc *corev1.PersistentVolumeClaimSpec) bool {
	if pvc == nil {
		return true
	}
	if len(pvc.AccessModes) != 0 {
		return false
	}
	if pvc.Selector != nil {
		return false
	}
	if !IsResourceRequirementsEmpty(&pvc.Resources) {
		return false
	}
	if pvc.VolumeName != "" {
		return false
	}
	if pvc.StorageClassName != nil {
		return false
	}
	if pvc.VolumeMode != nil {
		return false
	}
	if pvc.DataSource != nil {
		return false
	}
	return true
}

func MainPersistentVolumeClaimForIDM(m *v1alpha1.IDM) *corev1.PersistentVolumeClaim {
	if m.Spec.VolumeClaimTemplate == nil {
		return nil
	}
	var pvc = &corev1.PersistentVolumeClaim{
		ObjectMeta: metav1.ObjectMeta{
			Name:      GetMainPersistentVolumeClaimName(m),
			Namespace: m.Namespace,
			Labels:    LabelsForIDM(m),
		},
		Spec: corev1.PersistentVolumeClaimSpec{
			AccessModes:      m.Spec.VolumeClaimTemplate.AccessModes,
			DataSource:       m.Spec.VolumeClaimTemplate.DataSource,
			Resources:        m.Spec.VolumeClaimTemplate.Resources,
			StorageClassName: m.Spec.VolumeClaimTemplate.StorageClassName,
			VolumeMode:       m.Spec.VolumeClaimTemplate.VolumeMode,
			VolumeName:       m.Spec.VolumeClaimTemplate.VolumeName,
		},
	}
	return pvc
}
