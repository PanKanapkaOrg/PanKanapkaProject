import React, { Component } from "react";
import GetClientFirms from "../services/api/GetClientFirms";
import GetWorkers from "../services/api/GetWorkers";
import CircularSpinnerLoading from "../CircularSpinnerLoading";


import "./Firm.css";

export default class Home extends Component {
    constructor(props) {
        super(props);

        this.state = {
            isLoading: true,
            ClientFirms: [],
            Workers: [],
        };
    }

    componentDidMount() {
        GetClientFirms(this.props)
                .then(firms => this.setState({ClientFirms:firms}));
        GetWorkers(this.props)
                .then(workers =>{
                    window.setTimeout(() => this.setState({Workers:workers, isLoading:false}), 1500);
            });
    }

    render() {
        if(this.state.isLoading)
        {
            return <div className="lander"><CircularSpinnerLoading /> </div>
        }
        else {
           return (
            <div className="Home">
                <div className="lander">
                    <img src={this.props.logoUrl} alt="logo"></img>
                    <h1>    {this.props.cateringFirmName}  </h1>
                    <img src={this.props.logoUrl} alt="logo"></img>
                    <p>{this.props.cateringFirmAddress}</p>
                    <p>{this.props.cateringFirmInfo}</p>
                    <div>

                        <table className="striped">
                            <thead>
                                <tr><th><h5>Firmy, z którymi współpracujesz</h5></th></tr>
                                <tr>
                                    <th>Nazwa firmy</th>
                                    <th>Adres firmy</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    this.state.ClientFirms.map((ClientFirms) =>
                                        <tr>
                                            <td>
                                                <p key={ClientFirms.id}>{ClientFirms.name}</p>
                                            </td>
                                            <td>
                                                <p key={ClientFirms.id}>{ClientFirms.address}</p>
                                            </td>
                                        </tr>
                                    )
                                }
                            </tbody>

                        </table>
                        <table className="striped">

                            <thead>
                                <tr><th><h5>Twoi pracownicy</h5></th></tr>
                                <tr>
                                    <th>Imie</th>
                                    <th>Nazwisko</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    this.state.Workers.map((Workers, i) =>
                                        <tr>
                                            <td>
                                                <p key={Workers.id}>{Workers.name}</p>
                                            </td>
                                            <td>
                                                <p key={Workers.id}>{Workers.surname}</p>
                                            </td>
                                        </tr>
                                    )
                                }

                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        )
        
    }
}
}