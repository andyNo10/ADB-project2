<?php

namespace App\Http\Controllers;

use App\Repository\ClassroomRepo;
use App\Repository\ClassroomStatusRepo;
use App\Repository\MemberRepo;
use App\Repository\AdminRepo;
use App\Repository\RentPeriodRepo;
use Illuminate\Support\Facades\Request;
use App\Repository\RentRecordRepo;
use Illuminate\Support\Facades\Auth;



class RentRecordController extends Controller
{
    //
    public function show(){

        $user = Auth::user();
        $member = MemberRepo::getMemberByUserID($user->id);

        $classroomList = ClassroomRepo::getAllClassroom();
        $periodList = RentPeriodRepo::getAllPeriod();

        $totalRentRecords = RentRecordRepo::getPaginateRentRecordbymemID($member->memID);

        return view('members.memberDashboard',  compact('totalRentRecords','classroomList', 'periodList'));
    }

    public function adminShow(){

        $user = Auth::user();
        $admin = AdminRepo::getAdminByUserID($user->id);
        $totalRentRecords = RentRecordRepo::getPaginateAllRentRecord();

        return view('admin.adminDashboard',  compact('totalRentRecords', 'admin'));
    }

    public function create(){
        $request = Request::all();

        $user = Auth::user();
        $member = MemberRepo::getMemberByUserID($user->id);

        $rentDate = $request['rentDate'];
        $roomID = $request['rentRoomID'];
        $rentPeriodID = $request['rentPeriodID'];
        if(array_key_exists("sleep",$request)){
            $sleep = $request['sleep'];
        }else {
            $sleep = 'off';
        }


        $classroomReservedStatus = RentRecordRepo::createRentRecordbymemID($member->memID, $roomID, $rentPeriodID, $rentDate, $sleep);

        if($classroomReservedStatus == 'SUCCESS'){
            session()->flash('success', '預約完成');
        }else {
            session()->flash('errors', '此時段已被預約');
        }
        return redirect('/memdashboard');
    }

    public function updateRentRecordbyDate()
    {

        $updated = RentRecordRepo::updateRentRecordbyDate();

        if ($updated) {
            session()->flash('success', '更新完成');
        } else {
            session()->flash('errors', '錯誤發生');
        }

        return redirect('/admindashboard');
    }
    public function cancelReservation(){
        $request = Request::all();

        $user = Auth::user();
        $member = MemberRepo::getMemberByUserID($user->id);


        $rentDate = $request['rentDate'];
        $roomID = $request['rentRoomID'];
        $rentPeriodID = $request['rentPeriodID'];

        RentRecordRepo::cancelReservation($member->memID, $roomID, $rentPeriodID, $rentDate);

        return redirect()->back();

    }

    public function testSharedLockTransaction(){
        $request = Request::all();

        $user = Auth::user();
        $member = MemberRepo::getMemberByUserID($user->id);

        $rentDate = $request['rentDate'];
        $roomID = $request['rentRoomID'];
        $rentPeriodID = $request['rentPeriodID'];
        if(array_key_exists("sleep",$request)){
            $sleep = $request['sleep'];
        }else {
            $sleep = 'off';
        }


        $classroomReservedStatus = RentRecordRepo::testSharedLockRentRecordbymemID($member->memID, $roomID, $rentPeriodID, $rentDate, $sleep);

        if($classroomReservedStatus == 'SUCCESS'){
            session()->flash('success', '預約完成');
        }else {
            session()->flash('errors', '此時段已被預約');
        }
        return redirect('/memdashboard');
    }

    public function testNoTransactionAndLock(){
        $request = Request::all();

        $user = Auth::user();
        $member = MemberRepo::getMemberByUserID($user->id);

        $rentDate = $request['rentDate'];
        $roomID = $request['rentRoomID'];
        $rentPeriodID = $request['rentPeriodID'];
        if(array_key_exists("sleep",$request)){
            $sleep = $request['sleep'];
        }else {
            $sleep = 'off';
        }



        $classroomReservedStatus = RentRecordRepo::testNoTransactionAndLockRentRecordbymemID($member->memID, $roomID, $rentPeriodID, $rentDate, $sleep);

        if($classroomReservedStatus == 'SUCCESS'){
            session()->flash('success', '預約完成');
        }else {
            session()->flash('errors', '此時段已被預約');
        }
        return redirect('/memdashboard');
    }

}
