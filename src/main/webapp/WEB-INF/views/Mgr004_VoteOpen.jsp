<!DOCTYPE html>
<html lang="en">

<head>
    <title>voteSearchMgr</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://www.markuptag.com/bootstrap/5/css/bootstrap.min.css">


    <style>
        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;

            height: 100px;
            background-color: white;

        }

        main {
            background-color: hsl(228, 26%, 96%);
            min-height: 1000px;
            margin-top: 100px;

        }

        footer {
            position: absolute;
            background-color: white;
            bottom: 0;
            width: 100%;
            height: 60px;

        }
    </style>
</head>

<body>

    <header class="fixed-top" style="border-bottom: 1px solid hsl(0, 0%, 56%);">
        <img src="/resources/img/Logo.png" style="height: 100px; border-bottom: 1px solid hsl(0, 0%, 56%);">

    </header>

    <main>

        <div class="container">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <div class="login-form bg-white mt-4 p-4 rounded">
                        <form action="" method="" class="row g-3">
                            <span style="font-size: 30px;">투표 개설 및 수정</span>


                            <hr class="mt-4">



                            <div class="mb-3 rounded" style="background-color: hsl(228, 26%, 96%);
                            padding-top: 10px; padding-bottom: 60px;">

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">

                                    <a href="#"><button class="btn btn-primary" type="button" style="margin-bottom: 30px">투표 추가</button></a>
                                </div>


                                <table class="table table-bordered border-white-50 " style="text-align: center;">
                                    <thead>
                                        <tr>
                                            <th class="rounded-start" scope="col"
                                                style="background-color:hsl(0, 0%, 41%) ; color: white;">선거이름</th>
                                            <th class="rounded-end" scope="col"
                                                style="background-color:hsl(0, 0%, 41%); color: white;">시작날짜</th>
                                            <th class="rounded-start" scope="col"
                                                style="background-color:hsl(0, 0%, 41%) ; color: white;">종료날짜</th>
                                            <th class="rounded-end" scope="col"
                                                style="background-color:hsl(0, 0%, 41%); color: white;">투표수정</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="background-color: white;">웹트랙회장선거</td>
                                            <td style="background-color: white;">22/07/31 10:00</td>
                                            <td style="background-color: white;">22/08/02 23:00</td>
                                            <td style="background-color: white;"><button type="button"
                                                    class="btn btn-outline-primary btn-sm">수정</button></td>

                                        </tr>

                                    </tbody>
                                </table>


                        </form>

                    </div>
                </div>
            </div>
        </div>


    </main>

    <div class="fixed-bottom">
        <footer>
            <div>
                <p style="text-align:center; color: hsl(0, 0%, 34%); padding: 1rem;">@2022 Team Coding Quokka All Rights
                    Reserved</p>
            </div>
        </footer>
    </div>
</body>