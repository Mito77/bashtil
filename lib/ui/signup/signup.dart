
import 'package:bashtil/ui/signup/signUp_bloc.dart';
import 'package:bashtil/utilities/CustomText.dart';
import 'package:bashtil/utilities/CustomTextStyle.dart';
import 'package:bashtil/utilities/app_colors.dart';
import 'package:bashtil/widgets/custom_button.dart';
import 'package:bashtil/widgets/custom_text_form_filed.dart';
import 'package:flutter/services.dart';
import 'package:bashtil/bases/bloc_base.dart';
import 'package:bashtil/bases/validator.dart';
import 'package:bashtil/bases/base_state.dart';
import 'package:bashtil/generated/l10n.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpWidget extends BaseStatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends BaseState<SignUpWidget> {
  var h, w ,regularStyle,boldStyle, startDate = '', endDate = '', day = '',password;

  final SignUpBloc _bloc = SignUpBloc();
  final Validator _validator = Validator();
  DateTime now = DateTime.now();
  List<DropdownMenuItem<String>> dropdownItems = [];
List<String> gender =[S.current.male, S.current.female];
  String dropdownValue = "${S.current.nationality}";
  List names = [
    S.current.name,
    S.current.email,
    S.current.password,
    S.current.confirmPassword,
    S.current.gender,
    S.current.birthDay
  ];

  @override
  void initState() {
    super.initState();

    _bloc.init();
    regularStyle = RegularStyle(fontSize: 18.sp, color: blackColor);
    boldStyle = BoldStyle(color: whiteColor, fontSize: 18.sp);
  }

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  Widget getBody(BuildContext context) => blocProvider;

  BlocProvider get blocProvider {
    h = 667.h;
    w = 375.w;
    return BlocProvider(child: screenDesign, bloc: _bloc);
  }

  Widget get screenDesign => SingleChildScrollView(
          child: Container(
            height: h,
            alignment: Alignment.center,
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            // logoWidget(context,true,true,true),
            emailTextForm(S.current.name),
            emailTextForm(S.current.emailAddress),
            passwordTextForm,
            confPasswordTextForm,
            emailTextForm(S.current.nationalID),
            nationalityDropDown,
            inDate(),
            signUpButton,

        ],
      ),
          ));

  StreamBuilder<String> emailTextForm(name) => StreamBuilder(
        builder: (context, snapshot) => Padding(
          padding: EdgeInsets.only(left: w * .04, right: w * .04, top: h * .03),
          child: CustomTextFormFiled(
            labelText: name,
            onChanged: (value) {
              _bloc.updateEmail(value);
            },
            borderColor: greyColor,
            textCapitalization: TextCapitalization.none,
            validator: (value) =>
                _validator.emailValidator(context).call(value),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        stream: _bloc.email,
      );
  StreamBuilder<String> inDate() {
    return StreamBuilder(
      builder: (context, snapshot) => Padding(
        padding: EdgeInsets.only(left: w * .04, right: w * .04, top: h * .03),
        child: Container(
            decoration: BoxDecoration(
              color: whiteColor,
              // color: Styles.TEAL_COLOR.withOpacity(.2),
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: greyColor),
            ),
            height: h * .07,
            padding: EdgeInsetsDirectional.only(
                top: h * .02, start: w * .02, end: w * .02, bottom: h * .02),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: buttonColor, // <-- SEE HERE
                  onPrimary: whiteColor, // <-- SEE HERE
                  onSurface: buttonColor,

                  // <-- SEE HERE
                ),
              ),
              child: Builder(
                builder: (context) => InkWell(
                  child: Row(children: <Widget>[
                    CustomText(
                      customTextStyle:
                      boldStyle,
                      text: '${S.of(context).birthDay} : $startDate',
                    ),
                    Spacer(),
                    Icon(
                      Icons.calendar_today,
                      color: blackColor,
                    )
                  ]),
                  onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 9999999)),
                      lastDate: DateTime.now().add(Duration(days: 99999999999)))
                      .then((value) {
                    setState(() {
                      startDate = '${value!.year}-${value.month}-${value.day}';
                    });

                  }),
                ),
              ),
            )),
      ), stream: null,
    );
  }
  StreamBuilder<bool> get confPasswordTextForm => StreamBuilder<bool>(
        builder: (context, snapshot) => cnofPasswordStream(snapshot.data!),
        initialData: false,
        stream: _bloc.passwordVisibilityBehaviour.stream,
      );

  Widget get nationalityDropDown => StreamBuilder(
    builder: (context, snapshot) => Padding(
        padding:
        EdgeInsets.only(left: w * .04, right: w * .04, top: h * .03),
        child: Container(
          width: w,
          height: h * .06,
          padding: EdgeInsets.only(
              left: 15.0, right: 15.0, top: 13.0, bottom: 13.0),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              border: Border.all(color: greyColor)),
          child: DropdownButton(
            dropdownColor: whiteColor,
            underline: Text(''),
            isExpanded: true,
            hint: CustomText(
              text: dropdownValue,
              customTextStyle:
              boldStyle,
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color:greyColor,
            ),
            items: <String>["مصر","قطر","السعوديه","الامارات"]
                .map((String items) {
              return DropdownMenuItem(
                value: items,
                child: CustomText(
                  text: items,
                  customTextStyle: boldStyle,
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;

              });
            },
          ),
        )), stream: null,

  );

  StreamBuilder<String> cnofPasswordStream(bool showPassword) =>
      StreamBuilder<String>(
        builder: (context, snapshot) => Padding(
          padding: EdgeInsets.only(left: w * .04, right: w * .04, top: h * .03),
          child: CustomTextFormFiled(
            onChanged: (value) {
              _bloc.updatePassword(value);
              password = value;
            },
            validator: (value) =>
                _validator.passwordValidator(context).call(value),
            updatePasswordToggle: (value) {
              _bloc.passwordVisibilityBehaviour.sink.add(value);
            },
            borderColor:greyColor,
            textCapitalization: TextCapitalization.none,
            isPassword: true,
            passwordVisibility: showPassword,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            labelText: "S.of(context).confirmPassword",
          ),
        ),
        stream: _bloc.password,
        initialData: '',
      );

  StreamBuilder<bool> get passwordTextForm => StreamBuilder<bool>(
        builder: (context, snapshot) => passwordStream(snapshot.data!),
        initialData: false,
        stream: _bloc.passwordVisibilityBehaviour.stream,
      );

  StreamBuilder<String> passwordStream(bool showPassword) =>
      StreamBuilder<String>(
        builder: (context, snapshot) => Padding(
          padding: EdgeInsets.only(left: w * .04, right: w * .04, top: h * .03),
          child: CustomTextFormFiled(
            onChanged: (value) {
              _bloc.updatePassword(value);
              password = value;
            },
            validator: (value) =>
                _validator.passwordValidator(context).call(value),
            updatePasswordToggle: (value) {
              _bloc.passwordVisibilityBehaviour.sink.add(value);
            },
            borderColor: greyColor,
            textCapitalization: TextCapitalization.none,
            isPassword: true,
            passwordVisibility: showPassword,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            labelText: S.of(context).password,
          ),
        ),
        stream: _bloc.password,
        initialData: '',
      );

  Widget get signUpButton => Padding(
      padding: EdgeInsets.only(
          top: h * .05, left: w * .04, right: w * .04, bottom: h * .03),
      child: Center(
        child: CustomButton(
          idleText: S.of(context).signup,
          buttonColor: blackColor,
          onTap: (){},
          textSize: 16.sp,
          buttonBehaviour: _bloc.buttonBehavior,
          failedBehaviour: _bloc.failedBehaviour,
          // validateStream: _bloc.validate,
        ),
      ));

  @override
  bool isSafeArea() => false;

  @override
  Future<bool> willPopBack() async => true;


}
