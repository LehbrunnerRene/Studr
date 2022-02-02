import { Component, OnInit } from '@angular/core';
import { CrudService } from '../crud.service';
import { Information } from '../model/information';

@Component({
  selector: 'app-information',
  templateUrl: './information.component.html',
  styleUrls: ['./information.component.css'],
})
export class InformationComponent implements OnInit {
  public info: Information;
  private help: any;
  hide: boolean = true;

  constructor(public crudservice: CrudService) {}

  ngOnInit(): void {
    this.crudservice.allInformation().subscribe((data) => {
      this.help = data.map((e) => {
        return {
          id: e.payload.doc.id,
          city: e.payload.doc.data()['address']['city'],
          postalCode: e.payload.doc.data()['address']['postal code'],
          street: e.payload.doc.data()['address']['street'],
          email: e.payload.doc.data()['email'],
          hId: e.payload.doc.data()['hId'],
          openingTimes: e.payload.doc.data()['opening times'],
          phoneNumber: e.payload.doc.data()['phone number'],
          priceSegment: e.payload.doc.data()['price segment'],
        };
      });
      this.info = new Information(
        this.help[0].id,
        this.help[0].city,
        this.help[0].postalCode,
        this.help[0].street,
        this.help[0].hId,
        this.help[0].openingTimes,
        this.help[0].phoneNumber,
        this.help[0].priceSegment,
        this.help[0].email
      );
    });
  }

  updateInfo() {
    let informationDTO = {
      address: {
        city: this.info.city,
        'postal code': this.info.postalCode,
        street: this.info.street,
      },
      email: this.info.email,
      hId: this.info.hId,
      'opening times': this.info.openingTimes,
      'phone number': this.info.phoneNumber,
      'price segment': this.info.priceSegment,
      rating: 3,
    };
    this.crudservice.updateInformation(informationDTO);
  }
  changeVisability() {
    this.hide = this.hide ? false : true;
  }
}
