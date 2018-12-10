import React, { Component } from "react";
import GetTasks from "../services/api/GetTasks";
import GetClientFirms from "../services/api/GetClientFirms";
import GetWorkers from "../services/api/GetWorkers";
import CircularSpinnerLoading from "../CircularSpinnerLoading";
import Modal from 'react-modal';

//Modal.setAppElement('#modal1')

export default class Plans extends Component {
    constructor(props) {
        super(props);

        this.state = {
            isLoading: true,
            ClientFirms: [],
            Workers: [],
            Tasks: []
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
                    DaysBefore: 0,
                    DaysAfter: 6
                }

                GetTasks(taskFilter)
                    .then(tasks => {
                        window.setTimeout(() => this.setState({ Tasks: tasks.data, Workers: workers, isLoading: false }), 1500);
                    });
            });




    }

    render() {
        if (this.state.isLoading) {
            return <CircularSpinnerLoading />
        }
        else {
            console.log("Tasks is = ", Array.isArray(this.state.Tasks));
            if (Array.isArray(this.state.Tasks)) {
                console.log(this.state.ClientFirms);
                console.log(this.state.Tasks);
            }
            return (
                <div className="Home">
                    <div className="lander">
                        <h1>Plany dla pracowników</h1><br></br>
                        <Modal
          isOpen={true}
          contentLabel="Example Modal">
          <h1>Modal</h1>
        </Modal>
                        <table className="highlight centered">
                            <thead>
                                <tr>
                                    <th>Pracownik</th>
                                    {
                                        this.state.Tasks[0].taskItems.map((item) =>
                                            <th>
                                                {item.date.substring(0, 10)}
                                            </th>
                                        )
                                    }
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    this.state.Tasks.map((task) =>
                                        <tr>

                                            <td>
                                                {task.worker.name} {task.worker.surname}
                                            </td>
                                            {
                                                task.taskItems.map((taskItem) =>
                                                    <td>
                                                        <ul>

                                                            {taskItem.firms.map((firm) =>
                                                                <li>{firm.name}</li>
                                                            )}
                                                        </ul>
                                                    </td>
                                                )
                                            }
                                        </tr>
                                    )
                                }
                            </tbody>

                        </table>

                                 <div id="modal1" className="modal">
    <div className="modal-content">
      <h4>Modal Header</h4>
      <p>A bunch of text</p>
    </div>
    <div className="modal-footer">
      <a href="#!" className="modal-close waves-effect waves-green btn-flat">Agree</a>
    </div>
  </div>

                    </div>
                </div>
            );
        }
    }
}