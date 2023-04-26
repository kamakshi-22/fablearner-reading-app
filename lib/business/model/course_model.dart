// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

List<Course> courseFromJson(String str) => List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
    Course({
        required this.id,
        required this.name,
        required this.slug,
        required this.permalink,
        required this.image,
        required this.dateCreated,
        required this.dateCreatedGmt,
        required this.dateModified,
        required this.dateModifiedGmt,
        required this.onSale,
        required this.status,
        required this.content,
        required this.excerpt,
        required this.duration,
        required this.countStudents,
        required this.canFinish,
        required this.canRetake,
        required this.ratakeCount,
        required this.rataken,
        required this.rating,
        required this.price,
        required this.priceRendered,
        required this.originPrice,
        required this.originPriceRendered,
        required this.salePrice,
        required this.salePriceRendered,
        required this.categories,
        required this.tags,
        required this.instructor,
        required this.sections,
        required this.courseData,
        required this.metaData,
    });

    int id;
    String name;
    String slug;
    String permalink;
    String image;
    DateTime dateCreated;
    DateTime dateCreatedGmt;
    DateTime dateModified;
    DateTime dateModifiedGmt;
    bool onSale;
    String status;
    String content;
    String excerpt;
    String duration;
    int countStudents;
    bool canFinish;
    bool canRetake;
    int ratakeCount;
    int rataken;
    bool rating;
    int price;
    String priceRendered;
    int originPrice;
    String originPriceRendered;
    int salePrice;
    String salePriceRendered;
    List<dynamic> categories;
    List<dynamic> tags;
    Instructor instructor;
    List<Section> sections;
    CourseData courseData;
    MetaData metaData;

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        image: json["image"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        onSale: json["on_sale"],
        status: json["status"],
        content: json["content"],
        excerpt: json["excerpt"],
        duration: json["duration"],
        countStudents: json["count_students"],
        canFinish: json["can_finish"],
        canRetake: json["can_retake"],
        ratakeCount: json["ratake_count"],
        rataken: json["rataken"],
        rating: json["rating"],
        price: json["price"],
        priceRendered: json["price_rendered"],
        originPrice: json["origin_price"],
        originPriceRendered: json["origin_price_rendered"],
        salePrice: json["sale_price"],
        salePriceRendered: json["sale_price_rendered"],
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        instructor: Instructor.fromJson(json["instructor"]),
        sections: List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
        courseData: CourseData.fromJson(json["course_data"]),
        metaData: MetaData.fromJson(json["meta_data"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "image": image,
        "date_created": dateCreated.toIso8601String(),
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt.toIso8601String(),
        "on_sale": onSale,
        "status": status,
        "content": content,
        "excerpt": excerpt,
        "duration": duration,
        "count_students": countStudents,
        "can_finish": canFinish,
        "can_retake": canRetake,
        "ratake_count": ratakeCount,
        "rataken": rataken,
        "rating": rating,
        "price": price,
        "price_rendered": priceRendered,
        "origin_price": originPrice,
        "origin_price_rendered": originPriceRendered,
        "sale_price": salePrice,
        "sale_price_rendered": salePriceRendered,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "instructor": instructor.toJson(),
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
        "course_data": courseData.toJson(),
        "meta_data": metaData.toJson(),
    };
}

class CourseData {
    CourseData({
        required this.graduation,
        required this.status,
        required this.startTime,
        this.endTime,
        required this.expirationTime,
        required this.result,
    });

    String graduation;
    String status;
    DateTime startTime;
    dynamic endTime;
    DateTime expirationTime;
    Result result;

    factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        graduation: json["graduation"],
        status: json["status"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: json["end_time"],
        expirationTime: DateTime.parse(json["expiration_time"]),
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "graduation": graduation,
        "status": status,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime,
        "expiration_time": expirationTime.toIso8601String(),
        "result": result.toJson(),
    };
}

class Result {
    Result({
        required this.result,
        required this.pass,
        required this.countItems,
        required this.completedItems,
        required this.items,
        required this.evaluateType,
    });

    double result;
    int pass;
    int countItems;
    int completedItems;
    Items items;
    String evaluateType;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        result: json["result"]?.toDouble(),
        pass: json["pass"],
        countItems: json["count_items"],
        completedItems: json["completed_items"],
        items: Items.fromJson(json["items"]),
        evaluateType: json["evaluate_type"],
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "pass": pass,
        "count_items": countItems,
        "completed_items": completedItems,
        "items": items.toJson(),
        "evaluate_type": evaluateType,
    };
}

class Items {
    Items({
        required this.lesson,
        required this.quiz,
    });

    Lesson lesson;
    Lesson quiz;

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        lesson: Lesson.fromJson(json["lesson"]),
        quiz: Lesson.fromJson(json["quiz"]),
    );

    Map<String, dynamic> toJson() => {
        "lesson": lesson.toJson(),
        "quiz": quiz.toJson(),
    };
}

class Lesson {
    Lesson({
        required this.completed,
        required this.passed,
        required this.total,
    });

    String completed;
    String passed;
    int total;

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        completed: json["completed"],
        passed: json["passed"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "completed": completed,
        "passed": passed,
        "total": total,
    };
}

class Instructor {
    Instructor({
        required this.avatar,
        this.id,
        this.name,
        this.description,
        this.social,
    });

    String avatar;
    int? id;
    String? name;
    String? description;
    Social? social;

    factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        avatar: json["avatar"],
        id: json["id"],
        name: json["name"],
        description: json["description"],
        social: json["social"] == null ? null : Social.fromJson(json["social"]),
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "id": id,
        "name": name,
        "description": description,
        "social": social?.toJson(),
    };
}

class Social {
    Social({
        required this.facebook,
        required this.twitter,
        required this.youtube,
        required this.linkedin,
    });

    String facebook;
    String twitter;
    String youtube;
    String linkedin;

    factory Social.fromJson(Map<String, dynamic> json) => Social(
        facebook: json["facebook"],
        twitter: json["twitter"],
        youtube: json["youtube"],
        linkedin: json["linkedin"],
    );

    Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "youtube": youtube,
        "linkedin": linkedin,
    };
}

class MetaData {
    MetaData({
        required this.lpDuration,
        required this.lpBlockExpireDuration,
        required this.lpBlockFinished,
        required this.lpAllowCourseRepurchase,
        required this.lpCourseRepurchaseOption,
        required this.lpLevel,
        required this.lpStudents,
        required this.lpMaxStudents,
        required this.lpRetakeCount,
        required this.lpHasFinish,
        required this.lpFeatured,
        required this.lpFeaturedReview,
        required this.lpExternalLinkBuyCourse,
        required this.lpRegularPrice,
        required this.lpSalePrice,
        required this.lpSaleStart,
        required this.lpSaleEnd,
        required this.lpNoRequiredEnroll,
        required this.lpRequirements,
        required this.lpTargetAudiences,
        required this.lpKeyFeatures,
        required this.lpFaqs,
        required this.lpCourseResult,
        required this.lpPassingCondition,
        required this.lpCourseAuthor,
    });

    String lpDuration;
    String lpBlockExpireDuration;
    String lpBlockFinished;
    String lpAllowCourseRepurchase;
    String lpCourseRepurchaseOption;
    String lpLevel;
    String lpStudents;
    String lpMaxStudents;
    String lpRetakeCount;
    String lpHasFinish;
    String lpFeatured;
    String lpFeaturedReview;
    String lpExternalLinkBuyCourse;
    String lpRegularPrice;
    String lpSalePrice;
    String lpSaleStart;
    String lpSaleEnd;
    String lpNoRequiredEnroll;
    List<String> lpRequirements;
    List<String> lpTargetAudiences;
    List<String> lpKeyFeatures;
    List<List<String>> lpFaqs;
    String lpCourseResult;
    String lpPassingCondition;
    String lpCourseAuthor;

    factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        lpDuration: json["_lp_duration"],
        lpBlockExpireDuration: json["_lp_block_expire_duration"],
        lpBlockFinished: json["_lp_block_finished"],
        lpAllowCourseRepurchase: json["_lp_allow_course_repurchase"],
        lpCourseRepurchaseOption: json["_lp_course_repurchase_option"],
        lpLevel: json["_lp_level"],
        lpStudents: json["_lp_students"],
        lpMaxStudents: json["_lp_max_students"],
        lpRetakeCount: json["_lp_retake_count"],
        lpHasFinish: json["_lp_has_finish"],
        lpFeatured: json["_lp_featured"],
        lpFeaturedReview: json["_lp_featured_review"],
        lpExternalLinkBuyCourse: json["_lp_external_link_buy_course"],
        lpRegularPrice: json["_lp_regular_price"],
        lpSalePrice: json["_lp_sale_price"],
        lpSaleStart: json["_lp_sale_start"],
        lpSaleEnd: json["_lp_sale_end"],
        lpNoRequiredEnroll: json["_lp_no_required_enroll"],
        lpRequirements: List<String>.from(json["_lp_requirements"].map((x) => x)),
        lpTargetAudiences: List<String>.from(json["_lp_target_audiences"].map((x) => x)),
        lpKeyFeatures: List<String>.from(json["_lp_key_features"].map((x) => x)),
        lpFaqs: List<List<String>>.from(json["_lp_faqs"].map((x) => List<String>.from(x.map((x) => x)))),
        lpCourseResult: json["_lp_course_result"],
        lpPassingCondition: json["_lp_passing_condition"],
        lpCourseAuthor: json["_lp_course_author"],
    );

    Map<String, dynamic> toJson() => {
        "_lp_duration": lpDuration,
        "_lp_block_expire_duration": lpBlockExpireDuration,
        "_lp_block_finished": lpBlockFinished,
        "_lp_allow_course_repurchase": lpAllowCourseRepurchase,
        "_lp_course_repurchase_option": lpCourseRepurchaseOption,
        "_lp_level": lpLevel,
        "_lp_students": lpStudents,
        "_lp_max_students": lpMaxStudents,
        "_lp_retake_count": lpRetakeCount,
        "_lp_has_finish": lpHasFinish,
        "_lp_featured": lpFeatured,
        "_lp_featured_review": lpFeaturedReview,
        "_lp_external_link_buy_course": lpExternalLinkBuyCourse,
        "_lp_regular_price": lpRegularPrice,
        "_lp_sale_price": lpSalePrice,
        "_lp_sale_start": lpSaleStart,
        "_lp_sale_end": lpSaleEnd,
        "_lp_no_required_enroll": lpNoRequiredEnroll,
        "_lp_requirements": List<dynamic>.from(lpRequirements.map((x) => x)),
        "_lp_target_audiences": List<dynamic>.from(lpTargetAudiences.map((x) => x)),
        "_lp_key_features": List<dynamic>.from(lpKeyFeatures.map((x) => x)),
        "_lp_faqs": List<dynamic>.from(lpFaqs.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "_lp_course_result": lpCourseResult,
        "_lp_passing_condition": lpPassingCondition,
        "_lp_course_author": lpCourseAuthor,
    };
}

class Section {
    Section({
        required this.id,
        required this.title,
        required this.courseId,
        required this.description,
        required this.order,
        required this.percent,
        required this.items,
    });

    int id;
    String title;
    int courseId;
    String description;
    String order;
    double percent;
    List<Item> items;

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        title: json["title"],
        courseId: json["course_id"],
        description: json["description"],
        order: json["order"],
        percent: json["percent"]?.toDouble(),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "course_id": courseId,
        "description": description,
        "order": order,
        "percent": percent,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    Item({
        required this.id,
        required this.type,
        required this.title,
        required this.preview,
        required this.duration,
        required this.graduation,
        required this.status,
        required this.locked,
    });

    int id;
    Type type;
    String title;
    bool preview;
    Duration duration;
    Graduation graduation;
    Status status;
    bool locked;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        type: typeValues.map[json["type"]]!,
        title: json["title"],
        preview: json["preview"],
        duration: durationValues.map[json["duration"]]!,
        graduation: graduationValues.map[json["graduation"]]!,
        status: statusValues.map[json["status"]]!,
        locked: json["locked"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": typeValues.reverse[type],
        "title": title,
        "preview": preview,
        "duration": durationValues.reverse[duration],
        "graduation": graduationValues.reverse[graduation],
        "status": statusValues.reverse[status],
        "locked": locked,
    };
}

enum Duration { EMPTY, THE_30_MINS, THE_50_MINS, THE_40_MINS, THE_20_MINS, THE_10_MINS, zero }

final durationValues = EnumValues({
    "": Duration.EMPTY,
    "10 mins": Duration.THE_10_MINS,
    "20 mins": Duration.THE_20_MINS,
    "30 mins": Duration.THE_30_MINS,
    "40 mins": Duration.THE_40_MINS,
    "50 mins": Duration.THE_50_MINS
});

enum Graduation { PASSED, EMPTY }

final graduationValues = EnumValues({
    "": Graduation.EMPTY,
    "passed": Graduation.PASSED
});

enum Status { COMPLETED, EMPTY }

final statusValues = EnumValues({
    "completed": Status.COMPLETED,
    "": Status.EMPTY
});

enum Type { LP_LESSON, LP_QUIZ }

final typeValues = EnumValues({
    "lp_lesson": Type.LP_LESSON,
    "lp_quiz": Type.LP_QUIZ
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
