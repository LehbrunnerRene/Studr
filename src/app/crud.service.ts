import { Injectable } from '@angular/core';
import { AngularFirestore } from '@angular/fire/firestore';
import { Information } from './model/information';

@Injectable({
  providedIn: 'root',
})
export class CrudService {
  constructor(public fireservices: AngularFirestore) {}

  allInformation() {
    return this.fireservices
      .collection('Hairdresser/5IQWZYUyMCjNxFdM07lE/Information')
      .snapshotChanges();
  }

  updateInformation(info) {
    this.fireservices
      .doc('Hairdresser/5IQWZYUyMCjNxFdM07lE/Information/WD6lSwspudheVaP3IqrZ')
      .update(info);
  }
}
