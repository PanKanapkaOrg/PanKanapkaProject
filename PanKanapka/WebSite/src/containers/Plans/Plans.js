import React, { Component } from "react";
import GetTasks from "../services/api/GetTasks";
import GetClientFirms from "../services/api/GetClientFirms";
import GetWorkers from "../services/api/GetWorkers";
import CircularSpinnerLoading from "../CircularSpinnerLoading";

export default class Plans extends Component {
    constructor(props) {
        super(props);

        this.state = {
            isLoading: true,
            ClientFirms: [],
            Workers: []
        };
    }


    componentDidMount() {

        GetClientFirms(this.props)
           .then(firms => this.setState({ ClientFirms: firms }));
        GetWorkers(this.props)
            .then(workers => {
                var taskFilter = {
                    WorkerIds: workers.map(w => w.id),
                    Date: "2018-10-27",
                    DaysBefore: 3,
                    DaysAfter: 3
                }

                GetTasks(taskFilter)
                    .then(tasks => {
                        window.setTimeout(() => this.setState({ Tasks: tasks, Workers: workers, isLoading: false }), 1500);
                    });
            });




    }

    render() {
        if (this.state.isLoading) {
            return <CircularSpinnerLoading />
        }
        else {
            return (
                <div className="Home">
                    <div className="lander">
                        <h1>Plany dla pracowników</h1>
                        <p>Lista</p>
                    </div>
                </div>
            );
        }
    }
}